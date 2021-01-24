#!/usr/bin/zsh

# Because who doesn't love 'em
set_colours() {
    FG_GREEN='%F{34}'
    FG_YELLOW='%F{220}'
    FG_RED='%F{9}'
    FG_LIGHT_RED='%F{red}'
    FG_BLUE='%F{68}'
    FG_ORANGE='%F{214}'
    FG_CLR='%F{white}'

    return 0
}
set_colours

set_prompt() {
    # The structure of the prompt basically looks something like:
    # ┌─SECTION-A1 | SECTION-B1                        SECTION-C1
    # └ SECTION-A2                                   SECTION-C2

    ## Top line
    # Username and hostname
    SECTION_A1='(${FG_ORANGE}%n${FG_CLR}@${FG_BLUE}%m${FG_CLR})'

    # Current path
    SECTION_B1='${FG_LIGHT_RED}%~${FG_CLR} ${GIT_STATUS}'

    SECTION_C1=''

    ## Bottom line, aka what you actually use
    SECTION_A2=''
    
    # If the last exit code is > 0, the integer between brackets will be coloured
    # red, otherwise green (indicating success)
    SECTION_C2='[%(?.${FG_GREEN}%?${FG_CLR}.${FG_RED}%?${FG_CLR})]'
}
set_prompt

# Somewhat of an instant prompt?
for i in 1 2 3; do
    print -P "┌─${SECTION_A1} | ${SECTION_B1}"
    print -nrP "$PS1"
    clear
done

# ZSH calls this function before drawing the PS1 prompt. By some reason, putting
# the code I put in the previous function does not run here, so the workaround
# is to put it somewhere else, aka 'draw_first_line_of_prompt'
precmd() {
    source ${ZDOTDIR}/plugins/gitstatus.zsh
    LFT_PROMPT=$(print -nP "┌─${SECTION_A1} | ${SECTION_B1}")
    RGT_PROMPT="${SECTION_C1}"
    RGT_LEN=$(($COLUMNS-${#LFT_PROMPT})) print -P ${LFT_PROMPT}${(l:$RGT_LEN:)RGT_PROMPT}
}

set_actual_prompts() {
    # Prompt used interactively (so, most of the time)
    export PS1="└ ${SECTION_A2}"
    export RPS1="${SECTION_C2}  "

    # Continuation line prompt
    export PS2="(inp)> "

    # Prompt used by "select" shell builtin
    export PS3="#?"

    # Prompt used by "set -x" option, prefixing each line of traced input
    export PS4="%N:%i>"
}
set_actual_prompts

# Redefine zle builtin to not clean precmd output
clear-screen() {
    echoti clear
    precmd
    zle redisplay
}

# Update function
zle -N clear-screen
