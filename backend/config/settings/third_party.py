"""

"""

import os

from google.auth import load_credentials_from_file
from google.cloud import speech, texttospeech

from .base import *

REST_FRAMEWORK = {
    'DEFAULT_FILTER_BACKENDS': ['django_filters.rest_framework.DjangoFilterBackend'],
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 100,
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle'
    ],
    'DEFAULT_THROTTLE_RATES': {
        'anon': '30000/day',
        'user': '20000/day',
        'user_sec': '2/second',
        'user_min': '30/minute',
        'user_hour': '200/hour',
        'user_day': '2000/day',
    },
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.AllowAny',
    ),
    'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser',
    ),
    'DEFAULT_SCHEMA_CLASS': 'rest_framework.schemas.coreapi.AutoSchema'
}

SWAGGER_SETTINGS = {
    'JSON_EDITOR': True,
    'SECURITY_DEFINITIONS': {
        'Bearer': {
            'type': 'apiKey',
            'name': 'Authorization',
            'in': 'header'
        }
    }
}

# jasmin settings


JAZZMIN_SETTINGS = {
    # title of the window (Will default to current_admin_site.site_title if absent or None)
    "site_title": "django",

    # Title on the login screen (19 chars max) (defaults to current_admin_site.site_header if absent or None)
    "site_header": 'Dashboard',

    # Title on the brand (19 chars max) (defaults to current_admin_site.site_header if absent or None)
    "site_brand": "Django",

    # Logo to use for your site, must be present in static files, used for brand on top left
    "site_logo": "img/logo.png",

    # CSS classes that are applied to the logo above
    "site_logo_classes": "img-circle",

    # Relative path to a favicon for your site, will default to site_logo if absent (ideally 32x32 px)
    "site_icon": None,

    # Welcome text on the login screen
    "welcome_sign": "Welcome to eventsradar",

    # Copyright on the footer
    # "copyright": f"all rights reserved to {APPLICATION_NAME}",

    # The model admin to search from the search bar, search bar omitted if excluded
    "search_model": "auth.User",

    # Field name on user model that contains avatar ImageField/URLField/Charfield or a callable that receives the user
    "user_avatar": None,

    ############
    # Top Menu #
    ############

    # Links to put along the top menu
    "topmenu_links": [

        # Url that gets reversed (Permissions can be added)
        {"name": "Dashboard", "url": "admin:index", "permissions": ["auth.view_user"]},

        # external url that opens in a new window (Permissions can be added)
        # model admin to link to (Permissions checked against model)
        {"model": "auth.User"},
        {"name": "logs", "url": f"/{ADMIN_URL}log_viewer/"},
        {"name": "requests", "url": f"/{ADMIN_URL}request-viewer/"},
        # App with dropdown menu to all its models pages (Permissions checked against models)
        {"app": "university"},
    ],

    #############
    # User Menu #
    #############

    # # Additional links to include in the user menu on the top right ("app" url type is not allowed)
    "usermenu_links": [
        {"name": "logs", "url": f"/{ADMIN_URL}log_viewer/",
         "icon": "fas fa-comments", },
        {"name": "requests", "url": f"/{ADMIN_URL}request-viewer/",
         "icon": "fas fa-comments", },
        {"model": "auth.user"}
    ],

    #############
    # Side Menu #
    #############

    # Whether to display the side menu
    "show_sidebar": True,

    # Whether to aut expand the menu
    "navigation_expanded": True,

    # Hide these apps when generating side menu e.g (auth)
    "hide_apps": [],

    # Hide these models when generating side menu (e.g auth.user)
    "hide_models": [],

    # List of apps (and/or models) to base side menu ordering off of (does not need to contain all apps/models)
    # "order_with_respect_to": ["auth", "books", "books.author", "books.book"],

    # Custom links to append to app groups, keyed on app name
    # "custom_links": {
    #     "books": [{
    #         "name": "Make Messages",
    #         "url": "make_messages",
    #         "icon": "fas fa-comments",
    #         "permissions": ["books.view_book"]
    #     }]
    # },

    # for the full list of 5.13.0 free icon classes
    "icons": {
        "auth": "fas fa-users-cog",
        "auth_login.User": "fas fa-user",
        "auth.Group": "fas fa-users",
    },
    # Icons that are used when one is not manually specified
    "default_icon_parents": "fas fa-chevron-circle-right",
    "default_icon_children": "fas fa-circle",

    #################
    # Related Modal #
    #################
    # Use modals instead of popups
    "related_modal_active": False,

    #############
    # UI Tweaks #
    #############
    # Relative paths to custom CSS/JS scripts (must be present in static files)
    "custom_css": None,
    "custom_js": None,
    # Whether to show the UI customizer on the sidebar
    "show_ui_builder": False,

    ###############
    # Change view #
    ###############
    # Render out the change view as a single form, or in tabs, current options are
    # - single
    # - horizontal_tabs (default)
    # - vertical_tabs
    # - collapsible
    # - carousel
    "changeform_format": "horizontal_tabs",
    # override change forms on a per modeladmin basis
    "changeform_format_overrides": {"auth.user": "collapsible", "auth.group": "vertical_tabs"},
    # Add a language dropdown into the admin
    # "language_chooser": True,
}

