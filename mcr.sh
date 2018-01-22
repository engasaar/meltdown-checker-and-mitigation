#!/bin/bash
#########################################
# Meltdown Checker and Remediation(MCR)  #
# Written by: Ahmed Samir                #
#########################################
#
# this is tool used to check if your system vulnerable to meltdown or not and remediate your system
user=`whoami`
echo "your current user is "$user
if [ "$user" == "root" ]
then
echo "*****************************************************"
echo "* MCR Meltdown Checker and Remediation Ver. 1.0     *"
echo "* used to check if your system vulnerable           *"
echo "* to meltdown or not and remediate your system      *"
echo "* Coded by Ahmed Samir                              *"
echo "* Cyber Security Lover                              *"
echo "*****************************************************"
PS3="please choose one from the above options (or 'enter' for choices):"
select opt1 in "Meltdown Checker" "Meltdown Remediation" "exit"
do 
case $REPLY in
1)echo "looking for your linux banner address" 
meltdown_addr=`cat /proc/kallsyms |grep linux_proc_banner|cut -d " " -f1`
echo $meltdown_addr
echo "enter the number of addresses you want to read thier content:"
read num
if [ -s ./meltdown.out ]
then
if ! sudo ./meltdown.out $meltdown_addr $num > /dev/null
then
uname -rvi
head /proc/cpuinfo
echo "your system is vulnerable"
sudo ./meltdown.out $meltdown_addr $num
else
uname -rvi
head /proc/cpuinfo
echo "your system is not vulnerable"
fi
else
echo "Building Meltdown Checker. Please choose Checker again to run."
gcc meltdown.c -o meltdown.out
fi

;;
2)echo -n "updating your system please wait ."
for i in `seq 1 10`
do
sleep 1
echo -n "."
done
sudo apt update
echo -n "upgrading your system please wait ."
for i in `seq 1 10`
do
sleep 1
echo -n "."
done
sudo apt upgrade
;;
3)exit
;;
esac
done
else
echo "please run the script with sudo command"
fi
