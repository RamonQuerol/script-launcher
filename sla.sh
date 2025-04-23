
#!/bin/bash

SLA_DIR="$(dirname $(realpath "$0"))"

# $1 Command name, $2 Script launcher name
is_file_registered(){
    if [ ! -f "$SLA_DIR/launchers/$2" ]; then
        echo "The command $2 is not registered, so you can not apply the command $1 to it."
        exit 1
    fi
}

# $1 = Num Args, $2 = Expected
check_num_arguments(){
    if [ $1 -ne $2 ]; then
        echo "You did not give enough arguments, you gave $1 instead of $2 use \"sla help\" for more information"
        exit 1
    fi
}

# $1 = Launcher name
get_script_real_name(){
    SCRIPT_NAME_COMMENT="$(head -n 1 "$SLA_DIR/launchers/$1")"
    echo "${SCRIPT_NAME_COMMENT:1}"
}

set -e # Small safeward so that the program stops if a command fails

case $1 in
    
    run)
        check_num_arguments $# 2
        is_file_registered run $2
        exec "$SLA_DIR/launchers/$2"
        ;;
    add)
        check_num_arguments $# 3
        if [ ! -f "$2" ]; then
            echo Could not find the script $2 in your system, check if that is the exact name of the file you want to add.
            exit 2
        fi
        
        if [ ! -d "$SLA_DIR/scripts" ]; then
            mkdir "$SLA_DIR/scripts"
        fi

        SCRIPT_NAME=$(basename $2)
        SCRIPT_LOC="$SLA_DIR/scripts/$SCRIPT_NAME"
        cp $2 $SCRIPT_LOC

        if [ ! -d "$SLA_DIR/launchers" ]; then
            mkdir "$SLA_DIR/launchers"
        fi

        LAUNCHER_FILE="$SLA_DIR/launchers/$(echo $SCRIPT_NAME | cut -f 1 -d ".")"
        LAUNCHER_SCRIPT="$(echo $3 | sed "s|\.\.\.|$SCRIPT_LOC|g")"
        echo "#$SCRIPT_NAME" > $LAUNCHER_FILE
        echo $LAUNCHER_SCRIPT >> $LAUNCHER_FILE
        chmod +x $LAUNCHER_FILE
        
        echo "$2 has been registered into the sla database"
        ;;
    del)
        check_num_arguments $# 2
        is_file_registered del $2

        rm "$SLA_DIR/scripts/$(get_script_real_name $2)"
        rm "$SLA_DIR/launchers/$2"
        
        echo "$2 has been deleted from sla database"
        ;;
    cp)
        check_num_arguments $# 3
        is_file_registered cp $2
        cp "$SLA_DIR/scripts/$(get_script_real_name $2)" $3
        echo "$2 copied into $3"
        ;;
    ls)
        ls "$SLA_DIR/launchers"
        ;;
    help)
        cat "$SLA_DIR/help.txt"
        ;;
    "")
        echo "You have to add the command, use sla help to know the available commands"
        ;;
    *)
        echo "$1 is not a valid command, use the command help to know the available commands"
        ;;
esac