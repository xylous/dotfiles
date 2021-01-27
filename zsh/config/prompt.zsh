#!/usr/bin/zsh

# Mmm, colours
source ${PLUGIN_DIR}/colours/colours.plugin.zsh

# Highlight current entry in the tab completion menu
zstyle ':completion:*' menu select

# Use LS_COLORS when completing filenames
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

set_prompt() {
    # The structure of the prompt basically looks something like:
    # ┌─SECTION-A1 | SECTION-B1                        SECTION-C1
    # └ SECTION-A2                                   SECTION-C2

    ## Top line
    # Username and hostname
    SECTION_A1="(${FG_ORANGE}%n${FG_CLR}@${FG_BLUE}%m${FG_CLR})"

    # Section B1 is sourced in precmd, as it always needs to be updated (it
    # contains git status of current directory, which is dynamic)

    SECTION_C1=""

    ## Bottom line, aka what you actually use
    SECTION_A2=""
    
    # If the last exit code is > 0, the integer between brackets will be coloured
    # red, otherwise green (indicating success)
    SECTION_C2="[%(?.${FG_GREEN}%?${FG_CLR}.${FG_RED}%?${FG_CLR})]"
}
set_prompt

# Somewhat of an instant prompt?
for i in 1 2 3; do
    print -P "┌─${SECTION_A1} | ${SECTION_B1}"
    print -nrP "$PS1"
    clear
done

# Always update git status for the prompt and print prompt
precmd() {
    source ${PLUGIN_DIR}/gitstatus/gitstatus.plugin.zsh
    SECTION_B1="${FG_LIGHT_RED}%~${FG_CLR} ${GIT_STATUS}"

    LFT_PROMPT=$(print -nP "┌─${SECTION_A1} | ${SECTION_B1}")
    RGT_PROMPT="${SECTION_C1}"
    RGT_LEN=$(($COLUMNS-${#LFT_PROMPT}))

    print -P ${LFT_PROMPT}${(l:$RGT_LEN:)RGT_PROMPT}
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
