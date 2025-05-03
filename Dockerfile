# -------- Base Stage --------
    FROM python:3.12-bookworm AS base

    # Environment variables
    ENV PYTHONUNBUFFERED=1 \
        PYTHONFAULTHANDLER=1 \
        PIP_NO_CACHE_DIR=true \
        PIP_DEFAULT_TIMEOUT=100 \
        PIP_DISABLE_PIP_VERSION_CHECK=on \
        QR_CODE_DIR=/myapp/qr_codes
    
    WORKDIR /myapp
    
    # Downgrade libc-bin safely using --allow-downgrades
    RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc \
        libpq-dev \
        && apt-get install -y --allow-downgrades libc-bin=2.36-9+deb12u7 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
    
    # Install dependencies into virtual environment
    COPY requirements.txt .
    RUN python -m venv /.venv \
        && . /.venv/bin/activate \
        && pip install --upgrade pip \
        && pip install -r requirements.txt
    
    # -------- Final Stage --------
    FROM python:3.12-slim-bookworm AS final
    
    # Downgrade libc-bin here as well
    RUN apt-get update && apt-get install -y --allow-downgrades libc-bin=2.36-9+deb12u7 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
    
    # Copy installed venv from base stage
    COPY --from=base /.venv /.venv
    
    # Activate venv and set paths
    ENV PATH="/.venv/bin:$PATH" \
        PYTHONUNBUFFERED=1 \
        PYTHONFAULTHANDLER=1 \
        QR_CODE_DIR=/myapp/qr_codes
    
    WORKDIR /myapp
    
    # Create non-root user for security
    RUN useradd -m myuser
    USER myuser
    
    # Copy application code with correct ownership
    COPY --chown=myuser:myuser . .
    
    EXPOSE 8000
    
    ENTRYPOINT ["uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
    