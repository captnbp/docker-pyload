FROM	ubuntu:14.04
MAINTAINER	Benoît Pourre "benoit.pourre@gmail.com"

RUN	locale-gen en_US en_US.UTF-8

# Make sure we don't get notifications we can't answer during building.
ENV	DEBIAN_FRONTEND noninteractive

# Update the system
RUN	apt-get -q update
RUN	apt-mark hold initscripts udev plymouth mountall
RUN	apt-get -qy --force-yes dist-upgrade
#RUN	apt-get install -qy python-software-properties software-properties-common
RUN	apt-get install -qy --force-yes git supervisor 
RUN	apt-get install -y python-crypto python-pycurl tesseract-ocr git supervisor python-imaging python-pillow python-openssl

### Checkout pyload sources
RUN	git clone https://github.com/pyload/pyload.git /srv/pyload

#Volume for pyload DB, logs, cache and configuration
VOLUME  /data
#Volume for media folders
VOLUME  /media/downloads

#Expose ports
EXPOSE  8000 7227

# Configure a localshop user
# Prepare user
RUN     addgroup --system downloads -gid 1001
RUN     adduser --system --gecos downloads --shell /usr/sbin/nologin --uid 1001 --gid 1001 --disabled-password  downloads

# Clean up
RUN	apt-get -y autoclean && apt-get -y autoremove && apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

### Configure Supervisor
ADD     ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD     ./supervisor/conf.d/pyload.conf /etc/supervisor/conf.d/pyload.conf

### Add PyLoad Config Dir
ADD 	pyload /data
RUN	chown -R downloads:downloads /data
ENTRYPOINT	["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf"]
