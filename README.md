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
