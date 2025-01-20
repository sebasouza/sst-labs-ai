#!/bin/bash

# Exit script on error
set -e

# Change to the root directory
cd "$(dirname "$0")/.."
pwd

# Install and update Poetry (if necessary)
echo "Checking Poetry installation..."
if ! command -v poetry &> /dev/null
then
    echo "Poetry not found. Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
#    pipx install poetry
else
    echo "Poetry is already installed. Updating Poetry..."
    pipx upgrade poetry
fi

# pipx inject poetry poetry-plugin-export
# Ensure poetry-plugin-export is installed
poetry self add poetry-plugin-export
poetry self update
poetry self show plugins


# Install dependencies from pyproject.toml using Poetry
echo "Installing project dependencies with Poetry..."
poetry update
poetry check
poetry lock
poetry export -f requirements.txt --output requirements.txt
poetry sync
poetry install
echo "--------------------------------"
