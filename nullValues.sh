#!/bin/bash

nullvalue(){
    echo  "Should $colName Accept Null Values y/n: "
    read answer
    clear
    if [ $answer == 'y' ] || [ $answer == 'Y' ]
    then
        echo ":Null" >> ./databases/$dbName/$tableName/$tableName"_"desc
    elif [ $answer == 'n' ] || [ $answer == 'N' ]
    then
        echo -e -n ":NotNull" >> ./databases/$dbName/$tableName/$tableName"_"desc
    else
        echo "Not a Valid"
        nullvalue
    fi
}