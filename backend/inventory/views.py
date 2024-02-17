# Create your views here.
from rest_framework import viewsets, serializers

from auth_login.models import User
from .models import Product, Category
from .serializer import ProductSerializer, ProductCategorySerializer


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = ProductCategorySerializer


class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def perform_create(self, serializer):
        # Associate the product with the authenticated user or the first user in the database
        farmer = self.request.user if self.request.user.is_authenticated else None

        if not farmer:
            try:
                farmer = User.objects.first()
            except User.DoesNotExist:
                raise serializers.ValidationError("No users available in the database.")

        serializer.save(farmer=farmer)
