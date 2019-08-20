#!/bin/bash

## ---- ROOT6 ----
export ROOTSYS=/Users/tatsuno/cern/ROOT/root6
#export ROOTSYS=/Users/tatsuno/cern/ROOT/root_old
if [ -z "$BASH_VERSION" ]; then
    cdir=$(pwd)
    cd $ROOTSYS/bin
    source thisroot.sh
    echo "ROOT6 setup done."
    cd $cdir
    unset cdir
else
    source $ROOTSYS/bin/thisroot.sh
fi

./g4_sp8 mac/sp8_Pb_event1000M.mac
