#!/bin/bash
sudo service docker start
sudo service apache2 start
sudo docker start mysql redis wordpress gitlab openproject
code
echo "1-eclipse 2-idea"
read choose
if [[ ${choose} -eq 1 ]]
then
    ~/opt/eclipse/eclipse >> ~/tmp/eclipse.log 2>&1 &
elif [[ ${choose} -eq 2 ]]
then
    ~/opt/idea/bin/idea.sh >> ~/tmp/idea.log 2>&1 &
fi
