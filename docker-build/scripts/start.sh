#!/bin/bash

OPENGEMINI_MATE="${OPENGEMINI_HOME}/mate"
OPENGEMINI_SCRIPTS="${OPENGEMINI_MATE}/scripts"

START_STANDALONE_SCRIPT="${OPENGEMINI_SCRIPTS}/start-opengemini-stand-alone.sh"

case ${DEPLOY_TYPE} in
"stand-alone")
  echo "start stand-alone opengemini."
  bash -xv ${START_STANDALONE_SCRIPT}
  ;;
esac
tail -f /dev/null
