FROM anselmos/ubuntu32:latest

MAINTAINER github.com/anselmos
ENV virtualenv_ver 1.9
ENV HOSTNAME devel_in_python

RUN echo $HOSTNAME > /etc/hostname
RUN apt-get update -y
RUN apt-get install -y tar
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y zip
RUN apt-get install -y git
RUN apt-get install -y sqlite3
RUN apt-get install -y python
RUN curl -O https://pypi.python.org/packages/source/v/virtualenv/virtualenv-$virtualenv_ver.tar.gz \
    && tar xvfz virtualenv-$virtualenv_ver.tar.gz \
    && cd virtualenv-$virtualenv_ver \
    && python setup.py install \
    && cd .. \
    && rm -rf virtualenv-$virtualenv_ver \
    && rm -rf virtualenv-$virtualenv_ver.tar.gz

RUN apt-get install -y vim
RUN apt-get install -y bash-completion
RUN apt-get install -y screen
RUN git clone https://github.com/anselmos/unix_settings.git 

# Replace 1000 with your user / group id
# RUN export uid=1000 gid=1000 && \
#     mkdir -p /home/developer && \
#     echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
#     echo "developer:x:${uid}:" >> /etc/group && \
#     echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#     chmod 0440 /etc/sudoers.d/developer && \
#     chown ${uid}:${gid} -R /home/developer
RUN adduser --disabled-login --gecos 'developer' -- developer; \
    passwd -d developer;
ENV HOME /home/developer

RUN chown developer:developer -R /unix_settings
RUN mv /unix_settings/.vim* ~developer/
RUN mv /unix_settings/.profile* ~developer/
RUN mv /unix_settings/.gitconfig ~developer/
RUN mv /unix_settings/.bash* ~developer/

# RUN chown developer /dev/console
USER root
# CMD cd ~ && bash
ENTRYPOINT login developer
