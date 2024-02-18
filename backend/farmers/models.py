from django.contrib.gis.db import models


class Category(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class RentalItem(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    available_quantity = models.PositiveIntegerField()
    rental_price_per_day = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    location = models.PointField(null=True, blank=True)
    image = models.ImageField(upload_to="farmer", blank=True, null=True)

    def __str__(self):
        return self.name


class RentalService(models.Model):
    rental_item = models.ForeignKey(RentalItem, on_delete=models.CASCADE, related_name='rental_services')
    start_date = models.DateField()
    end_date = models.DateField()
    quantity = models.PositiveIntegerField()
    total_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)

    def save(self, *args, **kwargs):
        # Calculate total price based on quantity and rental prices
        self.total_price = self.rental_item.rental_price_per_day * self.quantity
        super(RentalService, self).save(*args, **kwargs)

    def __str__(self):
        return f"RentalService #{self.id} - {self.rental_item} - {self.start_date} to {self.end_date}"
