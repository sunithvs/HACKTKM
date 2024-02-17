from rest_framework import serializers

from auth_login.models import User
from voicebot.models import VoiceChat


class VoiceChatSerializer(serializers.ModelSerializer):
    class Meta:
        model = VoiceChat
        fields = ['id', 'user', 'audio_file', 'response_audio_file', 'timestamp']
        read_only_fields = ['id', 'timestamp', 'response_audio_file', 'user']

