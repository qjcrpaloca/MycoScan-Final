# Use official Python
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements first (better caching)
COPY Mycoscan_v3/requirements.txt /app/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the whole project
COPY Mycoscan_v3/ /app/

# Set environment variables
ENV PORT=10000
ENV PYTHONUNBUFFERED=1

# Expose the port Render will use
EXPOSE 10000

# Start the server using Gunicorn and your factory app
# IMPORTANT: Do NOT include parentheses for factory functions
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "main:create_app()"]
