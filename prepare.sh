#!/bin/bash
dirs=($( ls -1p | grep / | sed 's/^\(.*\)/\1/'))
printf '%s\n' "${dirs[@]}" | jq -R . | jq -cs . | tr -d '/'