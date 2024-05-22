FROM debian:latest
MAINTAINER Marcolino <marcolino7@infinito.it>

#Create Temp Directory
WORKDIR /temp

#Run OS upgrade and install required component
RUN apt-get update
RUN apt-get install wget -y
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install wget curl unzip dotnet-sdk-7.0  -y


#Download and unzip EcpEmuServer
RUN wget https://github.com/logantgt/EcpEmuServer/releases/download/v0.3/EcpEmuServer-v0.3-linux_x64.zip
RUN unzip EcpEmuServer-v0.3-linux_x64.zip
RUN mkdir /var/EcpEmuServer
RUN cp -rp ./EcpEmuServer-v0.3-linux_x64/* /var/EcpEmuServer
RUN touch /var/EcpEmuServer/rules.xml
RUN touch /var/EcpEmuServer/devicename


#Clean apt and file directory
RUN apt-get clean
RUN rm packages-microsoft-prod.deb
RUN rm -r ./EcpEmuServer-v0.3-linux_x64


WORKDIR /var/EcpEmuServer
RUN chmod +x EcpEmuServer
CMD ["./EcpEmuServer"]

