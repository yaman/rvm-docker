FROM base/archlinux

MAINTAINER abdulkadir "abdulkadiryaman@gmail.com"
RUN pacman-key --refresh-keys
RUN pacman -Syyu --noconfirm
RUN pacman-db-upgrade
# install the prerequisite patches here so that rvm will install under non-root account. 
RUN pacman -S curl patch gawk gcc make patch sqlite3 autoconf automake libtool bison pkg-config --noconfirm
RUN useradd -ms /bin/bash app
USER app
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"
RUN /bin/bash -l -c "source /home/app/.rvm/scripts/rvm" 
RUN /bin/bash -l -c "rvm install 1.8.7-p299"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "rvm use 1.8.7-p299"
