#!/bin/bash
apt update
apt install -y apache2
systemctl enable apache2