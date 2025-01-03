#!/bin/bash

if [ -e "small-init.lua" ]; then
    mv init.lua big-init.lua
    mv small-init.lua init.lua
else
    mv init.lua small-init.lua
    mv big-init.lua init.lua
fi
