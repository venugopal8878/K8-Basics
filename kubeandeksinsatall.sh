#!/bin/bash

echo "install kubectl"

VALIDATE(){
    if [$1 -ne 0]
then 
echo "$2 is not exceute successfully please check"
else 
echo "$2 executed successfully"
fi 
}

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl

VALIDATE $? "command"

chmod +x ./kubectlddd

VALIDATE $? "command"
sudo mv kubectl /usr/local/bin/kubectl
VALIDATE $? "command"

kubectl version
VALIDATE $? "command"

echo "install eksctl"

# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=

PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

echo "give AWS Credetial"

aws configure