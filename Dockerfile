# EXP-LINK v3.0 - UNSHACKLED UNIVERSAL MEDIA EXTRACTOR
# Dockerfile created by xspeen
# Repository: https://github.com/xspeen/EXP-LINK-UNSHACKLED.git

FROM python:3.10-slim

LABEL maintainer="xspeen"
LABEL version="3.0"
LABEL description="EXP-LINK UNSHACKLED - Universal Media Extractor that bypasses private/premium content restrictions"
LABEL org.opencontainers.image.source="https://github.com/xspeen/EXP-LINK-UNSHACKLED"
LABEL org.opencontainers.image.description="NO LIMITS - Downloads ANYTHING including private/premium content"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install yt-dlp from master (latest version with all bypass capabilities)
RUN pip install https://github.com/yt-dlp/yt-dlp/archive/master.tar.gz --upgrade --no-cache-dir

# Install additional dependencies for private content bypass
RUN pip install --no-cache-dir \
    browser-cookie3 \
    pycryptodomex \
    websockets \
    mutagen \
    urllib3

# Copy application files
COPY exp-link.py .
COPY install.sh .
RUN chmod +x install.sh exp-link.py

# Create download directory
RUN mkdir -p /downloads/EXP-LINK_Videos
VOLUME ["/downloads"]

# Set environment variables
ENV EXP_LINK_DIR=/downloads/EXP-LINK_Videos
ENV PYTHONUNBUFFERED=1

# Create entrypoint script for better UX
RUN echo '#!/bin/bash\n\
if [ $# -eq 0 ]; then\n\
    python3 /app/exp-link.py\n\
else\n\
    python3 /app/exp-link.py "$@"\n\
fi' > /entrypoint.sh && chmod +x /entrypoint.sh

# Run application
ENTRYPOINT ["/entrypoint.sh"]
CMD []
