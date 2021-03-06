# Base Image, I used an Ubuntu
FROM ubuntu:latest

# Adds metadata to the image as a key value pair example LABEL version="1.0"
LABEL maintainer="Ali Fazeli <a.fazeli95@gmail.com>"

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 PATH=/opt/conda/bin:$PATH

# create empty directory to attach volume
RUN mkdir ~/my_project && \
    # install Ubuntu packages
    apt-get update --fix-missing && \
    apt-get install -y \
    wget \
    ca-certificates \
    git-core \
    pkg-config \
    tree \
    bzip2 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    mercurial \
    subversion \
    freetds-dev && \
    # clean up the mess
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Install Jupyter config (Injecting the needful config files from my gitlab repository)
    mkdir ~/.ssh && touch ~/.ssh/known_hosts && \
    ssh-keygen -F github.com || ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    git clone https://gitlab.com/alifzl/cus_jup.git && \
    mkdir ~/.jupyter && \
    mkdir -p ~/.jupyter/custom && \
    mkdir -p ~/.jupyter/nbconfig && \
    cp /cus_jup/jupyter_notebook_config.py ~/.jupyter/ && \
    cp /cus_jup/custom/custom.js ~/.jupyter/custom/ && \
    cp /cus_jup/nbconfig/notebook.json ~/.jupyter/nbconfig/ && \
    rm -rf /cus_jup && \
    # Install Anaconda using it's official .sh file
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    # Update Anaconda's libraries to the latest...
    conda update conda && \
    conda update anaconda && \
    conda update --all && \
    # Install Jupyter theme for customizing the jupyter lab environment
    pip install jupyterthemes && \
    jt -t grade3 && \ 
    # Install other Python packages (whether it's resolvable using pip or conda )
    conda install pymssql && \
    pip install SQLAlchemy \
        quilt \
        missingno \
        json_tricks \
        bcolz \
        elasticsearch \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator && \
    # Enable Jupyter Notebook extensions
    jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user && \
    jupyter nbextension enable codefolding/main && \
    jupyter nbextension enable collapsible_headings/main && \
    # remove everything you don't need
    apt-get remove -y wget git-core pkg-config
 
 # Configure access to Jupyter
WORKDIR /root/my_project
EXPOSE 8888
CMD jupyter lab --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='my_custom_jupyter'