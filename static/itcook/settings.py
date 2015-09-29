"""
Django settings for itcook project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(__file__))
print BASE_DIR


SECRET_KEY = '+5a#6nix6qh6elj9h%-o0qf@9w92fs!9d3mt-6ims&h-(c_1rh'

DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []

SITE_ID = 1


INSTALLED_APPS = (
    'django.contrib.admin', # admin module
    'django.contrib.auth',   # admin module
    'django.contrib.contenttypes',   # admin module
    'django.contrib.sessions',   # admin module
    'django.contrib.messages',   # admin module
    'django.contrib.staticfiles', # app for managament static files
    'django.contrib.comments',
    'django.contrib.sites',
    'pagedown',# App for adding markdown preview to the django admin
    'pagination', # The application to index articles on the output page
    'articles',  # MY application
    'jquery',
    'disqus',
    'ckeditor',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
#     'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)


TEMPLATE_CONTEXT_PROCESSORS = (
    "django.contrib.auth.context_processors.auth",
    "django.core.context_processors.debug",
    "django.core.context_processors.i18n",
    "django.core.context_processors.media",
    "django.core.context_processors.static",
    "django.core.context_processors.tz",
    "django.contrib.messages.context_processors.messages",
    "django.core.context_processors.request",
)
STATICFILES_FINDERS = (
        'django.contrib.staticfiles.finders.FileSystemFinder',
        'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    #    'django.contrib.staticfiles.finders.DefaultStorageFinder',
    )

ROOT_URLCONF = 'itcook.urls'

WSGI_APPLICATION = 'itcook.wsgi.application'


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
	'NAME' : 'itcook',
		'USER': 'root',
		'PASSWORD' : 'TrustPoint85',
		'HOST':'localhost',
	'PORT' : '3306',
		
	
    }
}

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'Europe/Kiev'

USE_I18N = True

USE_L10N = True

USE_TZ = True


STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

CKEDITOR_UPLOAD_PATH = "uploads/"
CKEDITOR_JQUERY_URL = '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js'
CKEDITOR_IMAGE_BACKEND = 'Pillow'

ADMINS = (
        ('Mykola Hromivchuk', 'mhromivchuk@gmail.com'),
    )

MANAGERS = ADMINS

DEFAULT_FROM_EMAIL = 'mhromivchuk@gmail.com	'

STATICFILES_DIRS = (
        os.path.join(BASE_DIR),
    )
TEMPLATE_DIRS = (os.path.join(BASE_DIR, 'templates'),
                 os.path.join(BASE_DIR),)

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
    }
}


CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    }
}
