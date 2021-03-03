#!/bin/bash
source ./useDB.sh
source ./createDB.sh
source ./options.sh
source ./delete.sh
source ./show.sh

echo "##########################################"
echo "======> Aml Shohdy & Sara Muhammad <======"
echo "##########################################"


if [[ ! -d ./databases ]]
then
    mkdir ./databases
fi

while true
do
    echo "         choose          "
    echo "1 - Create New Database"
    echo "2 - Use Database"
    echo "3 - Drop Datbase"
    echo "4 - Show Databases"
    echo "0 - Exit"
    
    read -p "Enter Your Choice: " choice
    
    case $choice in
        1)
            createDB
        ;;
        
        2)
            clear
            if [[ $(ls ./databases ) != "" ]]
            then
                useDB
            else
                echo "there is no databases"
            fi
        ;;
        3)
            clear
            dropDB
        ;;
        
        4)
            clear
            showDB
        ;;
        0)
            break
        ;;
        
        *)
            clear
            echo wrong entry
        ;;
    esac
    
done
