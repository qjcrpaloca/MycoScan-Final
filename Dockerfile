FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY Mycoscan_v3/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the whole project
COPY Mycoscan_v3/ /app/

# Default port for local Docker; Render will override PORT at runtime
ENV PORT=10000
ENV PYTHONUNBUFFERED=1

# Expose the port (for documentation / local use)
EXPOSE 10000

# Use Gunicorn and bind to the PORT env variable
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:$PORT main:create_app()"]
