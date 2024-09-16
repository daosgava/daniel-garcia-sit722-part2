# Pull the base image.
ARG PYTHON_VERSION=3.12.5
FROM python:${PYTHON_VERSION}-slim as base

# Set environment variables.
WORKDIR /app/book_catalog

# Copy requirements.txt to the container.
COPY book_catalog/requirements.txt /app/book_catalog/requirements.txt

# Download dependencies as a separate step to take advantage of Docker's caching.
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install -r requirements.txt

# Copy the rest of the application code.
COPY book_catalog /app/book_catalog

# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD uvicorn 'main:app' --host=0.0.0.0 --port=8000
