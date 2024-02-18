import requests
from rest_framework import serializers

from auth_login.models import User
from config.settings import ONDC_API_URL
from inventory.models import Category, Product


def add_product_to_ondc(product):
    prod = {
        "product": {
            "product_id": product.id,
            "name": product.name,
            "description": product.description,
            "category": "Agriculture",
            "brand": "Framsta",
            "price": product.unit_price,
            "currency": "INR",
            "availability": "In Stock",
            "attributes": {
                "color": "Black",
                "weight": "1.5 kg",
                "dimensions": "10x8x3 inches"
            },
            "images": [
                product.image.url
            ],
            "seller": {
                "seller_id": "Framsta",
                "seller_name": "framsta",
                "contact": {
                    "email": "framsta@lamsta.com",
                    "phone": "90822727272"
                },
                "address": {
                    "city": "Cusat",
                    "state": "Kerala",
                    "country": "India",
                    "pincode": "123456"
                }
            }
        }
    }
    try:
        requests.post(
            ONDC_API_URL,
            json=prod
        )
    except requests.exceptions.RequestException as e:
        print(e)
    except Exception as e:
        print(e)


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
        try:
            add_product_to_ondc(product)
        except Exception as e:
            print(e)
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
