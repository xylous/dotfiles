#!/usr/bin/zsh

# Mmm, colours
source ${PLUGIN_DIR}/colours/colours.plugin.zsh

# Use LS_COLORS when completing filenames
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

function set_prompt() {
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

# Always update git status for the prompt and draw upper part of prompt
function precmd() {
    source ${PLUGIN_DIR}/gitstatus/gitstatus.plugin.zsh
    SECTION_B1="${FG_LIGHT_RED}%~${FG_CLR} ${GIT_STATUS}"

    LFT_PROMPT=$(print -nP "┌─${SECTION_A1} | ${SECTION_B1}")
    RGT_PROMPT="${SECTION_C1}"
    RGT_LEN=$(($COLUMNS-${#LFT_PROMPT}))

    print -P ${LFT_PROMPT}${(l:$RGT_LEN:)RGT_PROMPT}
}

function set_actual_prompts() {
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
function clear-screen() {
    echoti clear
    precmd
    zle redisplay
}

# Update zle to use previously defined function
zle -N clear-screen

# Dunno what this does, but apparently it does something essential for the
# previous function to work correctly.
function zle-line-init() {
    (( ! ${+terminfo[smkx]} )) || echoti smkx
}
zle -N zle-line-init

# Pressing UP and DOWN keys will go up and down in the entries in hitory that
# start with what has already been typed in
function search_history_with_text_already_inputted() {
    # If not using zsh-history-substring-search plugin, use:
    #autoload -U history-search-end
    #zle -N history-beginning-search-backward-end history-search-end
    #zle -N history-beginning-search-forward-end history-search-end
    #bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
    #bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end

    # Otherwise, use this:
    bindkey "${terminfo[kcuu1]}" history-substring-search-up
    bindkey "${terminfo[kcud1]}" history-substring-search-down
}

function set_tab_completion_menu_bindings() {
    # Highlight current entry in the tab completion menu
    zstyle ':completion:*' menu select
    zmodload zsh/complist

    # Use hjkl to navigate tab completion menu
    bindkey -M menuselect "h" vi-backward-char
    bindkey -M menuselect "j" vi-down-line-or-history
    bindkey -M menuselect "k" vi-up-line-or-history
    bindkey -M menuselect "l" vi-forward-char

    # Use Ctrl-[N|P] to navigate tab completion menu
    bindkey '^N' expand-or-complete
    bindkey '^P' reverse-menu-complete
}

function set_key_bindings() {
    # Enable vim mode
    bindkey -v

    # Remove character under cursor when the <Delete> key is pressed
    bindkey "^[[3~" vi-delete-char
    bindkey -a "^[[3~" vi-delete-char

    # Move just a character when Ctrl-[LEFT|RIGHT] is pressed
    bindkey "^[[1;5D" backward-char
    bindkey "^[[1;5C" forward-char

    search_history_with_text_already_inputted

    set_tab_completion_menu_bindings
}
set_key_bindings
