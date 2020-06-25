#!/bin/sh

. "/opt/conda/etc/profile.d/conda.sh"
conda activate wradlib
exec $@

