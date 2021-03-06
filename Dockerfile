FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Sotetsu KOYAMADA

RUN apt-get update --fix-missing && apt-get install -y wget git

# Install miniconda and python packages
# This is a fork of 
#   - https://github.com/ContinuumIO/docker-images/blob/master/miniconda/Dockerfile
#   - https://github.com/smly/alpine-kaggle/blob/master/Dockerfile
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.14-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    /opt/conda/bin/conda install -y scikit-learn numpy scipy pandas && \
    /opt/conda/bin/pip install awscli click tqdm && \
    /opt/conda/bin/conda install pytorch torchvision cuda80 -c soumith && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]
