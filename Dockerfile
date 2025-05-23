FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements-app.txt ./

RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt

COPY . .

RUN python scripts/download_model.py --models all

EXPOSE 8080

CMD python3 deploy_api.py
