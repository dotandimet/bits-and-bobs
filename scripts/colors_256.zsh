 for COLOR in {0..255}                          
do
    for STYLE in "38;5"  # set 48;5 for background
    do
        TAG="\033[${STYLE};${COLOR}m"
        STR="${STYLE};${COLOR}"
        echo -ne "${TAG}${STR}${NONE}  "
    done
    echo
done

