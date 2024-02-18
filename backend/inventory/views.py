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

