#! /usr/bin/env bash

#get the current date

date_value=$(date +'%Y_%m_%d')

#i want to use bzip compression

files_location=~/Downloads/shop

if [[ -d "$files_location" ]];then
       if [[ -d $files_location/customers_data ]];then 
           if find "$HOME/Downloads/shop/customers_data" -maxdepth 1 -type f \( -name "*.csv" -o -name "*.txt" \) |tee -a backup.log|grep -E -q '(csv|txt)' ;then
                 ls -la ../Downloads/shop/customers_data/ | grep -Eo '[a-zA-Z0-9]+\.(txt|csv)'| sed "s|\(.*\)|$files_location/customers_data/\1|" | tar -cjf "customer_${date_value}.ta>
         else
            echo 'No files found in customers_data folder' >> backup.log  
         fi
      fi
      if [[ -d $files_location/inventory_data ]];then
             if find "$HOME/Downloads/shop/inventory_data" -maxdepth 1 -type f \( -name "*.csv" -o -name "*.txt" \)|tee -a backup.log |grep -E -q '(csv|txt)' ;then
                 ls -la ../Downloads/shop/inventory_data/ | grep -Eo '[a-zA-Z0-9]+\.(txt|csv)'| sed "s|\(.*\)|$files_location/inventory_data/\1|" | tar -cjf "inventory_${date_value}.t>
            else
             echo 'No files found in inventory_data folder' >> backup.log  
           fi
     fi

     if [[  -f $files_location/backup_db.sh ]]; then
            #run the script capture its output     
            cat <(bash /home/hpuser/Downloads/shop/backup_db.sh) > "backup_${date_value}.sql"
            current_dir=$(pwd)
            bzip2 "${current_dir}/backup_${date_value}.sql"
            rm -f "backup_${date_value}.sql"
    fi         
else
  # send this message to current stderr
  echo 'Path doesn'"'"'t exists ---> no backup is taken' >> backup.log
fi
