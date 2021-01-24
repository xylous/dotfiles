#!/usr/bin/zsh

###
# Do some cleaning if not in a git repository
# Globals:
#   all
# Arguments:
#   none
###
sanitize() {
    if ! git rev-parse --git-dir &>/dev/null; then
        GIT_HAS_CHANGES=false
        GIT_BRANCH=""
        GIT_STAGED=""
        GIT_MODIFIED=""
        GIT_UNTRACKED=""
        GIT_STATUS=""
        return 1
    fi

    return 0
}

###
# Get necessary information from git, like current branch, amount of modified
# files etc. to then put them all into a global variable, GIT_STATUS
# Globals:
#   none
# Arguments:
#   none
###
parse_git_status() {
    local modified_files=0 staged_files=0 untracked_files=0 deleted_files=0
    GIT_HAS_CHANGES=0
    GIT_BRANCH=" $(git branch --show-current)"

    git status --porcelain=v1 | while IFS= read -r status_line; do
        case "$status_line" in
            ' M '*) 
                ((modified_files++))
                GIT_HAS_CHANGES=1
                ;;
            'A  '*)
                ((staged_files++))
                GIT_HAS_CHANGES=1
                ;;
            ' D '*)
                ((deleted_files++))
                GIT_HAS_CHANGES=1
                ;;
            '?? '*)
                ((untracked_files++))
                GIT_HAS_CHANGES=1
                ;;
            'MM '*)
                GIT_HAS_CHANGES=1
                ((staged_files++))
                ((modified_files++))
                ;;
        esac
    done

    GIT_REMOTE_BRANCH=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)")
    local ahead_behind_status commits_behind commits_ahead
    if [[ ! -z ${GIT_REMOTE_BRANCH} ]]; then
        ahead_behind_status=$(git rev-list --left-right --count ${GIT_BRANCH}...${GIT_REMOTE_BRANCH})
        commits_behind=$(echo -n "$ahead_behind_status" | awk '{print $1}')
        commits_ahead=$(echo -n "$ahead_behind_status" | awk '{print $2}')
        
        (( ${commits_behind} > 0))  \
            && GIT_COMMITS_BEHIND="↓${commits_behind}" \
            || GIT_COMMITS_BEHIND=""
        (( ${commits_ahead} > 0))  \
            && GIT_COMMITS_AHEAD="↑${commits_ahead}" \
            || GIT_COMMITS_AHEAD=""
    fi

    (( ${staged_files} > 0 )) \
        && GIT_STAGED="${GREEN}${staged_files}+${CLR}" \
        || GIT_STAGED=""
    (( ${modified_files} > 0 )) \
        && GIT_MODIFIED="${RED}!${modified_files}${CLR}" \
        || GIT_MODIFIED=""
    (( ${untracked_files} > 0 )) \
        && GIT_UNTRACKED="?${untracked_files}" \
        || GIT_UNTRACKED=""
    (( ${deleted_files} > 0 )) \
        && GIT_DELETED="${RED}${deleted_files}-${CLR}" \
        || GIT_DELETED=""
    
    if (( GIT_HAS_CHANGES == 1 )); then
        FG_SPECIAL_COLOR="${FG_YELLOW}"
    else
        FG_SPECIAL_COLOR="${FG_GREEN}"
    fi

    GIT_COMMITS_STATUS="${GIT_COMMITS_AHEAD}${GIT_COMMITS_BEHIND}"

    GIT_STATUS="| ${FG_SPECIAL_COLOR}"
    GIT_STATUS+="${GIT_BRANCH} "
    GIT_STATUS+="${GIT_COMMITS_STATUS}"
    GIT_STATUS+="${GIT_STAGED} ${GIT_MODIFIED} "
    GIT_STATUS+="${GIT_DELETED} ${GIT_UNTRACKED}"
    GIT_STATUS+="${FG_CLR}"
}

###
# Control script from here
# Globals:
#   none
# Arguments:
#   none
###
main() {
    if ! sanitize; then
        return 0
    fi

    parse_git_status
}

main
