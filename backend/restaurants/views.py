from rest_framework import viewsets

from restaurants.models import Prediction, PredictionRequest
from restaurants.serializers import PredictionRequestSerializer


class PredictionRequestViewSet(viewsets.ModelViewSet):
    queryset = PredictionRequest.objects.all()
    serializer_class = PredictionRequestSerializer

class FoodItemIngredientViewSet(viewsets.ModelViewSet):
    queryset = Prediction.objects.all()
    serializer_class = PredictionRequestSerializer
#
