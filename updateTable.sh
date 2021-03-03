#!/bin/bash
source ./insert.sh

updateTableData(){

 if [[ $(ls ./databases/$dbName ) == "" ]]
    then
        echo " Please Create Tables To Update  "
        return 0
    fi
    showTables $dbName

read -p "enter table name : " tableName
 if [[ ! $tableName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] || [ ! -d ./databases/$dbName/$tableName ]
 then
    echo "this name is not exists please try again"
   else
   echo "Table Data : "
   cat ./databases/$dbName/$tableName/$tableName"_"data
   pkColName=$( cat ./databases/$dbName/$tableName/$tableName"_"desc | awk 'BEGIN{FS=":"}NR==1{print $1}' )
    read -p "Enter $pkColName of col you want to Edit: " pk
    num=$(awk -v row_num=$pk 'BEGIN{ FS = ":"}{ if( row_num == $1 ){ print } }' ./databases/$dbName/$tableName/$tableName"_"data)
    echo $num
    if [[ $num = "" ]]
     then
      echo "Sorry but this key not found "
      return 0
    fi

   newRecord=""

for l in `cat ./databases/$dbName/$tableName/$tableName"_desc"`
   do
  v="0"
  name=$(echo "$l" | cut -d ":" -f 1)
  colDataType=$(echo "$l" | cut -d ":" -f 2)
  priChk=$(echo "$l" | cut -d ":" -f 3)

  if [[ $priChk = pk ]]
   then
    newRecord="${newRecord}$pk:"
    continue
  fi

  while [[ $v -eq "0" ]]
   do
    read -p "Enter value of col $name " newVal
    if [[ "$colDataType" = string ]]
     then
       if [[ "$newVal" =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
        then
         v="1"
       else
         echo "Sorry But This Col Must be a string"
       fi
     elif [[ "$colDataType" = integer ]]
     then
       if [[ "$newVal" =~ ^[0-9]+$ ]]
       then
       v="1"
     else
       echo "Sorry but this col must be a number"
       fi
fi
  done


  newRecord="${newRecord}$newVal:"
  done
echo "New Edited Row : $newRecord"
sed -i "s/^$pk:.*/$newRecord/" ./databases/$dbName/$tableName/$tableName"_"data
fi

}
