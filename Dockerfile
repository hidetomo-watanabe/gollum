FROM ruby
MAINTAINER hidetomo

# create user
RUN useradd hidetomo
RUN mkdir /home/hidetomo && chown hidetomo:hidetomo /home/hidetomo

# sudo
RUN apt-get -y update
RUN apt-get -y install sudo
RUN echo "hidetomo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# change user and dir
USER hidetomo
WORKDIR /home/hidetomo
ENV HOME /home/hidetomo

# alias
RUN echo "alias ls='ls --color'" >> .bashrc
RUN echo "alias ll='ls -la'" >> .bashrc

# common apt-get
RUN sudo apt-get -y install vim
RUN sudo apt-get -y install less

# change dir
RUN mkdir /home/hidetomo/gollum
WORKDIR /home/hidetomo/gollum

# gollum
RUN sudo apt-get -y install libicu-dev
RUN sudo gem install gollum
RUN sudo gem install github-markdown
RUN mkdir wiki
RUN cd wiki; git init

# change dir
WORKDIR /home/hidetomo

# start
COPY start.sh start.sh
RUN sudo chown hidetomo:hidetomo start.sh
CMD ["/bin/bash", "/home/hidetomo/start.sh"]
