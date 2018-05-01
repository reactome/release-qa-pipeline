#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   --neo4j-host   Neo4j host (default localhost)"
    echo "   --neo4j-user   Neo4j user (default neo4j)"
    echo "   --neo4j-pswd   Neo4j password (default neo4j)"
    echo
    exit 0
}

function fail () {
    echo "$1"
    display_help
    exit 1
}

# Parse the command line options.
while true; do
  case "$1" in
    -h | --help ) display_help; shift ;;
    --neo4j-host ) neo4j_host="$2"; shift 2 ;;
    --neo4j-user ) neo4j_user="$2"; shift 2 ;;
    --neo4j-pswd ) neo4j_pswd="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

opts="-o reports"
[ -n "$neo4j_host" ] && opts="$opts -h $neo4j_host"
[ -n "$neo4j_user" ] && opts="$opts -u $neo4j_user"
[ -n "$neo4j_pswd" ] && opts="$opts -p $neo4j_pswd"

rm -f reports/*
[ -d target ] || mkdir target
echo java -jar BatchImporter.jar $opts