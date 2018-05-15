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

# Set the defaults, which are not set in the jar file.
mysql_host="localhost"
mysql_user="reactome"

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
    eval `cat $config | sed -E 's/^([^=]+)-/\1_/' | tr -d ' ' | sed -E "s/=(.*)/='\1'/"`
fi

[ -z "$mysql_db" ] && fail "Missing required option: --mysql_db"
[ -z "$mysql_pswd" ] && fail "Missing required option: --mysql_pswd"

dir=`dirname $0`

mkdir -p $dir/resources
cat <<HERE > $dir/resources/auth.properties
dbHost=$mysql_host
dbUser=$mysql_user
dbPwd=$mysql_pswd
dbName=$mysql_db
HERE

rm -f $dir/QA_Output/*
(cd $dir; java -Xmx8G -jar curator-with-dependencies.jar org.gk.qualityCheck.CommandLineRunner)
