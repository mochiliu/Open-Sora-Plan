FROM nvcr.io/nvidia/pytorch:23.10-py3
ARG DEBIAN_FRONTEND=noninteractive

# Pre-install packages, pip install requirements and run post install script.
COPY packages.txt .
COPY requirements.txt .
RUN apt-get update && apt-get install -y sudo $(cat packages.txt)
RUN pip install --no-cache-dir -r requirements.txt
#RUN bash postinstallscript.sh

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ARG USER_UID
ARG USERNAME
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME \
    && adduser $USERNAME sudo

WORKDIR /home/${USERNAME}/workspace
COPY postinstallscript.sh /home/${USERNAME}/workspace/

# Set the prompt to highlight the username
RUN echo "export PS1='\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$'" >> /home/${USERNAME}/.bashrc
