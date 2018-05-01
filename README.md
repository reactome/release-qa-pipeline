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

4. cd to the `curator` subdirectory and follow the instructions in
   `resources/auth.properties.template`.


Run
---
As of May 2018, cd to each subdirectory, display the `*.sh` help, e.g.:

    cd graph
    ./import.sh --help

and run the script.

For `graph`, run `import.sh`, shutdown Neo4j, switch Neo4j to the
`data/databases/graph.db`, restart Neo4j, run `qa.sh` and switch
Neo4j back to the original database.

_Note_: these instructions will change in the near future.
