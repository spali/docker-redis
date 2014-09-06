FROM phusion/baseimage:0.9.13

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
#######################################################################################

# add repo
RUN add-apt-repository -y ppa:chris-lea/redis-server

# prepare for installation
RUN apt-get update

# install redis server
RUN apt-get install -y redis-server

# setup service script
RUN mkdir /etc/service/redis
ADD redis.sh /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

# setup init script
ADD redis_setup.sh /etc/my_init.d/redis_setup.sh
RUN chmod +x /etc/my_init.d/redis_setup.sh

# expose port
EXPOSE 6379

# define volume mount
VOLUME ["/var/lib/redis"]

#######################################################################################
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
