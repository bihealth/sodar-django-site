#!/usr/bin/env bash

WORK_DIR="$(dirname "$0")"
PROJECT_DIR="$(dirname "$WORK_DIR")"

pip --version >/dev/null 2>&1 || {
    echo >&2 -e "\npip is required but it's not installed."
    echo >&2 -e "You can install it by running the following command:\n"
    echo >&2 "curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3.x"
    echo >&2 -e "\n"
    echo >&2 -e "\nFor more information, see pip documentation: https://pip.pypa.io/en/latest/"
    exit 1;
}
if [ -z "$VIRTUAL_ENV" ]; then
    echo >&2 -e "\nYou need activate a virtualenv first"
    echo >&2 -e 'If you do not have a virtualenv created, run the following command to create and automatically activate a new virtualenv named "venv" on current folder:\n'
    echo >&2 -e "python3.x -m venv .venv"
    echo >&2 -e "\nTo leave/disable the currently active venv, run the following command:\n"
    echo >&2  "deactivate"
    echo >&2 -e "\nTo activate the virtualenv again, run the following command:\n"
    echo >&2  "source .venv/bin/activate"
    echo >&2 -e "\n"
    exit 1;
else
    pip install "wheel>=0.45.1, <0.46"
    pip install -r $PROJECT_DIR/requirements/local.txt
    pip install -r $PROJECT_DIR/requirements/test.txt
    pip install -r $PROJECT_DIR/requirements.txt
fi
