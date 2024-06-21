from django.urls import path
from .views import SampleTemplateView

urlpatterns = [
    path('index', SampleTemplateView.as_view()),
]
