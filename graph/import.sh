#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   --mysql-host   MySQL hostname"
    echo "   --mysql-user   MySQL userid"
    echo "   --mysql-pswd   MySQL password"
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
    --mysql-host ) mysql_host="$2"; shift 2 ;;
    --mysql-user ) mysql_user="$2"; shift 2 ;;
    --mysql-pswd ) mysql_pswd="$2"; shift 2 ;;
    --mysql-db ) mysql_db="$2"; shift 2 ;;
    --neo4j-user ) neo4j_user="$2"; shift 2 ;;
    --neo4j-pswd ) neo4j_pswd="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

opts="-n data/databases/graph.db"
[ -n "$mysql_host" ] && opts="$opts -h $mysql_host"
[ -n "$mysql_user" ] && opts="$opts -u $mysql_user"
[ -n "$mysql_pswd" ] && opts="$opts -p $mysql_pswd"
[ -n "$mysql_db" ] && opts="$opts -d $mysql_db"

rm -f reports/*
[ -d target ] || mkdir target
echo java -jar graph-qa-with-dependencies.jar $opts
