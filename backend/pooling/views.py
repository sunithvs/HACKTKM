from rest_framework import viewsets, filters
from rest_framework.pagination import PageNumberPagination

from .models import PoolingRequest
from .serializers import PoolingRequestSerializer


# Create your views here.

class PoolingRequestPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 100


class PoolingRequestViewSet(viewsets.ModelViewSet):
    queryset = PoolingRequest.objects.all()
    serializer_class = PoolingRequestSerializer
    pagination_class = PoolingRequestPagination
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['region', 'service_description', 'product_name']
    ordering_fields = ['region', 'total_amount_requested', 'created_at']
    ordering = ['-created_at']
    filter_fields = ['region', 'total_amount_requested', 'is_fulfilled']
