#!/usr/bin/env zsh

## mzpm, written by xylous <xylous.e@gmail.com>
# Arguments: `{plugin_author}/{plugin_name}` on GitHub

[[ -z "${MZPM_PLUGINS_DIR}" ]] \
    && export MZPM_PLUGINS_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/mzpm"

# main function
function mzpm()
{
    for plug in "$@"; do
        # Check if plugin is already sourced; if true, then skip
        if [[ "${MZPM_SOURCED_PLUGINS[@]}" =~ "${plug}" ]]; then
            continue
        else
            MZPM_SOURCED_PLUGINS+=("${plug}")
        fi

        local plug_name="$(basename ${plug})"
        if [[ ! -d "${MZPM_PLUGINS_DIR}/${plug_name}" ]]; then
            local plug_author="$(dirname ${plug})"
            mzpm_download_plugin_from_github "${plug_author}" "${plug_name}"
        fi
        mzpm_load_zsh_plugin "${plug_name}" "${plug_dir}"
    done
}

###
# Download a ZSH plugin from github
# Arguments:    $1: plugin author
#               $2: plugin name
#               $3: directory in which the plugin should be installed
###
function mzpm_download_plugin_from_github()
{
    local plug_author="$1"
    local plug_name="$2"
    local plug_link="https://github.com/${plug_author}/${plug_name}"

    echo "mzpm: downloading ${plug_author}/${plug_name}"
    git clone --depth=1 "${plug_link}" "${MZPM_PLUGINS_DIR}/${plug_name}" 2>/dev/null
}

###
# Source a ZSH plugin
# Arguments:    $1: plugin name
#               $2: the directory the plugin was installed in
###
function mzpm_load_zsh_plugin() {
    local plug_name="$1"
    local plug_dir="${MZPM_PLUGINS_DIR}/${plug_name}"

    if [[ -f "${plug_dir}/${plug_name}.plugin.zsh" ]]; then
        source "${plug_dir}/${plug_name}.plugin.zsh"
    elif [[ -f "${plug_dir}/${plug_name}.zsh" ]]; then
        source "${plug_dir}/${plug_name}.zsh"
    elif [[ -f "${plug_dir}/${plug_name}.zsh-theme" ]]; then
        source "${plug_dir}/${plug_name}.zsh-theme"
    fi
    fpath+="${plug_dir}"
}
