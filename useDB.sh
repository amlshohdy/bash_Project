#!/bin/bash
source ./options.sh
source ./show.sh

useDB(){
    dbName="$1"
    if [ ! -z $dbName ]
    
    then
        echo " Selected Database : $dbName"
        DBoptions $dbName
        
    else
        showDB
        read -p "Enter The Database Name : " dbName
        clear
        if [[ ! $dbName =~ ^[0-9a-zA-Z]*$ ]] || [ ! -d ./databases/$dbName ]  
        then
            echo "Not a Valid Existing Database Name "
            useDB
        elif [ -z $dbName ]
        then
            echo "Database Can't be Empty "
            useDB
        
        else
            echo "Selected Database is : $dbName "
            DBoptions $dbName
        fi
    fi
    
    
}
