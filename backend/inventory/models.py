from django.db import models

from auth_login.models import User


class Category(models.Model):
    name = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.name


class Product(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    farmer = models.ForeignKey(User, on_delete=models.CASCADE)  # Assuming farmer is a user

    quantity = models.PositiveIntegerField(default=0)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    image = models.ImageField(upload_to="products", blank=True, null=True)

    def __str__(self):
        return f"{self.farmer.full_name} - {self.name} - {self.quantity} units"
