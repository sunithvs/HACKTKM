# myapp/urls.py
from django.urls import path
from .views import GPTTranslationAPI

urlpatterns = [
    path('chat/', GPTTranslationAPI.as_view(), name='gpt_translation_api'),
]
