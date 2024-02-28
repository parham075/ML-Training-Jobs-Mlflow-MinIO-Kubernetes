FROM docker.io/python:3.10-slim

# Create a directory for the application
RUN mkdir /app
# Set the working directory
WORKDIR /app

# Install required dependencies
RUN pip install mlflow click scikit-learn && \
    python -c "import os"

# Add the application code
ADD script.py /app/script.py

# Create a writable directory for the application


# Set the permissions for the output directory
 
RUN apt update && apt install -y git
# Set the entry point
ENTRYPOINT []
