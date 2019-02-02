#!/bin/bash

die() {
  echo "$@" 1>&2
  exit 1
}

warn() {
  echo "$@" 1>&2
}
