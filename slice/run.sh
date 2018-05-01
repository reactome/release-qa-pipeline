#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   --mysql-host   MySQL hostname (default localhost)"
    echo "   --mysql-user   MySQL userid (default reactome)"
    echo "   --mysql-pswd   MySQL password"
    echo "   --mysql-db     MySQL database"
    echo
    exit 0
}

function fail () {
    echo "$1"
    display_help
    exit 1
}

# Set the defaults, which are not set in the jar file.
mysql_host="localhost"
mysql_user="reactome"

# Parse the command line options.
while true; do
  case "$1" in
    -h | --help ) display_help; shift ;;
    --mysql-host ) mysql_host="$2"; shift 2 ;;
    --mysql-user ) mysql_user="$2"; shift 2 ;;
    --mysql-pswd ) mysql_pswd="$2"; shift 2 ;;
    --mysql-db ) mysql_db="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

[ -z "$mysql_db" ] && fail "Missing required option: --mysql_db"
[ -z "$mysql_pswd" ] && fail "Missing required option: --mysql_pswd"

mkdir -p resources
cat <<HERE > resources/auth.properties
dbHost=$mysql_host
dbUser=$mysql_user
dbPwd=$mysql_pswd
dbName=$mysql_db
HERE

#rm -f reports/*
java -Xmx8G -jar slice-qa-with-dependencies.jar