source ./insert.sh

alterTable(){
    
    if [[ $(ls ./databases/$dbName ) == "" ]]
    then
        echo " Please Create Tables To Update  "
        return 0
    fi
    
    showTables $dbName
    read -p "enter the table name that you want to alter : " tableName
    if ! [[ $tableName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
    then
        echo "Table Name Must be String"
        alterTable
    fi
    if [ ! -d ./databases/$dbName/$tableName ]
    then
        echo "not a valid existing table name please try again "
        alterTable
    else
        alterloop=1
        while [ $alterloop -eq 1 ]
        do
            echo "1-change table name"
            echo "2-add new field"
            echo "3-edit a certain field"
            echo "4-delete field"
            echo "5-back"
            
            
            read -p "enter your choice: " choice
            case $choice in
                1)
                    read -p "enter new name : " newtableName
                    until [[ $newtableName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
                    do
                        read -p "enter new name : " newtableName
                    done
                    mv ./databases/$dbName/$tableName/$tableName"_"desc ./databases/$dbName/$tableName/$newtableName"_"desc
                    mv ./databases/$dbName/$tableName/$tableName"_"data ./databases/$dbName/$tableName/$newtableName"_"data
                    mv ./databases/$dbName/$tableName ./databases/$dbName/$newtableName
                    tableName=$newtableName
                    echo "table is renamed successfully"
                ;;
                
                2)
                    read -p "enter the name of the new field  : " colName
                    until [[ $colName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
                    do
                        clear
                        echo "Unvalid Column Name"
                        read -p "enter the name of the new field  : " colName
                    done
                    echo -n $colName >> ./databases/$dbName/$tableName/$tableName"_"desc
                    datatypeSelect
                    echo -e  ":" >> ./databases/$dbName/$tableName/$tableName"_"desc
                    echo "$colName field is added to $tableName successfully"
                   
                ;;
                
                
                
                3)
                    fields=$(awk 'BEGIN {FS=":"} {print $1}' ./databases/$dbName/$tableName/$tableName"_"desc)
                    echo "=============================="
                    echo " existing fields "
                    echo "$fields"
                    echo "=============================="
                    read -p "enter the field to be edited  : " colName
                    if [[ $colName =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
                    then
                        field=$(sed -n "/^$colName:.*/p" ./databases/$dbName/$tableName/$tableName"_"desc)
                    else
                        echo "Column Name Must Be String"
                        alterTable
                    fi
                    
                    if [[ $field != "" ]]
                    then
                        firstfield=$(echo "$field" | cut -d ":" -f 1)
                        secondfield=$(echo "$field" | cut -d ":" -f 2)
                        thirdfield=$(echo "$field" | cut -d ":" -f 3)
                        
                        
                        echo "1-rename field"
                        echo "2-change data type"
                        read -p "enter your choice : " choice
                        case $choice in
                            1)
                                read -p "enter field new name : " newfieldname
                                until  [[ $newfieldname =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
                                do
                                    clear
                                    echo "Field Name Must Be String"
                                    read -p "enter new name : " newfieldname
                                done
                                firstfield=$newfieldname
                                
                            ;;
                            
                            2)
                                echo "1-datatype is string"
                                echo "2-datatype is integer"
                                read -p "choose the new datatype : " colType
                                case $colType in
                                    1)
                                        secondfield="string"
                                    ;;
                                    
                                    2)
                                        secondfield="integer"
                                    ;;
                                    *)
                                        echo "wrong entry please try again"
                                    ;;
                                esac
                            ;;
                            *)
                                echo "wrong entry please try again"
                            ;;
                            
                        esac
                        
                        newfield="$firstfield:$secondfield:$thirdfield"
                        
                        sed -i "s/^$colName:.*/$newfield/" ./databases/$dbName/$tableName/$tableName"_"desc
                    else
                        echo "wrong field"
                    fi
                    
                ;;
                
                4)
                    while true
                    do
                        fields=$(awk 'BEGIN {FS=":"} {print $1}' ./databases/$dbName/$tableName/$tableName"_"desc)
                        echo " existing fields "
                        echo "$fields"
                        read -p "enter the name of field to be deleted  : " colName
                        field=$(sed -n "/^$colName:.*/p" ./databases/$dbName/$tableName/$tableName"_"desc)
                        if  [[ $field = "" ]]
                        then
                            clear
                            echo "Field Doesn't Exist"
                        else
                            thirdfield=$(echo "$field" | cut -d ":" -f 3)
                            if [[ $thirdfield == "pk" ]]
                            then
                                echo "Sorry but you Cann't Delete Primary Key field"
                                alterTable
                            else
                                clear
                                sed -i '/'$colName'/d' ./databases/$dbName/$tableName/$tableName"_"desc
                                echo "$colName column is deleted to $tableName successfully"
                                break
                            fi
                            
                        fi
                    done
                ;;
                
                
                
                00)
                    alterloop=0
                ;;
                
                *)
                    echo wrong entry
                ;;
            esac
        done
    fi
}

datatypeSelect(){
    typeloop=1
    while [ $typeloop -eq 1 ]
    do
        echo "1-datatype is string"
        echo "2-datatype is number"
        read -p "choose the datatype of $colName column ,enter the number of your choice : " colType
        case $colType in
            1)
                echo -e -n ":string" >> ./databases/$dbName/$tableName/$tableName"_"desc
                typeloop=0
            ;;
            
            2)
                echo -e -n ":integer" >> ./databases/$dbName/$tableName/$tableName"_"desc
                typeloop=0
            ;;
            *)
                echo "wrong entry please try again"
                datatypeSelect
            ;;
        esac
    done
}
