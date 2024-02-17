from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import PoolingRequestViewSet

router = DefaultRouter()
router.register(r'pooling-items', PoolingRequestViewSet, basename='poolingitems')

urlpatterns = [
    path('', include(router.urls)),
]
