#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   -c, --config FILE   command options file"
    echo "   --neo4j-host HOST   Neo4j host (default localhost)"
    echo "   --neo4j-user USER   Neo4j user (default neo4j)"
    echo "   --neo4j-pswd PSWD   Neo4j password (default neo4j)"
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
    -c | --config ) config="$2"; shift 2 ;;
    --neo4j-host ) neo4j_host="$2"; shift 2 ;;
    --neo4j-user ) neo4j_user="$2"; shift 2 ;;
    --neo4j-pswd ) neo4j_pswd="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

if [ -n "$config" ]; then
    [ -r "$config" ] || fail "Can't read configuration file $config"
    eval `cat $config | sed -E 's/^([^=]+)-/\1_/' | tr -d ' '`
fi

opts="-o reports"
[ -n "$neo4j_host" ] && opts="$opts -h $neo4j_host"
[ -n "$neo4j_user" ] && opts="$opts -u $neo4j_user"
[ -n "$neo4j_pswd" ] && opts="$opts -p '$neo4j_pswd'"

dir=`dirname $0`
rm -f $dir/reports/*
[ -d $dir/target ] || mkdir $dir/target
(cd $dir; java -Xmx8G -jar graph-qa-with-dependencies.jar $opts)
