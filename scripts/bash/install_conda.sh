#!/usr/bin/env bash
#--------------------------------------------------------------------------------
# Anaconda installation
# Go https://www.anaconda.com/products/individual and find the package link URL.
# https://docs.anaconda.com/anaconda/install/silent-mode/#
# https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
#--------------------------------------------------------------------------------
RELEASE='2021.05'
OS=Linux
ARCH='x86_64'
EXT=sh
CONDA_INSTALLER="Anaconda3-${RELEASE}-${OS}-${ARCH}.${EXT}"

curl -O https://repo.anaconda.com/archive/${CONDA_INSTALLER}

# -b —Batch mode with no PATH modifications to ~/.bashrc. Does not edit the .bashrc or .bash_profile files.
# -p —Installation prefix/path.
# -f —Force installation even if prefix -p already exists.
/bin/bash ${CONDA_INSTALLER} -b -f -p $HOME/conda

#echo -e '\nexport PATH=$HOME/conda/bin:$PATH' >> $HOME/.bashrc_anaconda && source $HOME/.bashrc_anaconda
cat << 'EOF' > $HOME/.bashrc_anaconda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/conda/etc/profile.d/conda.sh" ]; then
        . "$HOME/conda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF
source $HOME/.bashrc_anaconda

conda config --set auto_activate_base true
conda config --add channels conda-forge
conda init

#conda  install -y scipy numpy scikit-learn pandas seaborn matplotlib jupyter notebook scikit-learn