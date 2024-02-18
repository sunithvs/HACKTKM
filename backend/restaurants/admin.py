from django.contrib import admin

# Register your models here.
from .models import PredictionRequest, Prediction, FoodItemIngredient

admin.site.register(PredictionRequest)
admin.site.register(Prediction)
admin.site.register(FoodItemIngredient)
