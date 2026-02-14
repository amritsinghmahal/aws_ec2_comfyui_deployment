# Deploying ComfyUI on AWS EC2 for AI Video Generation

This repository documents and automates the deployment of ComfyUI on AWS EC2 GPU instances. It includes a structured setup process for configuring the operating system, Python environment, NVMe storage usage, and model downloads, along with instructions for securely accessing the UI over SSH.

The goal is to provide a repeatable deployment that can be reused across multiple sessions or instances.

## Overview

This repository provides a repeatable way to deploy and run ComfyUI on an AWS EC2 GPU instance.

It is intended for users who want a working AI video generation environment without manually piecing together system configuration, dependencies, storage handling, and model downloads.

The setup:
- Uses an Ubuntu Deep Learning AMI
- Runs on EC2 GPU instances (On-Demand or Spot)
- Stores all heavy data on NVMe storage
- Downloads model weights dynamically (no weights committed)
- Accesses ComfyUI securely via SSH tunneling

## Target Environment

- EC2 Instance Type: g6e.2xlarge
- OS: Ubuntu Deep Learning AMI (PyTorch)
-  Storage: NVMe for temp files, pip cache, models, and workspace

## Pricing Notes

This setup works on both On-Demand and Spot instances.

On-Demand:
- Stable and uninterrupted
- Higher hourly cost
- Recommended for long or critical runs

Spot:
- Significantly cheaper
- Instance may be interrupted
- Recommended for experiments, testing, and short sessions

**Important: Always stop the instance when finished to avoid compute charges.**

## Quick Start

The script installs system dependencies, sets up ComfyUI, creates a Python virtual environment, and downloads all required models.

Clone the repository:

`git clone <YOUR_GITHUB_REPO_URL>`

`cd aws-ec2-comfyui-deployment`

Make the setup script executable and RUN it:

`chmod +x setup.sh`

`./setup.sh`


## Starting ComfyUI

The script would itself start ComfyUI, if stopped for any reason then you can manually start the service.

`cd /opt/dlami/nvme/ComfyUI`

`source comfy-venv/bin/activate`

`python main.py --listen 127.0.0.1 --port 8188`

## Accessing ComfyUI (SSH Tunnel)

From your local machine:

`ssh -i ec2-key.pem -L 8188:127.0.0.1:8188 ubuntu@<EC2_PUBLIC_IP>`

Then open your browser at:
http://localhost:8188

## Included Models

- WAN 2.2 (Text-to-Video)
- LTX-2
- Hunyuan Video 1.5

Model files are downloaded from Hugging Face during setup and are not stored in this repository.
