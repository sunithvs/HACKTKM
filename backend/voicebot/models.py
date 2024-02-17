from django.db import models

from auth_login.models import User  # Adjust the import based on your user model


class VoiceChat(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True)
    audio_file = models.FileField(upload_to='voice_chats/')
    response_audio_file = models.FileField(upload_to='voice_chats/', blank=True, null=True)
    timestamp = models.DateTimeField(auto_now_add=True)


