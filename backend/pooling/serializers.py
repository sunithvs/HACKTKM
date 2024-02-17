from django.contrib.gis.geos import Point
from rest_framework import serializers

from auth_login.models import User
from auth_login.serializers import UserSerializer
from .models import PoolingRequest, UserContribution


class UserContributionSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserContribution
        fields = ['id', 'user', 'amount', 'contribution_date']


class PoolingRequestSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    donations = UserContributionSerializer(many=True, read_only=True, source='donation_set')

    total_amount_received = serializers.DecimalField(max_digits=10, decimal_places=2, read_only=True)
    remaining_amount_to_be_pooled = serializers.DecimalField(max_digits=10, decimal_places=2, read_only=True)
    location_lat = serializers.FloatField(source='location.y', write_only=True)
    location_long = serializers.FloatField(source='location.x', write_only=True)

    class Meta:
        model = PoolingRequest
        fields = ['id', 'name', 'user', 'region', 'service_description', 'total_amount_requested',
                  'is_fulfilled', 'created_at', 'total_amount_received', 'remaining_amount_to_be_pooled', 'donations',
                  'image', 'location_lat', 'location_long']
        read_only_fields = ['is_fulfilled', 'total_amount_received', 'remaining_amount_to_be_pooled']

    def validate_location_data(self, lat, long, srid=4326):
        # Validate and convert the input location to a GEOSGeometry object
        try:
            location = Point(long, lat, srid=srid)
        except (ValueError, TypeError, KeyError):
            raise serializers.ValidationError("Invalid location format. Please provide 'lat', 'long', and 'srid'.")

        return location

    def create(self, validated_data):
        # If the request is made by an authenticated user, use that user
        user = self.context['request'].user if self.context['request'].user.is_authenticated else None
        location_data_lat = validated_data.pop('location_lat', None)
        location_data_long = validated_data.pop('location_long', None)

        if location_data_lat and location_data_long:
            validated_data['location'] = self.validate_location_data(location_data_lat, location_data_long)
        else:
            validated_data['location'] = Point(0, 0, srid=4326)
        # If the user is not authenticated and no user is provided, create a new user
        if not user and not validated_data.get('user'):
            user = User.objects.filter().first()

        validated_data['user'] = user
        return super().create(validated_data)

    def to_representation(self, instance):
        # Convert the location to a dictionary with 'lat', 'long', and 'srid' fields
        representation = super().to_representation(instance)

        representation['location'] = {
            'lat': instance.location.y if instance.location else 0,
            'long': instance.location.x if instance.location else 0,
            'srid': instance.location.srid if instance.location else 0
        }
        return representation
