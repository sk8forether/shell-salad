#!/bin/bash

# A simple script for building the base Docker image and checking logs
## To use this script, call the following command from this directory:
##
##  ./docker-build-base.sh
##
## This will default to using the definition file named "Dockerfile"
## set the tag to "test", and name the image "sk8forether/testing".
## If you prefer to use a different build file, tag, or organization/repo
## for uploading to Docker Hub, then use the following command and replace the
## info in <brackets>:
##
##  ./docker-build-base.sh <name_of_dockerfile> <tag> <organization> <repo>
##

DOCKERFILE=$1
DOCKER_TAG=$2
ORGANIZATION=$3
REPOSITORY=$4

export SHOW_OUTPUT=1
export SUMMARY=1

if [[ $DOCKERFILE == "" ]]; then
    export DOCKERFILE="Dockerfile"
fi

if [[ $DOCKER_TAG == "" ]]; then
    export DOCKER_TAG="test"
fi

if [[ $ORGANIZATION == "" ]]; then
    export ORGANIZATION="sk8forether"
fi

if [[ $REPOSITORY == "" ]]; then
    export REPOSITORY="testing"
fi

export CURRENT_BUILD_IMG_TAG=${ORGANIZATION}/${REPOSITORY}:${DOCKER_TAG}
export BUILD_OUTPUT_FILE=./build_output_${ORGANIZATION}_${REPOSITORY}_${DOCKER_TAG}.txt

echo "Build started for ${CURRENT_BUILD_IMG_TAG} using the definition specified it the file: ${DOCKERFILE}, build process output will be stored in ${BUILD_OUTPUT_FILE}"

if [[ $SHOW_OUTPUT ]]; then
    # Save build output log AND print to screen
    echo "Build output now printing to the screen..."
    docker build --network=host --tag ${CURRENT_BUILD_IMG_TAG} -f $DOCKERFILE . 2>&1 | tee $BUILD_OUTPUT_FILE
else
    # Save build output log only 
    docker build --network=host --tag ${CURRENT_BUILD_IMG_TAG} -f $DOCKERFILE . 2>&1 > $BUILD_OUTPUT_FILE
fi

# Print Summary
if [[ $SUMMARY ]]; then
    echo "-------------------------------------------------------------"
    echo "Build process stopped (either failed or completed).  Check output file for final status.  Errors:"
    cat ${BUILD_OUTPUT_FILE} | grep ERROR
    cat ${BUILD_OUTPUT_FILE} | grep Error
    echo "-------------------------------------------------------------"
    echo "Tail of build output:"
    cat ${BUILD_OUTPUT_FILE} | tail
fi
