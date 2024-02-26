FROM docker.io/python:3.10-slim

# Create a directory for the application
RUN mkdir /calrissian
# Set the working directory
WORKDIR /calrissian

# Install required dependencies
RUN pip install --no-cache-dir mlflow click scikit-learn && \
    python -c "import mlflow"

# Add the application code
ADD app.py /app/app.py

# Create a writable directory for the application
RUN mkdir /calrissian/output-data/

# Set the permissions for the output directory
RUN chmod 777 /calrissian/output-data/
RUN apt update 
RUN apt install -y git
# Set the entry point
ENTRYPOINT []
