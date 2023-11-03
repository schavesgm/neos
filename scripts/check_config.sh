#!/bin/bash

NEOVIM_EXEC=${1}

${NEOVIM_EXEC} -u init.lua -V1output.log +:q
CONTAINS_ERROR=$(grep -q "Error detected while processing" output.log; echo $?)
rm ./output.log
if [ "${CONTAINS_ERROR}" -eq "0" ]; then
    exit 1
fi
