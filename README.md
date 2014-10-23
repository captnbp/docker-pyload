docker-Pyload
============

A nice and easy way to get a Pyload instance up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on Pyload and check out it's [website][1].


## Building

Running this will build you a docker image with the latest version of docker-pyload

    docker build -t captnbp/docker-pyload git://github.com/captnbp/docker-pyload.git


## Running Pyload

You can run this container with:

    sudo docker run -d -p 8000:8000 -p 7227:7227 -v /mydownloadfolder:/media/downloads captnbp/docker-pyload

From now on when you start/stop docker-pyload you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `captnbp/docker-pyload:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>

### Notes on the run command

 + `-v` is the volume you are mounting `-v host_dir:docker_dir`
 + `-d  allows this to run cleanly as a daemon, remove for debugging
 + `-p  is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: http://pyload.org/
