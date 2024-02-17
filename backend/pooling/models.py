from auth_login.models import User
from django.contrib.gis.db import models
from django.db.models import Sum


class PoolingRequest(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    region = models.CharField(max_length=255)
    service_description = models.TextField()
    total_amount_requested = models.DecimalField(max_digits=10, decimal_places=2)
    is_fulfilled = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=255)
    product_link = models.URLField(max_length=255)
    image = models.ImageField(upload_to="pooling", blank=True, null=True)
    location = models.PointField(blank=True, null=True)


    @property
    def total_amount_received(self):
        # Calculate the total amount received for the pooling request
        return self.donation_set.aggregate(Sum('amount'))['amount__sum'] or 0

    @property
    def remaining_amount_to_be_pooled(self):
        # Calculate the remaining amount to be pooled to meet the total requested amount
        return max(0, self.total_amount_requested - self.total_amount_received)

    def save(self, *args, **kwargs):
        # Update is_fulfilled based on the current and total amounts
        self.is_fulfilled = self.total_amount_received >= self.total_amount_requested
        super().save(*args, **kwargs)


class UserContribution(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    contribution_date = models.DateTimeField(auto_now_add=True)
    pooling_request = models.ForeignKey(PoolingRequest, on_delete=models.CASCADE, related_name='donation_set')
