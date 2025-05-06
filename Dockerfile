FROM python:3.11-slim

WORKDIR /opt/project

# Install system dependencies if needed (e.g., gcc for some Python packages)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy Django project
WORKDIR /opt/project/django_project
COPY django_project .

# Expose and run
EXPOSE 5000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:5000"]
