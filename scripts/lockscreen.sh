#!/bin/bash

lock_screen() {
  betterlockscreen --lock
}

case $1 in 
  "lock")
    betterlockscreen --lock
  ;;
esac
