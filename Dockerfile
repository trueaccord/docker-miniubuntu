FROM phusion/baseimage:latest-amd64
MAINTAINER TrueAccord

# Set the locale
#RUN locale-gen en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8
RUN echo en_US.UTF-8 UTF-8 > /var/lib/locales/supported.d/en
COPY installpkg /usr/sbin/installpkg
RUN chmod 755 /usr/sbin/installpkg

RUN sed -i.bak s/archive\.ubuntu\.com/us-west-2.ec2.archive.ubuntu.com/ /etc/apt/sources.list \
 && apt-get -qq update \
 && apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
 && apt-get clean \
 && apt-get autoremove -y --purge \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/