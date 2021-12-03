#!/bin/bash
echo "================== Welcome to setup script ==================="
echo -n "Enter IP-address: "
read ipaddr

echo "How many disks in server?"  
read -p "[1-3]:" diskcount

echo "Do you have SSD?"  
read -p "Yes(y)/No(n)? :" Answer

  
case $Answer in  
    Yes|yes|y|Y)  
    ssd=1  
                        ;;  
    No|no|N|n)  
   ssd=0 
                        ;;
                        
    *) echo "Invalid input"
       exit
                        ;;
                          
esac
                                                
echo -en "Select OS:\n1)Centos\n2)Ubuntu\n3)Debian\n"
read -p "Select OS:" os
  case $os in

        1)
        
        selectos="centos"
        ;;
        2)
        selectos="ubuntu"
        ;;
        3)
        
        selectos="debian"
        ;;
        *) echo "Invalid input"
       exit
        ;;

  esac
        echo "[$selectos]" >> ./hosts
        echo "$ipaddr ansible_ssh_host=$ipaddr ansible_ssh_user=root" >> ./hosts
          
          case $diskcount in 
          
           1)
           if [[ "$ssd" = 1 ]]; then
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd2,ssd3"
           else
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd,ssd2,ssd3"
           fi
           ;;
           
           2)
           
           if [[ "$ssd" = 1 ]]; then
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd1,ssd3"
           else
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd,ssd1,ssd3"
           fi
           ;;
           
           3)
           if [[ "$ssd" = 1 ]]; then
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd1,ssd2"
           else
            ansible-playbook -i ./hosts prod.yml -l $ipaddr --ask-pass --skip-tag="ssd,ssd1,ssd2"
          fi
           ;;
           *) echo "Invalid input"
              exit
            ;;
          esac 
          
        > ./hosts