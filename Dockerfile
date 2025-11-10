FROM python:3.11-slim
 
WORKDIR /app
 
# Install PostgreSQL client for psql
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*
 
# Upgrade pip
RUN pip install --upgrade pip
 
# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy app code
COPY . .
 
# Ensure script has Unix line endings and is executable (fixes Windows CRLF problems)
# This removes any trailing CR (\r) characters and sets the executable bit.
RUN sed -i 's/\r$//' wait-for-db.sh \
    && chmod +x /app/wait-for-db.sh
 
EXPOSE 5002
CMD ["python", "app.py"]