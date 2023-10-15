#!/bin/bash

# Unzip application
unzip wepapp.zip

# Go to path
cd webapp || exit

# Install dependencies
npm i

# Run app
node index.js