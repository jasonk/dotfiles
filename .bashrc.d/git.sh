#!/bin/bash
if have_cmd git; then
  pathedit --append "$(git --exec-path)"
  if have_cmd hub; then alias git=hub; fi
fi
