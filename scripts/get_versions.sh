#!/bin/bash
# Script defining functionality to extract all versions from the NeoVim repository with tag greater
# or equal than a predefined version.

# Minimum NeoVim tag to use
MINIMUM_VERSION=${1}

# Function to compare semantic versions
compare_versions() {
    local version1=$1
    local version2=$2
    if [[ $version1 == $version2 ]]; then
        return 0
    fi

    local IFS=.
    local version1_array=(${version1})
    local version2_array=(${version2})

    for ((i = 0; i < ${#version1_array[@]}; i++)); do
        local num1=${version1_array[i]}
        local num2=${version2_array[i]}
        if ((num1 > num2)); then
            return 0
        elif ((num1 < num2)); then
            return 1
        fi
    done
}

all_nvim_releases=($(curl -s https://api.github.com/repos/neovim/neovim/releases | jq ".[].tag_name"))
# all_nvim_releases=("v0.1.0" "v0.2.0" "v0.3.0" "v0.4.0" "v0.9.0" "v0.10.0" "v0.11.0")
selected_nvim_releases=()
for release in ${all_nvim_releases[@]}; do
    release=$(echo ${release} | tr -d '"')
    if [[ "${release}" != v* ]]; then
        continue
    fi
    cleaned_release=$(echo ${release/"v"/} | tr -d '"')
    if compare_versions ${cleaned_release} ${MINIMUM_VERSION}; then
        selected_nvim_releases+=("{\"release\": \"${release}\"},")
    fi
done
echo "{ \"include\": [" ${selected_nvim_releases[@]} "]}" | sed 's/,\([^,]*\)$/ \1/'
