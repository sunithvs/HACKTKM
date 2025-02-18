# Generated by Django 4.2.10 on 2024-02-17 06:54

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='PoolingRequest',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('region', models.CharField(max_length=255)),
                ('service_description', models.TextField()),
                ('total_amount_requested', models.DecimalField(decimal_places=2, max_digits=10)),
                ('is_fulfilled', models.BooleanField(default=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('name', models.CharField(max_length=255)),
                ('product_link', models.URLField(max_length=255)),
                ('image', models.ImageField(blank=True, null=True, upload_to='pooling')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='UserContribution',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('contribution_date', models.DateTimeField(auto_now_add=True)),
                ('pooling_request', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='donation_set', to='pooling.poolingrequest')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
