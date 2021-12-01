#!/bin/bash

echo -n "Enter IP-address: "
read ipaddr

echo "Do you have SSD?"  
read -p "Yes(y)/No(n)? :" Answer  
case $Answer in  
    Yes|yes|y|Y)  
    ssd=1  
                        ;;  
    No|no|N|n)  
   ssd=0 
                                        ;;  
                                                esac
if [[ "$ssd" = 1 ]]; then
echo -en "Select OS:\n1)Centos\n2)Ubuntu\n3)Debian\n"
read -p "Select OS:" os
case $os in

        1)
        echo "[centos]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass
        > ./hosts
                                        ;;
        2)
        echo "[ubuntu]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass
        > ./hosts
        
                                
                                ;;
        3)
        echo "[debian]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts  prod.yml -l $ipaddr --ask-pass
        > ./hosts

                                        ;;                                                     
        *) echo "Invalid input"
        
                                        ;;
    esac

else    
    
    echo -en "Select OS:\n1)Centos\n2)Ubuntu\n3)Debian\n"
read -p "Select OS:" os
case $os in

        1)
        echo "[centos]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts prod.yml -l $ipaddr --skip-tag=ssd --ask-pass
        > ./hosts
                                        ;;
        2)
        echo "[ubuntu]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts prod.yml -l $ipaddr  --skip-tag=ssd --ask-pass
        > ./hosts
        
                                
                                ;;
        3)
        echo "[debian]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
        ansible-playbook -i ./hosts  prod.yml -l $ipaddr  --skip-tag=ssd --ask-pass
        > ./hosts

                                        ;;                                                     
        *) echo "Invalid input"
        
                                        ;;
    esac
    
    fi