from django.db import models

# Create your models here.
days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',
        'Sunday']
food_items = ['Meals', 'Masala Dosa', 'Uzhunnu Vada', 'Puri Masala', 'Biriyani', 'Parippu Vada',
              'Puttum Kadala']


class PredictionRequest(models.Model):
    day = models.CharField(max_length=255, choices=[(day, day) for day in days])
    events = models.BooleanField(default=False)
    event_size = models.PositiveIntegerField(default=0)
    festival = models.BooleanField(default=False)

    def ingredients(self):
        result = {}
        for prediction in self.predictions.all():
            for ingredient, quantity in prediction.ingredients().items():
                if ingredient in result:
                    result[ingredient] += quantity
                else:
                    result[ingredient] = quantity
        return result

class Prediction(models.Model):
    food_item = models.CharField(max_length=255, choices=[(item, item) for item in food_items])
    n_customers = models.PositiveIntegerField(default=0)
    prediction_request = models.ForeignKey(PredictionRequest, on_delete=models.CASCADE, related_name='predictions')

    def ingredients(self):
        result = {}
        for ingredient in FoodItemIngredient.objects.filter(food_item=self.food_item):
            result[ingredient.ingredient] = ingredient.quantity * self.n_customers
        return result


class FoodItemIngredient(models.Model):
    food_item = models.CharField(max_length=255, choices=[(item, item) for item in food_items])
    ingredient = models.CharField(max_length=255)
    quantity = models.FloatField()
    unit = models.CharField(max_length=255, choices=[('kg', 'kg'), ('l', 'l'), ('units', 'units')])

    class Meta:
        unique_together = ['food_item', 'ingredient']
