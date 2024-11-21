#!/usr/bin/env bash

# Where is this script executing from ?
BASEDIR=$(dirname "$0");pushd $BASEDIR 2>&1 >> /dev/null ;BASEDIR=$(pwd);popd 2>&1 >> /dev/null
export ORIGINAL_DIR=$(pwd)
cd "${BASEDIR}"

#--------------------------------------------------------------------------
#
# Set Colors
#
#--------------------------------------------------------------------------
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

red=$(tput setaf 1)
green=$(tput setaf 76)
white=$(tput setaf 7)
blue=$(tput setaf 25)

#--------------------------------------------------------------------------
#
# Headers and Logging
#
#--------------------------------------------------------------------------

h1() { printf "\n${underline}${bold}${blue}%s${reset}\n" "$@" ;}
h2() { printf "\n${underline}${bold}${white}%s${reset}\n" "$@" ;}
success() { printf "${green}✔ %s${reset}\n" "$@" ;}
error() { printf "${red}✖ %s${reset}\n" "$@" ;}

#--------------------------------------------------------------------------
#
# Main Script Logic
#
#--------------------------------------------------------------------------
properties_file='gradle.properties'
local_java=''


function get_local_java_version {
    # redirect stderr to stdout 
    # gets first line, splits by " and gets second element whihc is the version number
    # removes leading '1.' and then gets first part of remaining string which is the major version
    local_java=$(java -version 2>&1 \
    | head -1 \
    | cut -d'"' -f2 \
    | sed 's/^1\.//' \
    | cut -d'.' -f1)
    rc=$?
    if [[ "${rc}" != "0" ]]; then
        error "Java not found. Please install Java."
        exit 1
    fi
    success "Java version found: $local_java"


}

function update_gradle_proprties_java_version {
    if [ -f "$properties_file" ]; then
        echo "Path to gradle.properties file found."

        sed -i -e "s/^java_version.*/java_version=${local_java}/" $properties_file

        rc=$?
        if [[ "${rc}" != "0" ]]; then
            error "Failed to change java version in gradle.properties file."
            exit 1
        fi
        success "Property updated successfully."
    else
    echo "Path to gradle.properties file not found."
    fi
}


function gradle_build {
    h2 "Building the sample with Gradle"
    gradle clean assemble
    rc=$?
    if [[ "${rc}" != "0" ]]; then
        error "Failed to build the sample with Gradle and Java version $local_java."
        exit 1
    fi
    success "OK"
}

function maven_build {
    h2 "Building the sample with Maven"
    mvn clean package
    rc=$?
    if [[ "${rc}" != "0" ]]; then
        error "Failed to build the sample with Maven and Java version $local_java."
        exit 1
    fi
    success "OK"
}


get_local_java_version
update_gradle_proprties_java_version
gradle_build
maven_build