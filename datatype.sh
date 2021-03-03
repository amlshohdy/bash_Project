#!/bin/bash

dataType(){
    loop=1
    while [ $loop -eq 1 ]
    do
        echo "choose the datatype of $colName column ,enter the number of your choice "
        echo "1-datatype is string"
        echo "2-datatype is integer"
        read colType
        clear
        case $colType in
            1)
                echo -e -n ":string" >> ./databases/$dbName/$tableName/$tableName"_"desc
                loop=0
            ;;
            2)
                echo -e -n ":integer" >> ./databases/$dbName/$tableName/$tableName"_"desc
                loop=0
            ;;
            *)
                echo "not valid"
                dataType
            ;;
        esac
    done
}
