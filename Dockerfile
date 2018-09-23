# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for ewsdocker/debian-pull-tumblr in a Debian docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.0
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-pull-tumblr
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-pull-tumblr.
#
#   ewsdocker/debian-pull-tumblr is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-pull-tumblr is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-pull-tumblr.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-base:9.5.2

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================

ENV LMSBUILD_VERSION="9.5.0" 
ENV LMSBUILD_NAME=debian-pull-tumblr 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="debian-base:9.5.2"
ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, tumblr v. 0.1.0"

# =========================================================================

ENV LMSOPT_QUIET=0
ENV TUMBLR_CAT=""
ENV TUMBLR_LIMIT="200k"

ENV TUMBLR_LISTS="tumblr-lists"
ENV TUMBLR_CATALOGS="tumblr-catalogs"
ENV TUMBLR_SITES="tumblr-sites"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
               bash-completion \
 && chmod -R +x /usr/local/bin/* \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt \ 
 && ln -s /usr/bin/tumblr.sh /usr/bin/lms-tumblr \
 && apt-get clean 

# =========================================================================

COPY scripts/. /

RUN chmod 775 /usr/bin/tumblr \
 && chmod 775 /usr/bin/tumblr.sh \
 && chmod 600 /usr/local/share/applications/${LMSBUILD_NAME}-${LMSBUILD_VERSION}.desktop  

# =========================================================================

VOLUME /lists
VOLUME /data

WORKDIR /data

# =========================================================================

ENTRYPOINT ["/my_init","--quiet"]
CMD ["lms-tumblr"]
