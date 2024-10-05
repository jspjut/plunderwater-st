#!/bin/bash

FOLDER_ID=1W30kKZFvQiYGSA0h4WxJkmRKkaxUCwhQ

# Install gdown if not already installed
pip install gdown

# Download the folder
gdown https://drive.google.com/drive/folders/$FOLDER_ID -O .assets --folder
