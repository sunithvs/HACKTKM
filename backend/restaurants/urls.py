from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import PredictionRequestViewSet, FoodItemIngredientViewSet

router = DefaultRouter()
router.register(r'predictions', PredictionRequestViewSet, basename='prediction')
router.register(r'ingredients', FoodItemIngredientViewSet, basename='ingredient')

urlpatterns = [
    path('', include(router.urls)),
]
