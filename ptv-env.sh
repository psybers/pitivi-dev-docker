#!/bin/bash

cd /pitivi-dev/pitivi

grep "unalias" bin/pitivi-env >/dev/null
[[ $? -eq 1 ]] && echo "unalias ptvenv" >> bin/pitivi-env && echo "git restore bin/pitivi-env" >> bin/pitivi-env

#source bin/pitivi-env
exec "$@"
