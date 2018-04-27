# ivanov2103_infra
ivanov2103 Infra repository

## Homework-04
- SSH command for jumping to local someinternalhost across bastion host:  
**$ ssh -J appuser@35.205.23.100 appuser@10.132.0.3**
- Configuration for use short command of SSH jumping with aliase:  
**$ cat ../.ssh/config**  
_Host bastion  
 HostName 35.205.23.100  
 User appuser  
Host someinternalhost  
 HostName 10.132.0.3  
 User appuser  
 ProxyCommand ssh -A bastion -W %h:%_  
- GCP hosts IP:  
bastion_IP = 35.205.23.100  
someinternalhost_IP = 10.132.0.3  

## Homework-05
- command for create firewall-rules:  
**gcloud compute firewall-rules create default-puma-server \\  
    --network default \\  
    --action allow \\  
    --direction ingress \\  
    --rules tcp:9292 \\  
    --source-ranges 0.0.0.0/0 \\  
    --priority 1000 \\  
    --target-tags puma-server**
- For create VM and firewall-rules run command:  
**./create_VM_firewall.sh**
- For install Ruby, Mongodb and deploy application, run commands:  
**scp ~/ivanov2103_infra/deploy.sh ~/ivanov2103_infra/install_mongodb.sh ~/ivanov2103_infra/install_ruby.sh appuser@35.195.95.117:\~/**  
**ssh appuser@35.195.95.117 './install_ruby.sh ; ./install_mongodb.sh ; ./deploy.sh'**
- For create VM and firewall-rules with a startup script local file, run command:  
**./create_VM_firewall_file.sh**
- For create VM and firewall-rules with a startup script stored on Google Cloud Storage, run command:  
**./create_VM_firewall_url.sh**
- Test hosts IP:Port:  
testapp_IP = 35.195.95.117  
testapp_port = 9292

## Homework-06
- For create GCP image by Packer template, including Ruby and MongoDB, run command:  
**./packer build -var-file=variables.json ubuntu16.json**
- For create GCP image "Full" by Packer template, including Ruby, MongoDB and deployed application with autostart, run command:  
**./packer build -var-file=variables.json immutable.json**
- For create GCP image "Full" and runing instatnce from this by gcloud command, run:  
**packer build -var-file=variables.json immutable.json ; sleep.exe 15 ; \.\./config-scripts/create-reddit-vm.sh**
- Test hosts IP:Port:  
testapp_IP = 35.195.95.117  
testapp_port = 9292  

## Homework-07
- For create two GCP instances with Ruby, MongoDB and deployed Reddit application, run command: **terraform.exe apply**. The load balancer is also created.  
### **\***  
1. Arguments for add more keys to the metadata resource (google_compute_project_metadata_item):  
_key   = "ssh-keys"  
value = "appuser:${file(var.public_key_path)} appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)}"_  
2. Key "appuser_web" was deleted after executing **terraform apply** because there was no configuration for this resource.  
### **\*\***
1. For creating load balancing  instance, resources was defined from documentation (https://cloud.google.com/compute/docs/load-balancing/http/). Resource configuration based on  "gce-lb-http" module parts (https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/1.0.5).   
2. We are use argument "count" for deploy more than one identical instance.  
- Test hosts IP:Port (load balancer):  
testapp_IP = 35.190.2.190  
testapp_port = 80  

## Homework-08
- Was imported SSH firewall rule resource, has been studied dependence of resources by example of App IP resource creation. The configuration was divided to App and DB modules. Were created: configurations for two infrastructure environments, storage buckets resources from "storage-bucket" registry module.  
### **\***  
Was created remote backend on GCP storage for state file. It was done for App and DB environments. Was verified blocking the state file with simultaneous access (_Error: Error locking state: Error acquiring the state lock: writing "gs://storage-bucket-prod/terraform/state/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet_).  
### **\*\***
Were added App module provisioners for deploying Reddit. For access to Mongodb was needed change the configuration of Mongodb and recreated the image of the DB instance:  
_$ cat ../../packer/scripts/install_mongodb.sh  
\#!/bin/bash  
...  
apt install -y mongodb-org  
**sed -i 's/.\*bindIp:.\*/  bindIp: 0.0.0.0/' /etc/mongod.conf**  
systemctl enable mongod_  

## Homework-09
- Was created configution file, inventory with hostgroups in .ini and .yaml format, studed some modules (ping, command, shell, systemd, service, git). Was implemented simple playbook for install Reddit application.  
### **\***
Was created inventory in .json format by task recuirements. Was implemented simple script accepting only _--list_ parameter for reading JSON inventory. The _--host_ parameter don't was implement because JSON inventory has _\_meta_ element with variables.  
