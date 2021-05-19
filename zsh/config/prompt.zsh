#!/usr/bin/zsh

function set_colours() {
    # FG = ForeGround
    FG_CLR='%F{default}'

    FG_YELLOW='%F{11}'
    FG_GREEN='%F{34}'
    FG_RED='%F{9}'
    FG_BLUE='%F{68}'

    FG_USERNAME='%F{167}'
    FG_HOSTNAME='%F{67}'
    FG_PATH="%F{43}"

    # BG = BackGround
    BG_CLR='%K{default}'
}
set_colours

# Use LS_COLORS when completing filenames
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

function define_prompt_structure() {
    # The structure of the prompt basically looks something like:
    # ┌─SECTION-A | SECTION-B | SECTION-C
    # └                                                SECTION-D

    ## Top line
    # Username and hostname
    SECTION_A="(${FG_USERNAME}%n${FG_CLR}@${FG_HOSTNAME}%m${FG_CLR})"

    # Path
    SECTION_B="${FG_PATH}%~${FG_CLR}"

    # Git status, coming from a custom script. Defined in the precmd() function

    # If the last exit code is > 0, the integer between brackets will be coloured
    # red, otherwise green (indicating success)
    SECTION_D="[%(?.${FG_GREEN}%?${FG_CLR}.${FG_RED}%?${FG_CLR})]"
}
define_prompt_structure

### 
# Usage: fill_line LEFT RIGHT
# Sets REPLY to LEFT<spaces>RIGHT with enough spaces in the middle to fill a
# terminal line.
###
function fill_line() {
    emulate -L zsh
    prompt_length $1
    local -i left_len=$REPLY
    prompt_length $2 9999
    local -i right_len=$REPLY
    local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
    if (( pad_len < 1 )); then
        # Not enough space for the right part. Drop it.
        typeset -g REPLY=$1
    else
        local pad=${(pl.$pad_len.. .)}  # pad_len spaces
        typeset -g REPLY="${1}${pad}${2}"
    fi
}

###
# Usage: prompt_length PROMPT
# Determines the length of the outputted text of a string with zsh prompt syntax
###
function prompt_length() {
    emulate -L zsh
    local -i COLUMNS=${2:-COLUMNS}
    local -i x y=${#1} m
    if (( y )); then
        while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
            x=y
            (( y *= 2 ))
        done
        while (( y > x + 1 )); do
            (( m = x + (y - x) / 2 ))
            (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
        done
    fi
    typeset -g REPLY=$x
}

# Always update git status for the prompt and draw upper part of prompt
function precmd() {
    source $PLUGIN_DIR/gitstatus/gitstatus.plugin.zsh
    SECTION_C="$GIT_STATUS"

    local top_left="┌─${SECTION_A} | ${SECTION_B}"
    local top_right="${SECTION_C}"
    local bottom_left="└ "
    fill_line "$top_left" "$top_right"
    export PS1=$REPLY$'\n'$bottom_left
}

function set_prompts() {
    export RPS1="${SECTION_D}"

    # Continuation line prompt
    export PS2="(inp)> "

    # Prompt used by "select" shell builtin
    export PS3="#?"

    # Prompt used by "set -x" option, prefixing each line of traced input
    export PS4="%N:%i>"
}
set_prompts

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
