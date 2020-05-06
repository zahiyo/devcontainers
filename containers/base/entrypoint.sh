#!/bin/zsh

set -e

# Configure Git
if [[ -n "${GIT_USER_EMAIL}" && -n "${GIT_USER_NAME}" ]]; then
    git config --global user.email "${GIT_USER_EMAIL}"
    git config --global user.name "${GIT_USER_NAME}"
fi

exec $@