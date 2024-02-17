from django.urls import path, include
from rest_framework.routers import DefaultRouter

from .views import VoiceChatViewSet

router = DefaultRouter()
router.register("chat", VoiceChatViewSet, basename='voice-chat')
urlpatterns = [
    path('', include(router.urls)),
]
