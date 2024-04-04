#!/bin/bash
## Shell script to install conda to /lustre/conda directory

## Set up some useful environment variables
export DIR=/lustre

export PATH=/lustre/conda/bin:$PATH
export ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh"
export SHA256SUM="111ce0a7f26e606863008a9519fd608b1493e483b6f487aea71d82b13fe0967e"

## Download, Verify, and Install
wget "${ANACONDA_URL}" -O anaconda.sh -q
echo "${SHA256SUM} anaconda.sh" > shasum
sha256sum --check --status shasum
/bin/bash anaconda.sh -b -p /${DIR}/conda
rm anaconda.sh shasum
ln -s /${DIR}/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

## Add to bashrc
echo ". /${DIR}/conda/etc/profile.d/conda.sh" >> ~/.bashrc
echo "conda activate base" >> ~/.bashrc

## Cleanup
find /${DIR}/conda/ -follow -type f -name '*.a' -delete
find /${DIR}/conda/ -follow -type f -name '*.js.map' -delete
/${DIR}/conda/bin/conda clean -afy

