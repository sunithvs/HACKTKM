from django.contrib import admin

from .models import Category, RentalItem, RentalService


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    list_filter = ('name',)
    search_fields = ('name',)


@admin.register(RentalItem)
class RentalItemAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'available_quantity', 'rental_price_per_day', 'category', 'location')
    list_filter = ('category__name', 'location')
    search_fields = ('name', 'category__name')


@admin.register(RentalService)
class RentalServiceAdmin(admin.ModelAdmin):
    list_display = ('id', 'rental_item', 'start_date', 'end_date', 'quantity', 'total_price')
    list_filter = ('rental_item__name', 'start_date', 'end_date')
    search_fields = ('rental_item__name',)
