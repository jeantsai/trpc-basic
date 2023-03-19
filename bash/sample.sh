#!/usr/bin/env bash

prog="${0##*/}"
rel_dir="${0%/*}"
abs_dir="$(cd "$(dirname "$0")" && pwd)"

usage() {
  cat 1>&2 <<USAGE
Sample template bash script with arguments supports

Usage:
  Run the script from inside a bash shell with the following command line sygnature

  $prog [OPTIONS] <ARGUMENT 1> [<ARGUEMNT 2> ...]

  OPTIONS:
    -t or --topic <topic>  topic of discussion
    -v or --verbose        be verbose
    -h or --help           show help

  ARGUMENTS
    ARG 1           sub-command
    ARG 2           args or sub-command

USAGE
  exit
}

args=
topic=
verbose=false
SUB_CMD=

while (( "$#" )); do
  case "$1" in
    -t|--topic)
      if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
        topic=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -v|--verbose)
      verbose=true
      shift
      ;;
    -h|--help)
      usage
      ;;
    -*) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      args="$args $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$args"

if [ "$#" -ne 1 ]
  then
    usage
fi

#### Start working with the arguments and options

printf "Got options:\n"
printf "    -t / --topic     %s\n" "${topic}"
printf "    -v / --verbose   %s\n" ${verbose}

printf "Got arguments:\n"
idx=$((0))
for item in "$@"
do
idx=$((idx + 1))
printf "    %s) %s\n" $idx "$item"
done
