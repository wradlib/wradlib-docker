#!/bin/sh

# add wradlib user
USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-100} 
USER_NAME=${LOCAL_USER_NAME:-wradlib}
echo "Container USER_ID : $USER_ID"
echo "Container GROUP_ID : $GROUP_ID"
echo "Container USER_NAME : $USER_NAME"

useradd -s /bin/bash -m -u $USER_ID -g $GROUP_ID $USER_NAME

# chown home directory
export HOME=/home/$USER_NAME
chown -R $USER_NAME $HOME
chown -R $USER_NAME $CONDA_DIR

# use su-exec to run the process as wradlib
su-exec $USER_NAME $@
