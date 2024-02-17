from rest_framework import serializers

from auth_login.models import User
from inventory.models import Category, Product


class ProductCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id', 'name']


class ProductSerializer(serializers.ModelSerializer):
    category = ProductCategorySerializer()
    category_name = serializers.CharField(source='category.name')


    class Meta:
        model = Product
        fields = ['id', 'name', 'description', 'category', 'farmer', 'quantity', 'unit_price', 'image', 'category_name']
        read_only_fields = ['farmer', 'category_name']

    def create(self, validated_data):
        # Extract the farmer from the context or use the first user in the database
        farmer = self.context['request'].user if self.context['request'].user.is_authenticated else None

        if not farmer:
            try:
                farmer = User.objects.first()
                print(farmer, "farmer")
            except User.DoesNotExist:
                raise serializers.ValidationError("No users available in the database.")

        # Create the product with the associated farmer
        validated_data['category'] = validated_data['category']['name']
        product = Product.objects.create(farmer=farmer, **validated_data)

        return product

    def validate_category_name(self, value):
        # Strip and lowercase the category name
        stripped_lowered_value = value.strip().lower()

        # Get existing category or create a new one
        category, created = Category.objects.get_or_create(name=stripped_lowered_value)

        # If a new category is created, save it
        if created:
            category.save()
        print("category is ", category)
        return category
