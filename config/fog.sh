#!/bin/bash

# Generate .fog file
touch ~/.fog
echo ":default:" > ~/.fog
echo "  :aws_access_key_id: ${AWS_ACCESS_KEY}" >> ~/.fog
echo "  :aws_secret_access_key: ${AWS_SECRET_KEY}" >> ~/.fog
