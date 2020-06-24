#!/bin/sh

echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate wradlib" >> /etc/skel/.bashrc
echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate wradlib" >> ~/.bashrc

# add wradlib user
USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-100} 
USER_NAME=${LOCAL_USER_NAME:-wradlib}
echo "Container USER_ID : ${USER_ID}"
echo "Container GROUP_ID : ${GROUP_ID}"
echo "Container USER_NAME : ${USER_NAME}"

useradd -s /bin/bash -m -u ${USER_ID} -g ${GROUP_ID} ${USER_NAME}

# chown home directory
export HOME=/home/${USER_NAME}

mkdir ${HOME}/.jupyter
echo "c.MultiKernelManager.default_kernel_name = 'wradlib'" >> ${HOME}/.jupyter/jupyter_notebook_config.py

chown -R ${USER_NAME}:${GROUP_ID} ${HOME}
chown -R ${USER_NAME}:${GROUP_ID} ${CONDA_DIR}

# use su-exec to run the process as wradlib
echo $@
su-exec ${USER_NAME} $@
