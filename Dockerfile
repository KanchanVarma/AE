#Image of ubuntu as a builder
FROM ubuntu:18.04

#Updating the apt-get packages
RUN apt-get update  

#Installing the vim editor
RUN apt-get install -y vim

#Installing the package sudo
RUN apt-get install -y sudo

#Installing ansible packages to run and deploy application inside container
RUN apt-get install -y ansible

#Adding the ansible scripts from the host to the container for "ae"
ADD ansible_scripts_ae ansible_scripts_ae

#Adding the releases folder containing the config and the executable files of "ae"
ADD releases/ae releases

#Adding the services folder containing the "ae" conf
ADD services services

#changing the working directory
WORKDIR ansible_scripts_ae

#Executing the ansible-playbook to deploy the sevice files
RUN ansible-playbook -i hosts add_services.yml -c local

#Executing the ansible-playbook to deploy the "ae" application
RUN ansible-playbook -i hosts  ae_deploy.yml  -c local

EXPOSE 8086

WORKDIR /huda/ae

CMD ["./ae"]
