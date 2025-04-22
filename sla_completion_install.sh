
_sla_autocompletion(){
    local sla_command sla_dir options prev_command
    COMPREPLY=()
    compopt -o default

    case $COMP_CWORD in
        1)
            options="add cp del help run"
            # COMPREPLY=( $(compgen -W "${options}" -- ${COMP_WORDS[1]}) )
            ;;
        2)
            prev_command=${COMP_WORDS[1]}
            if [[ " cp del run " =~ " $prev_command " ]] then
                sla_dir=$(which sla | xargs realpath | xargs dirname)

                options="$(ls $sla_dir/launchers)"
            fi
            ;;
    esac
    COMPREPLY=( $(compgen -W "${options}" -- ${COMP_WORDS[$COMP_CWORD]}) )
}

complete -F _sla_autocompletion sla