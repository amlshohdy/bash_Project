#!/bin/bash
source ./datatype.sh
source ./nullValues.sh

CreateTable(){
    dbName="$1"
    echo "Enter Table Name : "
    echo ""
    read tableName
    clear
    
    if [[ ! $tableName =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] || [[ $tableName == '' ]]
    then
        echo "Not a Valid Name for Table"
        echo ""
        CreateTable $dbName
    elif [[ -d ./databases/$dbName/$tableName ]]
    then
        echo "Table Already Exist"
        echo ""
        CreateTable $dbName
    else
        mkdir ./databases/$dbName/$tableName
        touch ./databases/$dbName/$tableName/$tableName"_"desc
        touch ./databases/$dbName/$tableName/$tableName"_"data
        echo "Enter Number Of Columns : "
        echo ""
        read colNum
        clear
        
        
        until [[ $colNum =~ ^[2-9]+$ ]]
        do
            echo "Table Should Have at Least Two Column, String not allowed"
            echo "Enter Number Of Columns : "
            echo ""
            read colNum
            clear
        done
        
        for i in $(seq $colNum)
        do
            if [[ i -eq 1 ]];
            then
                echo "Enter Primary Key Column Name: "
                read colName
                clear
                until [[ $colName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
                do
                    echo "Invalid Primary Key Name"
                    echo "Enter Primary Key Column Name: "
                    read colName
                    clear
                done
                echo -n $colName >> ./databases/$dbName/$tableName/$tableName"_"desc
                dataType
                echo -e ":pk" >> ./databases/$dbName/$tableName/$tableName"_"desc
            else
                tableCols=$(awk 'BEGIN {FS=":"} {print $1}' ./databases/$dbName/$tableName/$tableName'_desc')
                
                
                until [[ $colName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] && [[ ! $tableCols == *"$colName"* ]]
                do
                    echo "Column Name Must be String and Start With Charachter and Not Repeated Before"
                    echo "enter the name of column $i : "
                    read colName
                    clear
                done
                echo -n $colName >> ./databases/$dbName/$tableName/$tableName"_"desc
                dataType
                echo -e  ":" >> ./databases/$dbName/$tableName/$tableName"_"desc
                
            fi
        done
        echo ""
        echo "$tableName table is created successfully"
        echo ""
    fi
}
testPrev(){
    for g in $tableCols
    do
        if [[ $g -eq $colName ]]
        then
            z="1"
            break
        else
            z="0"
        fi
    done
    echo "Z : $z"
    echo "ColName: $colName"
}
