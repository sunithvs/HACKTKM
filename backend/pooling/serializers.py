from auth_login.models import User
from auth_login.serializers import UserSerializer
from rest_framework import serializers

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

    class Meta:
        model = PoolingRequest
        fields = ['id', 'name', 'user', 'region', 'service_description', 'total_amount_requested',
                  'is_fulfilled', 'created_at', 'total_amount_received', 'remaining_amount_to_be_pooled', 'donations',
                  'image']
        read_only_fields = ['is_fulfilled', 'total_amount_received', 'remaining_amount_to_be_pooled']

    def create(self, validated_data):
        # If the request is made by an authenticated user, use that user
        user = self.context['request'].user if self.context['request'].user.is_authenticated else None

        # If the user is not authenticated and no user is provided, create a new user
        if not user and not validated_data.get('user'):
            user = User.objects.filter().first()

        validated_data['user'] = user
        return super().create(validated_data)
