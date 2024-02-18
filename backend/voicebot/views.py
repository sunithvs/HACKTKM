import tempfile

import requests
from auth_login.models import User
from config.settings import client_text, GPT_SECRET_KEY
from django.conf import settings
from django.core.files import File
from google.cloud import speech_v1, texttospeech
from googletrans import Translator
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

from .models import VoiceChat
from .serializers import VoiceChatSerializer


# class GPTTranslationAPI(APIView):
#     def post(self, request, *args, **kwargs):
#         try:
#             audio_file = request.FILES.get('audio')  # Assuming the audio file is sent as a POST request
#             print("audio_file", audio_file)
#             # Extract audio transcription
#             transcription = self.extract_audio_transcription(audio_file)
#             print(f"{transcription=}")
#             # Translate transcription to English
#             translator = Translator()
#             english_transcription = translator.translate(transcription, dest='en').text
#
#             # Send to GPT for response
#             gpt_response = self.generate_gpt_response(english_transcription)
#
#             # Translate GPT response back to the local language
#             local_language_response = translator.translate(gpt_response, dest='your_local_language').text
#
#             # Convert the local language response to audio
#             audio_path = self.get_translated_audio(local_language_response)
#
#             return Response({"audio_path": audio_path}, status=status.HTTP_200_OK)
#
#         except Exception as e:
#             return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
#
#     def extract_audio_transcription(self, audio_file):
#         # Configure the Speech client
#         client_speech = speech.SpeechClient.from_service_account_json(settings.GOOGLE_SERVICE_ACCOUNT)
#
#         # Read the audio file content
#         audio_content = audio_file.read()
#
#         # Specify the audio file format and language code
#         audio = speech.RecognitionAudio(content=audio_content)
#         config = speech.RecognitionConfig(
#             encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
#             sample_rate_hertz=16000,  # Adjust based on your audio file properties
#             language_code='your_audio_language_code',  # Replace with the actual language code
#         )
#
#         # Perform speech recognition
#         response = client_speech.recognize(config=config, audio=audio)
#
#         # Extract the transcription
#         if response.results:
#             transcription = response.results[0].alternatives[0].transcript
#             return transcription
#         else:
#             return "No transcription found."
#
#     def generate_gpt_response(self, input_text):
#         generator = pipeline('text-generation', model=TFAutoModelForCausalLM.from_pretrained('EleutherAI/gpt-neo-2.7B'),
#                              tokenizer=AutoTokenizer.from_pretrained('EleutherAI/gpt-neo-2.7B'))
#         gpt_response = generator(input_text, max_length=100)[0]['generated_text']
#
#         return gpt_response
#
#     def get_translated_audio(self, text):
#         pass


class VoiceChatViewSet(viewsets.ModelViewSet):
    queryset = VoiceChat.objects.all()
    serializer_class = VoiceChatSerializer

    def create(self, request, *args, **kwargs):
        try:
            audio_file = request.FILES.get('audio_file')
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(user=User.objects.first())
            # print(audio_file)

            # Extract audio transcription
            transcription = self.extract_audio_transcription(serializer.instance.audio_file)
            print(transcription)
            translator = Translator()

            # Send to GPT for response (you can replace this with your GPT function)
            gpt_response = self.generate_gpt_response(transcription)
            print("got gpt response", gpt_response)
            # # Translate GPT response back to the local language
            local_language_response = translator.translate(gpt_response, dest='ml').text
            print("got local language response", local_language_response)

            #
            # # Save translated response to the voice chat instance
            self.get_translated_audio_tts(local_language_response, serializer)
            print("audio translated")
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def extract_audio_transcription(self, audio_file):

        if not audio_file:
            return Response({'error': 'Audio file not provided.'}, status=400)

        # Google Cloud Speech-to-Text configuration (replace with your GCP project ID and credentials)
        client = speech_v1.SpeechClient.from_service_account_json(settings.GOOGLE_SERVICE_ACCOUNT)
        config = speech_v1.RecognitionConfig(
            encoding=speech_v1.RecognitionConfig.AudioEncoding.MP3,
            language_code='ml-IN',
            sample_rate_hertz=16000,

        )
        audio = speech_v1.RecognitionAudio(content=audio_file.read())
        # Google Cloud Speech-to-Text recognition
        response = client.recognize(config=config, audio=audio)
        print(f"{response = }")
        # Error handling
        if response.results:
            malayalam_text = response.results[0].alternatives[0].transcript
            print(malayalam_text)
        else:
            return Response({'error': 'Error performing speech-to-text.'}, status=500)
        # Google Translate configuration
        english_text = "no content"
        try:
            translator = Translator()

            if malayalam_text is not None:
                translation_result = translator.translate(malayalam_text, dest='en')

                if translation_result is not None and hasattr(translation_result, 'text'):
                    english_text = translation_result.text
                    print("Translation successful:", english_text)
                else:
                    print("Translation result or text attribute is None.")
            else:
                print("Malayalam text is None.")
        except Exception as e:
            print("An error occurred during translation:", e)

        # Return response
        return english_text

    def generate_gpt_response(self, input_text):
        OPENAI_URL = settings.OPENAI_URL
        response = requests.post(OPENAI_URL, json={"input_text": input_text, "api_key": GPT_SECRET_KEY})
        print(response.json().get('gpt_response'))
        if response.status_code != 200:
            return "Error generating GPT response."
        return response.json().get('gpt_response')

    def get_translated_audio_tts(self, text, serializer):
        try:
            # Your code to call the new TTS model using Text-to-Speech API
            temp_file_path = self.get_translated_audio(text)

            # Open the temporary file in binary mode and save it to the voice chat instance
            with open(temp_file_path, 'rb') as audio_file:
                serializer.instance.response_audio_file.save(f"response_audio{serializer.instance.id}.mp3",
                                                             File(audio_file))
                print("Audio file saved successfully.")

            return serializer.instance.response_audio_file.path

        except Exception as e:
            print("An error occurred during TTS audio translation:", e)
            return None

    def get_translated_audio(self, text):
        # Your code for the Text-to-Speech API model
        input = texttospeech.SynthesisInput(text=text)
        voice = texttospeech.VoiceSelectionParams(
            language_code='ml-IN',
            name='ml-IN-Wavenet-C',
            ssml_gender=texttospeech.SsmlVoiceGender.FEMALE,
        )
        audio_config = texttospeech.AudioConfig(
            audio_encoding=texttospeech.AudioEncoding.MP3
        )
        response = client_text.synthesize_speech(
            request={"input": input, "voice": voice, "audio_config": audio_config}
        )

        with tempfile.NamedTemporaryFile(suffix=".mp3", delete=False) as temp_file:
            temp_file.write(response.audio_content)
            temp_file_path = temp_file.name
        print("temp_file_path", temp_file_path)
        return temp_file_path
