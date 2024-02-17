from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import RentalItemViewSet, RentalServiceViewSet, CategoryViewSet

router = DefaultRouter()
router.register(r'rental-items', RentalItemViewSet, basename='rentalitem')
router.register(r'rental-services', RentalServiceViewSet, basename='rentalservice')
router.register(r'rental-categories', CategoryViewSet, basename='rentalcategory')

urlpatterns = [
    path('', include(router.urls)),
]
