
showDB(){
    echo "existing databases :"
    echo $(ls ./databases)
}

showTables(){
    if [[ $(ls ./databases/"$1" ) == "" ]]
    then
        clear
        echo " There is no Tables "
        
    else
        clear
        echo "existing tables :"
        echo $(ls ./databases/"$1")
    fi
}
