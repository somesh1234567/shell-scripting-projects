#!/bin/bash

##########################
#Author: Somesh Panigrahi
#Purpose: this script will deploy a django app end to end via shell scripting
##########################


<< task
Deploy a Django app and handle any erros faced
task

code_clone() {
	echo "Cloning the Django App...."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements() {
	echo "Installing the Dependencies....."
	sudo apt-get update && sudo apt-get install docker.io nginx -y
	sudo apt-get install docker-compose-plugin
	#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

required_restarts() {
	sudo chown "$USER" /var/run/docker.sock
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	#sudo systemctl restart docker
}

deploy() {
	#docker build -t notes-app .
	mkdir -p ../build-context
	rsync -av --exclude='data/' ./ ../build-context/
	cd ../build-context
        docker-compose up --build
	#docker run -d -p 8000:8000 notes-app:latest python manage.py runserver 0.0.0.0:8000
}

echo "************** DEPLOYMENT STARTED ***************"
if ! code_clone; then
	echo "the code already exists..."
	cd django-notes-app
fi
if ! install_requirements; then
	echo "installation failed.Something is wrong"
	exit 1
fi
if ! required_restarts; then
	echo "System Failed. Cannot restart service"
	exit 1
fi
if ! deploy; then
	echo "Deployment Failed"
	exit 1
fi

echo "************** DEPLOYMENT ENDED ****************"
