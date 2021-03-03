
#!/bin/bash

checkprimary(){

    dbName="$1"
    tableName="$2"
    primary="$3"
    readyToRecord=1

    if [[ "$primary" = pk ]]
    then
        if [[ "$colVal" != "" ]]
        then
            tableData=$(awk 'BEGIN {FS=":"} {print $1}' ./databases/$dbName/$tableName/$tableName'_data')

            if [[ $tableData = "" ]]
            then

                echo -n "$colVal" >> ./databases/$dbName/$tableName/$tableName'_data'
                echo -n ":" >> ./databases/$dbName/$tableName/$tableName'_data'

            else


                for i in $tableData
                do

                    if [ $i == $colVal ]
                    then
                        echo "duplicated value ,must be unique"
                        checkConstrains $dbName $tableName
                        return 0
                    fi

                done

                echo -n "$colVal" >> ./databases/$dbName/$tableName/$tableName'_data'
                echo -n ":" >> ./databases/$dbName/$tableName/$tableName'_data'
            fi
        else
            echo "error ! must be a not NULL"
            readyToRecord=0
            checkConstrains $dbName $tableName
            return 0
        fi
    else
        if [ $readyToRecord == 1 ]
        then
            echo -n "$colVal" >> ./databases/$dbName/$tableName/$tableName'_data'
            echo -n ":" >> ./databases/$dbName/$tableName/$tableName'_data'
        fi
    fi
}

checkConstrains(){

    dbName=$1
    tableName=$2

    colName=$(echo "$j" | cut -d ":" -f 1)
    colDataType=$(echo "$j" | cut -d ":" -f 2)
    primary=$(echo "$j" | cut -d ":" -f 3)

    read -p "enter the value of $colName " colVal
    if [[ "$colDataType" = integer ]]
    then
        if [[ "$colVal" =~ ^[0-9]+$ ]]
        then
            checkprimary $dbName $tableName $primary
        else
            echo "invalid for $colName"
            checkConstrains $dbName $tableName
        fi
    fi

    if [[ "$colDataType" = string ]]
    then
        if [[ "$colVal" =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
        then
            checkprimary $dbName $tableName $primary
        else
            echo "invalid for $colName"
            checkConstrains $dbName $tableName
        fi
    fi

}

insertRecord(){
    dbName="$1"
    if [[ $(ls ./databases/$dbName ) == "" ]]
    then
        echo " Please Create Tables To Insert Record  "
        return 0
    fi

    col=0
    read -p "enter table name : " tableName
    if [[ ! $tableName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] || [ ! -d ./databases/$dbName/$tableName ]
    then
        echo "This Table Name doesn't Exist, please try again"
        insertRecord $dbName
    else
          echo "Table Data : "
           cat ./databases/$dbName/$tableName/$tableName"_"data
        for j in ` cat ./databases/$dbName/$tableName/$tableName'_desc' `
        do
            checkConstrains $dbName $tableName
        done
        echo -e "" >> ./databases/$dbName/$tableName/$tableName"_"data

    fi
}
