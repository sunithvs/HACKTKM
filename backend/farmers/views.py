from rest_framework import viewsets, filters
from rest_framework.pagination import PageNumberPagination

from .models import Category, RentalItem, RentalService
from .serializers import CategorySerializer, RentalItemSerializer, RentalServiceSerializer


# Create your views here.
class CategoryPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 100


class RentalItemPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 100


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = CategoryPagination
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']


class RentalItemViewSet(viewsets.ModelViewSet):
    queryset = RentalItem.objects.all()
    serializer_class = RentalItemSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name', 'description', 'category__name']
    ordering_fields = ['name', 'rental_price_per_day', 'available_quantity']
    ordering = ['name']
    filter_fields = ['category__name', 'available_quantity', 'rental_price_per_day']


class RentalServiceViewSet(viewsets.ModelViewSet):
    queryset = RentalService.objects.all()
    serializer_class = RentalServiceSerializer
    pagination_class = RentalItemPagination
