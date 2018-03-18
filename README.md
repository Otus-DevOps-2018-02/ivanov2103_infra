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
 ProxyCommand ssh -A bastion -W %h:%p_

- GCP hosts IP:

bastion_IP = 35.205.23.100

someinternalhost_IP = 10.132.0.3

