from rest_framework import viewsets

from restaurants.models import Prediction
from restaurants.serializers import PredictionRequestSerializer


class PredictionRequestViewSet(viewsets.ModelViewSet):
    queryset = Prediction.objects.all()
    serializer_class = PredictionRequestSerializer
