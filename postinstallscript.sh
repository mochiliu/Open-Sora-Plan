#!/usr/bin/env bash
# this script will run when build docker image.

pip install -e .
pip uninstall -y transformer-engine
pip uninstall -y apex
exec /bin/bash