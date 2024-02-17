from django.utils import timezone
from rest_framework import serializers

from .models import Category, RentalItem, RentalService


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id', 'name']


class RentalItemSerializer(serializers.ModelSerializer):
    category_name = serializers.CharField(write_only=True, source='category.name')

    category = CategorySerializer(read_only=True)
    stock_available = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = RentalItem
        fields = ['id', 'name', 'description', 'available_quantity', 'rental_price_per_day', 'category', 'location',
                  'stock_available', 'category_name']

    def get_stock_available(self, obj):
        return obj.available_quantity > 0

    def validate_rental_price_per_day(self, value):
        if value <= 0:
            raise serializers.ValidationError("Rental price per day must be greater than zero.")
        return value

    def validate_category_name(self, value):
        # Strip and lowercase the category name
        stripped_lowered_value = value.strip().lower()

        # Get existing category or create a new one
        category, created = Category.objects.get_or_create(name=stripped_lowered_value)

        # If a new category is created, save it
        if created:
            category.save()

        return category

    def create(self, validated_data):
        # Extract the category_name from the validated data
        category_name = validated_data.pop('category_name', None)

        # Create the RentalItem instance without the category_name
        rental_item = RentalItem.objects.create(**validated_data)

        # If category_name is provided, set it for the RentalItem
        if category_name:
            rental_item.category = category_name

        rental_item.save()

        return rental_item


class RentalServiceSerializer(serializers.ModelSerializer):
    rental_item = RentalItemSerializer()

    class Meta:
        model = RentalService
        fields = ['id', 'rental_item', 'start_date', 'end_date', 'quantity', 'total_price']

    def validate_quantity(self, value):
        if value <= 0:
            raise serializers.ValidationError("Quantity must be greater than zero.")
        return value

    def validate_start_date(self, value):
        # Add custom validation logic for start date
        # For example, ensure start date is not in the past
        if value < timezone.now().date():
            raise serializers.ValidationError("Start date cannot be in the past.")
        return value

    def validate_end_date(self, value):
        # Add custom validation logic for end date
        # For example, ensure end date is after start date
        start_date = self.initial_data['start_date'] if 'start_date' in self.initial_data else self.instance.start_date
        if value <= start_date:
            raise serializers.ValidationError("End date must be after start date.")
        return value
