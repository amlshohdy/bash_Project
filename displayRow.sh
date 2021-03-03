#!/bin/bash
source ./show.sh

displayrow(){
    echo "Enter Table Name"
    read tableName
    if [[ $tableName == / ]]
    then
        clear
        showTables $dbName
        echo "/ is not a valid table name"
        displayrow
    elif [[ $tableName == '' ]]
    then
        clear
        showTables $dbName
        echo "Table Name Can't Be Empty"
        displayrow
    elif [[ ! -d ./databases/$dbName/$tableName ]]
    then
        clear
        showTables $dbName
        echo "Table Doesn't Exist, Choose Another Name"
        displayrow
    else
      echo "Table Data : "
      echo "====================="
       cat ./databases/$dbName/$tableName/$tableName"_"data
        echo "Enter row PK to Display"
        read rowPK
        
        while ! [[ $rowPK =~ ^[0-9a-zA-Z]+$ ]]
        do
            echo "PK can't be empty"
            echo "Enter row PK to Delete"
            read rowPK
        done
        num=$(awk -v row_num=$rowPK 'BEGIN{ FS = ":"}{ if( row_num == $1 ){ print } }' ./databases/$dbName/$tableName/$tableName"_"data)
        echo $num
        
    fi
}

deleterow(){
    echo "Enter Table Name"
    read tableName
    if [[ $tableName == / ]]
    then
        clear
        showTables $dbName
        echo "/ is not a valid table name"
        deleterow
    elif [[ $tableName == '' ]]
    then
        clear
        showTables $dbName
        echo "Table Name Can't Be Empty"
        deleterow
    elif [[ ! -d ./databases/$dbName/$tableName ]]
    then
        clear
        showTables $dbName
        echo "Table Doesn't Exist, Choose Another Name"
        deleterow
    else
        clear
        echo "All Available Rows"
        cat ./databases/$dbName/$tableName/$tableName"_"data
        echo "Enter row PK to Delete"
        read rowPK
        while ! [[ $rowPK =~ ^[0-9a-zA-Z]+$ ]]
        do
            echo "PK can't be empty or String"
            echo "Enter row PK to Delete"
            read rowPK
        done
        num=$(awk -v row_num=$rowPK 'BEGIN{ FS = ":"}{ if( row_num == $1 ){ print } }' ./databases/$dbName/$tableName/$tableName"_"data)
        sed -i ''/$num/'d' ./databases/$dbName/$tableName/$tableName"_"data
        cat ./databases/$dbName/$tableName/$tableName"_"data
        
    fi
}
