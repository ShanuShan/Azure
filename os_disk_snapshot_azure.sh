#!/bin/bash
read -p "Provide VM name:" vmn
if [ "$(az vm list -d -o table --query "[?name=='$vmn']")" = "" ];
then
    echo -e "\e[1;31m No VM was found with $vmn name.\e[0m"
    exit
fi
rg=`az vm list -o table| grep -i $vmn | awk '{print $2}'`
osdisk=`az vm show --resource-group $rg -n $vmn --query "storageProfile.osDisk.managedDisk.id" | grep -oP 'disks/\K.+' | rev|cut -c2- |rev`
snap=`az snapshot list --query "[].name" | grep -w "${vmn}_os_snapshot_prepatching_04_2021" | tr -d \" | tr -d ,|sed -e 's/^[ \t]*//'`
if [[ $snap = "${vmn}_os_snapshot_prepatching_04_2021" ]]
then
  echo "Snapshot already exist"
  echo "Below are the snapshot(s) already exist:"
  for i in `az snapshot list --query "[].name" | grep -i $vmn | tr -d \" | tr -d ,|sed -e 's/^[ \t]*//'`
  do
   n=$((n + 1))
   echo "$n) $i"
  done
  echo  "Please provide the new snapshot name:"
  read newsnap
  snap1=`az snapshot list --query "[].name" | grep -w $newsnap | tr -d \" | tr -d ,|sed -e 's/^[ \t]*//'`
  if [[ $snap1 = "$newsnap" ]]
  then
       echo "Provided name is already exist"
  else
    echo "Creating snapshot..."
    az snapshot create -g $rg --source $osdisk --name $newsnap
  fi
else
  echo "Creating snapshot"
  az snapshot create -g $rg --source $osdisk --name ${vmn}_os_snapshot_prepatching_04_2021
fi
