FROM python:3.11-slim
# Set the environment variable to prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install system dependencies
# Use apt-get to install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* 
    
# Copy the requirements.txt contents into the container at /app
COPY requirements.txt .

# Install Python dependencies
# RUN pip install --upgrade && pip install setuptools==80.3.0 asgiref==3.3.1 Django==3.1.4 django-environ==0.4.5 environ==1.0 Pillow==8.0.1 pytz==2020.4 sqlparse==0.4.1
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Migrate the database
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Collect static files
RUN python manage.py collectstatic --noinput


# Expose the port the app runs on
EXPOSE 8000

# Start the Django development server
CMD ["gunicorn", "personalPortfolio.wsgi:application", "--bind", "0.0.0.0:8000"]