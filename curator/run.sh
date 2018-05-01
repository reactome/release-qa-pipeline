#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0"
    exit 0
}

# Parse the command line options.
while true; do
  case "$1" in
    -* ) display_help; shift ;;
    * ) break ;;
  esac
done

rm -f QA_Output/*
java -Xmx8G -jar curator-with-dependencies.jar org.gk.qualityCheck.CommandLineRunner
