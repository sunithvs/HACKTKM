from rest_framework import serializers

from .models import PredictionRequest, Prediction, food_items, FoodItemIngredient
from .utils import predict_customers


class PredictionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Prediction
        fields = ['id', 'food_item', 'n_customers']
        read_only_fields = ['n_customers']


class PredictionRequestSerializer(serializers.ModelSerializer):
    predictions = PredictionSerializer(many=True, read_only=True)

    ingredients = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = PredictionRequest
        fields = ['id', 'day', 'events', 'event_size', 'festival', 'predictions', 'ingredients']

    def create(self, validated_data):
        # Create the prediction request
        prediction_request = PredictionRequest.objects.create(**validated_data)

        # Get the predictions
        predictions = []
        for food_item in food_items:
            n_customers = predict_customers(prediction_request.day, food_item, prediction_request.events,
                                            prediction_request.event_size, prediction_request.festival)
            prediction = Prediction.objects.create(food_item=food_item, n_customers=n_customers,
                                                   prediction_request=prediction_request)
            predictions.append(prediction)

        # Return the prediction request
        return prediction_request

    def get_ingredients(self, obj):
        return obj.ingredients()


class FoodItemIngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodItemIngredient
        fields = ['id', 'food_item', 'ingredient', 'quantity', 'unit']
        read_only_fields = ['id']
