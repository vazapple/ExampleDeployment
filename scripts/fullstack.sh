#!/bin/bash

canonicalize() {
  local _TARGET _BASEDIR
  _TARGET="$0"
  readlink -f $_TARGET 2>/dev/null || (
    cd $(dirname "$_TARGET")
    _TARGET=$(basename "$_TARGET")

    while [ -L "$_TARGET" ]
    do
      _TARGET=$(readlink "$_TARGET")
      cd $(dirname "$_TARGET")
      _TARGET=$(basename "$_TARGET")
    done
    _BASEDIR=$(pwd -P)
    echo "$_BASEDIR/$_TARGET"
  )
}

BASENAME=${0##*/}
COMPONENT=${BASENAME%.sh}
BASEDIR="$(dirname "$(dirname "$(canonicalize "$0")")")"
SCRIPTDIR=${BASEDIR}/scripts
cd "${BASEDIR}" || exit 1

. ${SCRIPTDIR}/project-utils.sh
. ${SCRIPTDIR}/java-utils.sh
. ${SCRIPTDIR}/componentserver-init-utils.sh

# Read default configs
load_default_config

# Component specific default configs
CONFIG=classpath:fullstack/fullstack-dev.properties
LOGBACK_CONFIG=fullstack/fullstack-logback.xml
LOGFILE=logs/fullstack-console.log

# User customizations
load_component_config ${PROJECT} ${COMPONENT}

CLASSPATH=$(build_classpath)
CLASSPATH=config:${CLASSPATH}

RETVAL=0
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  debug)
    debug
    ;;
  showconfig)
    showconfig
    ;;
  restart|reload)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|showconfig|debug|reload}"
esac

exit ${RETVAL}
