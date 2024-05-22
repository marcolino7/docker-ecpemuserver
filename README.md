# EcpEmuServer Docker Image

## EcpEmuServer
https://github.com/logantgt/EcpEmuServer

EcpEmuServer is a small ASP.NET application which allows you to add an emulated Roku ECP (external control protocol) device to your compatible universal remote in order to trigger webhooks.

Discussion about this container and thank to [erdoking](https://github.com/erdoking):
https://github.com/logantgt/EcpEmuServer/issues/7

## Docker Image
This is a Dockerfile to create a Docker image to run EcpEmuServer

### Caveats and Consideration
EcpEmuServer and Roku use Multicast to discover object, so the container must be binded to host network in order to do the trick.
* https://github.com/moby/libnetwork/issues/2397#issuecomment-935029813
* https://stackoverflow.com/questions/42422406/receive-udp-multicast-in-docker-container
So only one istance of EcpEmuServer can be spinned up on a single docker/IP Address

### Build Image
On a docket server clone this repository and run:

```
docker build -t docker-ecpemuserver .
```

### Spin up the container
In order to make EcpEmuServer configurable, a couple of file mapping are available. Following a full example:

```
docker run -d \
	--name EcpEmuServer \
	--net=host \
	--restart=unless-stopped \
	-v /your/path/to/EcpEmuServer/devicename:/var/EcpEmuServer/devicename \
	-v /your/path/to/EcpEmuServer/rules.xml:/var/EcpEmuServer/rules.xml \
	docker-ecpemuserver:latest
```
