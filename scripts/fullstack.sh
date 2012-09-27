#!/bin/bash
BASENAME=${0##*/}                                                                                                               
COMPONENT=${BASENAME%.sh}                                                                                                       
BASEDIR="$(dirname $(dirname $(readlink -f $0)))"                                                                               
SCRIPTDIR=${BASEDIR}/scripts
PROJECT=exampleserver

cd "${BASEDIR}" || exit 1

. ${SCRIPTDIR}/componentserver-init-utils.sh

# Read default configs
load_default_config

# Component specific default configs
CONFIG=classpath:fullstack/fullstack-dev.properties
LOGBACK_CONFIG=fullstack/fullstack-logback.xml

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
  restart|reload)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|reload}"
esac

exit ${RETVAL}
