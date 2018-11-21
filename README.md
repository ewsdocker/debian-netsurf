## ewsdocker/debian-netsurf:9.5.10  

**A NetSurf Internet browser in a Docker image.**  

**ewsdocker/debian-netsurf** is a **Docker** wrapper around the [NetSurf](http://www.netsurf-browser.org/) browser. Find out more about the browser at [NetSurf.org](http://www.netsurf-browser.org/).
____  

**Pre-built Docker images are available from [ewsdocker/debian-netsurf](https://hub.docker.com/r/ewsdocker/debian-netsurf).**  

____  

#### NOTE  
**ewsdocker/debian-netsurf** is designed to be used on a Linux system configured to support **Docker user namespaces** .  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and information on running **ewsdocker/debian-netsurf** on a system not configured for **Docker user namespaces**.
____  

**Visit the [ewsdocker/debian-netsurf Wiki](https://github.com/ewsdocker/debian-netsurf/wiki/QuickStart) for complete documentation of this docker image.**  
____  

#### Installing ewsdocker/debian-netsurf  

The following scripts will download the selected **ewsdocker/debian-netsurf** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The _default_ values will install all directories and contents in the **docker host** user's home directory (refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf/wiki/QuickStart#mapping)),  

____  

**ewsdocker/debian-netsurf:latest**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -e LMSBUILD_VERSION=latest \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-latest:/root \
               --name=debian-netsurf-latest \
           ewsdocker/debian-netsurf lms-setup  

____  

**ewsdocker/debian-netsurf:9.5.10**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-9.5.10:/root \
               --name=debian-netsurf-9.5.10 \
           ewsdocker/debian-netsurf:9.5.10 lms-setup  

____  
  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf/wiki/QuickStart#mapping) for a discussion of **lms-setup** and what it does.  

____  

#### Running the installed scripts

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

+ the executable scripts have been copied to **~/bin**;  
+ the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
+ the associated **debian-netsurf-"version"** execution script(s) (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names.  

____  

**Execution scripts**  

**ewsdocker/debian-netsurf:latest**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/public_html:/html-source \
               -v ${HOME}/.config/docker/debian-netsurf-latest:/root \
               --name=debian-netsurf-latest \
           ewsdocker/debian-netsurf:latest  

____  

**ewsdocker/debian-netsurf:9.5.10**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/public_html:/html-source \
               -v ${HOME}/.config/docker/debian-netsurf-9.5.10:/root \
               --name=debian-netsurf-9.5.10 \
           ewsdocker/debian-netsurf:9.5.10  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf/wiki/QuickStart#mapping) for a discussion of customizing the executable scripts..  

____  

#### Regarding edge  

For the very brave, if an _edge_ tag is available, these instructions will download, rename and install the _edge_ version.  Good luck.  

____  

**ewsdocker/debian-netsurf:edge**  

**edge** is the development tag for the **9.5.11** release tag.

    docker pull ewsdocker/debian-netsurf:edge
    docker tag ewsdocker/debian-netsurf:edge ewsdocker/debian-netsurf:9.5.11
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-9.5.11:/root \
               --name=debian-netsurf-9.5.11 \
           ewsdocker/debian-netsurf:9.5.11 lms-setup  

optional step:

    docker rmi ewsdocker/debian-netsurf:edge  

To create and run the container, the following should work from the command-line, 

    ~/.local/bin/debian-netsurf-9.5.11  

or,

    docker run -v /etc/localtime:/etc/localtime:ro \
           -e DISPLAY=unix${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
           -v ${HOME}/public_html:/html-source \
           -v ${HOME}/.config/docker/debian-netsurf-9.5.11:/root \
           --name=debian-netsurf-9.5.11 \
       ewsdocker/debian-netsurf:9.5.11    

____  

#### Persistence  
In order to persist the **debian-netsurf** application state, a location on the docker _host_ must be provided to store the necessary information.  This can be accomplished with the following volume option in the run command:

    -v ${HOME}/.config/docker/debian-netsurf-"version":/root  

Since the information is stored in the docker _container_ **/root** directory, this statement maps the user's **~/.config/docker/debian-netsurf-"version"** docker _host_ directory to the **/root** directory in the docker _container_.  

____  
#### Timestamps  
It is important to keep the time and date on docker _host_ files that have been created and/or modified by the docker _containter_ synchronized with the docker _host_'s settings. This can be accomplished as follows:

    -v /etc/localtime:/etc/localtime:ro  

____  
#### Copyright © 2018. EarthWalk Software.  
**Licensed under the GNU General Public License, GPL-3.0-or-later.**  

This file is part of **ewsdocker/debian-netsurf**.  

**ewsdocker/debian-netsurf** is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

**ewsdocker/debian-netsurf** is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License
along with **ewsdocker/debian-netsurf**.  If not, see 
<http://www.gnu.org/licenses/>.  

____  

**NetSurf** is licensed under the GNU General Public License, GPL, Version 2, with portions licensed under various _Annexes_.  Refer to the [NetSurf License](http://www.netsurf-browser.org/about/licence.html) page for further information and restrictions.  
