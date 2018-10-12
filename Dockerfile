# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for ewsdocker/debian-netsurf in a Debian docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.3
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-netsurf
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-netsurf.
#
#   ewsdocker/debian-netsurf is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-netsurf is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-netsurf.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-base-gui:9.5.5-gtk2

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================

ENV NETSURF_RELEASE="3.8"
ENV NETSURF_VERS="deb-gtk" 
ENV NETSURF_PKG="netsurf-${NETSURF_RELEASE}-${NETSURF_VERS}-x86_64.tar.gz" 

ENV NETSURF_HOST=http://alpine-nginx-pkgcache 
#ENV NETSURF_HOST=""

ENV NETSURF_URL="${NETSURF_HOST}/${NETSURF_PKG}"
 
# =========================================================================

ENV LMSBUILD_VERSION="9.5.3" 
ENV LMSBUILD_NAME=debian-netsurf 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="debian-base-gui:9.5.5-gtk2"
ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, NetSurf ${NETSURF_RELEASE}"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && wget ${NETSURF_URL} \
 && tar -xvf ${NETSURF_PKG} \
 && cp usr/bin/nsgtk /usr/bin/netsurf \
 && mkdir /usr/share/netsurf \
 && mv usr/share/netsurf/* /usr/share/netsurf \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt \ 
 && apt-get clean 

# =========================================================================

COPY scripts/. /

RUN chmod -R +x /usr/local/bin/* \
 && chmod +x /usr/bin/netsurf \
 && chmod 644 /usr/local/share/applications/${LMSBUILD_NAME}-${LMSBUILD_VERSION}.desktop \
 && chmod 644 /usr/local/share/applications/${LMSBUILD_NAME}.desktop

# =========================================================================

ENTRYPOINT ["/my_init","--quiet"]
CMD ["/usr/bin/netsurf"]
