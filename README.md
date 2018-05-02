Reactome Release QA Pipeline
============================
Consolidates all Reactome release QA checks.

Build
-----
1. Pull the following GitHub repositories:

   - [CuratorTool](https://github.com/reactome/CuratorTool.git)
   - [graph-importer](https://github.com/reactome/graph-importer.git)
   - [graph-qa](https://github.com/reactome/graph-qa.git)
   - [diagram-converter](https://github.com/reactome-pwp/diagram-converter.git)
   - [release-qa](https://github.com/reactome/release-qa.git)

   Place the `reactome` and `reactome-pwp` repository directories
   under a common parent directory.

   _Note_: As of May 2018, these repository locations will change in
   the near future.

2. For Maven-based projects, cd to that project and build the package:

       mvn clean package

3. cd to `release-qa-pipeline` and run `build.sh`.


Deployment
----------

1. Copy `dist/release-qa-pipeline.tar.gz` to the release
   staging server and decompress it at
   `/usr/local/reactomes/Reactome/release-qa`.

2. Relax permissions:

   cd /usr/local/reactomes/Reactome/release-qa
   find . -type f | grep -v jar | xargs chmod a+w
   find . -type d | xargs chmod a+w

Usage
-----
cd to each `/usr/local/reactomes/Reactome/release-qa`
subdirectory and display the `*.sh` help to discover the
options,
e.g.:

    cd graph
    ./import.sh --help

The procedure below assumes that you will replace the server
graph database. You will need `sudo` permission to stop and
start Neo4j.

Run the scripts as follows:

1. cd to `/usr/local/reactomes/Reactome/release-qa`.

11. cd to the `curator` subdirectory.

12. Adjust the resources `.txt` files if necessary.

13. Execute `run.sh [options]`.

14. Examine the QA results in the `QA_Output` subdirectory.

21. cd to the `../slice` subdirectory.

22. Execute `run.sh [options]`.

23. Examine the QA results in the `output` subdirectory.

31. cd to the `../graph` subdirectory.

32. Execute `import.sh [options]`.

33. Reset the Neo4j database:

        sudo systemctl stop neo4j
        (cd /var/lib/neo4j/data/databases/;
         mv -f graph.db graph.db.old;
         cp -r /usr/local/reactomes/Reactome/release-qa/databases/graph.db .)
        sudo systemctl start neo4j

34. Execute `qa.sh [options]`.

35. Examine the QA results in the `output` subdirectory.

41. cd to the `../diagram` subdirectory.

42. Execute `run.sh [options]`.

43. Examine the QA results in the `output` subdirectory.
