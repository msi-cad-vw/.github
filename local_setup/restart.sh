#!/bin/bash

# Stop the running application
docker compose down
docker system prune -f

# Start the Docker Compose
docker compose up --build -d
