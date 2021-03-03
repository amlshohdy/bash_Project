#!/bin/bash

source ./show.sh
source ./createTable.sh
source ./insert.sh
source ./delete.sh
source ./displayTable.sh
source ./alterTable.sh
source ./displayRow.sh
source ./updateTable.sh

DBoptions(){
    dbName="$1"
    loop=1
    while [ $loop -eq 1 ]
    do
        
        echo "1 - Show Tables"
        echo "2 - Create New Table"
        echo "3 - Alter Table"
        echo "4 - Delete Table "
        echo "5 - Insert Record"
        echo "6 - Delete Record"
        echo "7 - Display Table"
        echo "8 - Display Row"
        echo "9 - Update Data In Table"
        echo "00 - Back"
        
        
        read -p "enter your choice: " choice
        
        case $choice in
            1)
                showTables $dbName
            ;;
            
            2)
                CreateTable $dbName
                
            ;;
            
            3)
                alterTable $dbName
            ;;
            
            4)
                showTables $dbName
                dropTable $dbName
            ;;
            
            
            5)
                showTables $dbName
                insertRecord $dbName
            ;;
            
            
            6)
                showTables $dbName
                deleterow $dbName
            ;;
            
            7)
                showTables $dbName
                displayTable $dbName
            ;;
            
            8)
                showTables $dbName
                displayrow $dbName
            ;;
            
            
            9)
                updateTableData $dbName
            ;;
            
            00)
                loop=0
                clear
            ;;
            
            *)
                echo wrong entry
            ;;
        esac
    done
    
}
