#!/usr/bin/env bash
#!/usr/bin/env bash

function display_help () {
    echo "Usage: $0 [option...]"
    echo
    echo "   --mysql-host   MySQL hostname (default localhost)"
    echo "   --mysql-user   MySQL userid (default localhost)"
    echo "   --mysql-pswd   MySQL password"
    echo "   --mysql-db     MySQL database (default reactome)"
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
    --mysql-host ) mysql_host="$2"; shift 2 ;;
    --mysql-user ) mysql_user="$2"; shift 2 ;;
    --mysql-pswd ) mysql_pswd="$2"; shift 2 ;;
    --mysql-db ) mysql_db="$2"; shift 2 ;;
    --neo4j-host ) neo4j_host="$2"; shift 2 ;;
    --neo4j-user ) neo4j_user="$2"; shift 2 ;;
    --neo4j-pswd ) neo4j_pswd="$2"; shift 2 ;;
    -- ) shift; break ;;
    -* ) fail "Unsupported option: $1" ;;
    * ) break ;;
  esac
done

opts="-o target"
[ -n "$mysql_host" ] && opts="$opts -e $mysql_host"
[ -n "$mysql_user" ] && opts="$opts -g $mysql_user"
[ -n "$mysql_pswd" ] && opts="$opts -d $mysql_pswd"
[ -n "$mysql_db" ] && opts="$opts -f $mysql_db"
[ -n "$neo4j_host" ] && opts="$opts -a $neo4j_host"
[ -n "$neo4j_user" ] && opts="$opts -c $neo4j_user"
[ -n "$neo4j_pswd" ] && opts="$opts -d $neo4j_pswd"

rm -f reports/*
mkdir -p target
java -jar diagram-converter-jar-with-dependencies.jar $opts >/dev/null
