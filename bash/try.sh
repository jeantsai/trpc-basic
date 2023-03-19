#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/shelllib/

printf "PROG: %s\n" "${0##*/}"
printf "DIR: %s\n" "${0%/*}"

echo "$@"
for arg in "$@"
do
  echo "$arg"
done
echo "================="
echo "$*"
for arg in $*
do
  echo "$arg"
done

printf "\$0: %s\n" "$0"
printf "dirname \$0: %s\n" "$(dirname "$0")"
printf "script dir: %s\n" "$(cd "$(dirname "$0")" && pwd)"
