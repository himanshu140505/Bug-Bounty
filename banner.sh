#!/bin/bash
printbanner(){
    # Path to slogans
    SLOGANS_FILE="./slogan.txt"

    # Get a random slogan
    SLOGAN=$(shuf -n 1 "$SLOGANS_FILE")

    # Terminal width
    COLUMNS=$(tput cols)

    # Text lines
    TITLE="DevilHacksIt"
    PADDING=4
    BORDER_CHAR="#"

    # Create full lines with padding
    LINE1="$TITLE"
    LINE2="$SLOGAN"

    # Get the length of the longest line
    LEN1=${#LINE1}
    LEN2=${#LINE2}
    MAX_LEN=$(( LEN1 > LEN2 ? LEN1 : LEN2 ))
    BOX_WIDTH=$((MAX_LEN + PADDING * 2))

    # Centering math
    CENTER_COL=$(( (COLUMNS - BOX_WIDTH) / 2 ))

    # Print top border
    printf "%*s" $CENTER_COL ""
    printf "\033[1;37m"
    printf "%${BOX_WIDTH}s\n" | tr " " "$BORDER_CHAR"

    # Print title line
    printf "%*s" $CENTER_COL ""
    printf "$BORDER_CHAR\033[1;31m%*s%s%*s\033[0m$BORDER_CHAR\n" \
        $PADDING "" "$LINE1" $(( BOX_WIDTH - ${#LINE1} - PADDING - 2 )) ""

    # Print slogan line
    printf "%*s" $CENTER_COL ""
    printf "$BORDER_CHAR\033[1;34m%*s%s%*s\033[0m$BORDER_CHAR\n" \
        $PADDING "" "$LINE2" $(( BOX_WIDTH - ${#LINE2} - PADDING - 2 )) ""

    # Print bottom border
    printf "%*s" $CENTER_COL ""
    printf "\033[1;37m"
    printf "%${BOX_WIDTH}s\n" | tr " " "$BORDER_CHAR"
    printf "\033[0m"
}