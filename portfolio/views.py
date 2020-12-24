from django.shortcuts import render
from .models import Project

def home(request):
    projetcs = Project.objects.all()
    return render(request, 'portfolio/home.html', {'projects':projetcs})
