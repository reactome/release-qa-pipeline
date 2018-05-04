#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   -c, --config FILE   command options file"
    echo "   --mysql-host HOST   MySQL hostname (default localhost)"
    echo "   --mysql-user USER   MySQL userid (default reactome)"
    echo "   --mysql-pswd PSWD   MySQL password"
    echo "   --mysql-db DB       MySQL database"
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
    --mysql-host ) mysql_host="$2"; shift 2 ;;
    --mysql-user ) mysql_user="$2"; shift 2 ;;
    --mysql-pswd ) mysql_pswd="$2"; shift 2 ;;
    --mysql-db ) mysql_db="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

if [ -n "$config" ]; then
    [ -r "$config" ] || fail "Can't read configuration file $config"
    eval `cat $config | tr '-' '_' | tr -d ' '`
fi

opts="-n data/databases/graph.db"
[ -n "$mysql_host" ] && opts="$opts -h $mysql_host"
[ -n "$mysql_user" ] && opts="$opts -u $mysql_user"
[ -n "$mysql_pswd" ] && opts="$opts -p $mysql_pswd"
[ -n "$mysql_db" ] && opts="$opts -d $mysql_db"

rm -f reports/*
[ -d target ] || mkdir target
java -Xmx8G -jar graph-importer-with-dependencies.jar $opts
