FROM amazonlinux:2
## SYSTEM SETUP
RUN yum update -y
RUN yum install -y amazon-linux-extras sudo gcc g++ make git zip unzip tar bzip2 wget jq openssl uuid which python3 -y
RUN amazon-linux-extras enable python3.8 
RUN yum install -y python38
RUN amazon-linux-extras install docker 
## INSTALL NEWMAN
RUN curl --silent --location https://rpm.nodesource.com/setup_17.x | bash
RUN yum install nodejs -y
RUN npm install -g newman 
## VSCODE USER Setup
RUN adduser vscode
RUN usermod -aG wheel vscode
RUN usermod -aG docker vscode
RUN echo '%vscode ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER vscode
#### INSTALL POETRY 
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
ENV PATH "/home/vscode/.poetry/bin:$PATH"
RUN poetry config cache-dir --unset \
    && poetry config virtualenvs.path --unset \
    && poetry config installer.parallel true \ 
    && poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true
#### START VENV ON TERMINAL STARTUP
RUN echo "poetry install && source .venv/bin/activate" >> ~/.bashrc
