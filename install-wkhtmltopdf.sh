#!/bin/bash

apt-get install wget
wget --progress=dot https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2/wkhtmltox-0.12.2_linux-trusty-amd64.deb
dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
apt-get install -f -y
