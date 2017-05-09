#!/bin/sh

# add wradlib user
USER_ID=${LOCAL_USER_ID:-9001}
echo "Container USER_ID : $USER_ID"
adduser -s /bin/bash -m -u $USER_ID wradlib

# chown home directory
export HOME=/home/wradlib
chown -R wradlib $HOME
chown -R wradlib $CONDA_DIR

# use su-exec to run the process as wradlib
su-exec wradlib $@
