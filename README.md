# ivanov2103_infra
ivanov2103 Infra repository

## Homework-04
- SSH command for jumping to local someinternalhost across bastion host:

**$ ssh -J appuser@35.205.23.100 appuser@10.132.0.3**

- Configuration for use short command of SSH jumping with aliase: 

**$ cat ../.ssh/config**
Host bastion
 HostName 35.205.23.100
 User appuser
Host someinternalhost
 HostName 10.132.0.3
 User appuser
 ProxyCommand ssh -A bastion -W %h:%p

- GCP hosts IP:

bastion_IP = 35.205.23.100

someinternalhost_IP = 10.132.0.3

## Homework-05
- Comman for create firewall-rules:

**gcloud compute firewall-rules create default-puma-server \
    --network default \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --priority 1000 \
    --target-tags puma-server
    
- For create VM and firewall-rules run command:

**./create_VM_firewall.sh

- For install Ruby, Mongodb and deploy application, run commands:

**scp ~/ivanov2103_infra/deploy.sh ~/ivanov2103_infra/install_* appuser@35.189.239.164:~/

**ssh appuser@35.189.239.164 './install_ruby.sh ; ./install_mongodb.sh ; ./deploy.sh'

- For create VM and firewall-rules with a startup script local file, run command:

**./create_VM_firewall_file.sh

- For create VM and firewall-rules with a startup script stored on Google Cloud Storage, run command:

**./create_VM_firewall_url.sh

- Test hosts IP:Port:

testapp_IP = 35.195.95.117

testapp_port = 9292
