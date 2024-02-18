
from django.contrib import admin

from .models import PoolingRequest, UserContribution


@admin.register(PoolingRequest)
class PoolingRequestAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'region', 'service_description', 'total_amount_requested', 'is_fulfilled',
                    'created_at']
    search_fields = ['user__username', 'region', 'service_description']
    list_filter = ['is_fulfilled', 'created_at']


@admin.register(UserContribution)
class UserContributionAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'amount', 'contribution_date', 'pooling_request']
    search_fields = ['user__username', 'pooling_request__service_description']
    list_filter = ['contribution_date']
