#!/bin/bash

until [[ -f /var/lib/cloud/instance/boot-finished ]]; do echo "." && sleep 1; done

apt update && apt install -y nginx

service nginx start