#!/bin/bash
source settings.sh

# Run the mix tests in the application container
docker-compose -f containers.yml -p ${PROJECT_NAME} run --rm app mix deps.get --only test && \
docker-compose -f containers.yml -p ${PROJECT_NAME} run --rm app mix test