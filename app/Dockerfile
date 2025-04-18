# Use a slim, official Python base image
FROM python:3.12-slim

# Create a non-root user called 'appuser'
RUN useradd -m appuser

# Set working directory inside the container
WORKDIR /home/appuser

# Copy requirements and install dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]