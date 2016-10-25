#!/bin/sh
set -e

DIRECTORY="/home/ipfs/.ipfs"

#Check if ipfs has been initialized
if [ ! -d "$DIRECTORY" ]; then
	#Initialize ipfs and change settings to allow for access from outside the container
	ipfs init
	#Allow the webinterface container to access the API
	ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://0.0.0.0:3000"]'
	ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
	ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'

	#Also allow access to API and gateway from outside the container
	ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
	ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

	ipfs daemon

	else
	ipfs daemon
fi
