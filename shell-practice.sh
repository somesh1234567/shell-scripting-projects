#!/bin/bash

##########################
# Author: Somesh Panigrahi
# About: This Script is used to list all the repositories of a user
# Input: it needs username and token as command line arguments
# Output: it will list all the repos for a user in a raw format
###########################

GITHUB_MAIN_URL="https://api.github.com"

USERNAME=$1
# this is a normal shell variable which is converted to env variable by using "export" command. it means in bash terminal type "export GITHUB_TOKEN=<token>"
TOKEN=$GITHUB_TOKEN

function build_github_url {
    local github_endpoint="$1"
    local url="${GITHUB_MAIN_URL}/${github_endpoint}"
    local token_url="Authorization: Bearer ${TOKEN}"

    curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "$token_url" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$url"
}

function github_api {
    local endpoint="users/${USERNAME}/repos"
    final_data="$(build_github_url "$endpoint" | jq -r '.[] | .name')"

    if [[ -z "$final_data" ]]; then
        echo "No repo is found for user:${USERNAME}"
    else
        echo "Listing Repos for user:${USERNAME}"
        echo "$final_data"
    fi
}

# Main Script
github_api
