#!/bin/bash
source ./show.sh

dropDB(){
    flag=1
    showDB
    echo "Choose Database To Drop"
    read dbName
    if [[ $dbName == / ]]
    then
        clear
        echo "/ is not a database"
        dropDB
    elif [ -z $dbName ]
    then
        clear
        echo "Please Insert Valid Database Name"
        dropDB
    else
        if [[ -d ./databases/$dbName ]]
        then
            clear
            echo "WARNING !!! "
            echo "ALL TABLES & DATA IN THIS $dbName DATABASE WILL BE DELETED !"
            echo "Are You Sure You Want To drop $dbName ? (Y,N)"
            read answer
            until [ flag = 0 ]
            do
                case $answer in
                    [Yy] )
                        rm -r ./databases/$dbName
                        if [[ $? == 0 ]]
                        then
                            echo "Database $dbName Deleted Successfully"
                        fi
                        break
                    ;;
                    [Nn] )
                        echo "Canceled"
                        break
                    ;;
                    *)
                        clear
                        echo "Please Enter Valid Answer (Y,N)"
                        read answer
                    ;;
                esac
            done
        else
            clear
            echo "Database does Not Exist"
            dropDB
        fi
    fi
}

dropTable(){
    
    echo "Choose Table To Drop"
    read tableName
    if [[ $tableName == '' ]]
    then
        echo "table name can't be empty"
        dropTable
    elif [[ $tableName == / ]]
    then
        echo "/ is not a table"
        dropTable
    elif [[ -d ./databases/$dbName/$tableName ]]
    then
        clear
        echo "WARNING !!! "
        echo "ALL DATA IN THIS Table WILL BE DELETED !"
        echo "Are You Sure You Want To drop $tableName ? (Y,N)"
        read answer
        until [ flag = 0 ]
        do
            case $answer in
                [Yy] )
                    rm -r ./databases/$dbName/$tableName
                    if [[ $? == 0 ]]
                    then
                        echo "Table $tableName Deleted Successfully"
                    fi
                    break
                ;;
                [Nn] )
                    echo "Canceled"
                    break
                ;;
                *)
                    clear
                    echo "Please Enter Valid Answer (Y,N)"
                    read answer
                ;;
            esac
        done
    else
        echo "Table does Not Exist"
        dropTable
    fi
}