JAZZMIN_UI_TWEAKS = {
    "theme": "solar",
}

LOG_VIEWER_FILES = ['auth.log', 'farmer.log', 'default.log']
LOG_VIEWER_FILES_PATTERN = '*'
LOG_VIEWER_FILES_DIR = os.path.join(BASE_DIR, 'logs')
LOG_VIEWER_MAX_READ_LINES = 1000  # total log lines will be read
LOG_VIEWER_PAGE_LENGTH = 25  # total log lines per-page
LOG_VIEWER_PATTERNS = [']OFNI[', ']GUBED[', ']GNINRAW[', ']RORRE[', ']LACITIRC[']

# Optionally you can set the next variables in order to customize the admin:

LOG_VIEWER_FILE_LIST_TITLE = "Log files"
LOG_VIEWER_FILE_LIST_STYLES = "/static/css/logs.css"
LOGGING_ROOT = os.path.join(BASE_DIR, 'logs')
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'mail_admins': {
            'level': 'INFO',
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'standard'
        },
        'farmer': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 'farmer.log'),
            'maxBytes': 1024 * 1024 * 15,  # 5MB
            'backupCount': 0,
            'formatter': 'standard',
        },
        'auth': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 'auth.log'),
            'maxBytes': 1024 * 1024 * 15,  # 5MB
            'backupCount': 0,
            'formatter': 'standard',
        },
        'default': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 'default.log'),
            'maxBytes': 1024 * 1024 * 15,  # 5MB
            'backupCount': 0,
            'formatter': 'standard',
        },
        'request_handler': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 'auth.log'),
            'maxBytes': 1024 * 1024 * 5,  # 5 MB
            'backupCount': 5,
            'formatter': 'standard',
        },

    },
    'formatters': {
        'standard': {
            'format': "[%(levelname)s] [%(asctime)s] [%(name)s:%(lineno)s] %(message)s",
            'datefmt': "%d/%b/%Y %H:%M:%S"
        },
    },
    'loggers': {
        '': {
            'handlers': ['console', 'default'],
            'level': 'INFO',
            'propagate': True,
        },
        'farmer': {
            'handlers': ['console', 'farmer'],
            'level': 'INFO',
            'propagate': False,
        },
        'auth': {
            'handlers': ['console', 'auth'],
            'level': 'INFO',
            'propagate': False,
        },
        'django.request': {
            'handlers': ['request_handler'],
            'level': 'DEBUG',
            'propagate': False
        },
    }
}

GOOGLE_SERVICE_ACCOUNT = os.path.join(BASE_DIR, 'google_cloud.json')

credentials, project_id = load_credentials_from_file(GOOGLE_SERVICE_ACCOUNT)
client_file = os.getenv("GOOLGE_SERVICE_ACCOUNT")

client_speech = speech.SpeechClient(credentials=credentials)
client_text = texttospeech.TextToSpeechClient(credentials=credentials)
OPENAI_SECRET_KEY = env.str("OPENAPI_SECRET_KEY",
                            default="django-insecure-cag@!muz(kv)t31hxk6w3b)^vzt62_n1wo8&@89)ueefs6p4-7")
OPENAI_URL = "http://farmer.radr.in/gpt/"
GPT_SECRET_KEY = env.str("GGPT_SECRET_KEY", "1234")
ONDC_API_URL = "https://farmer.radr.in/ondc/"
