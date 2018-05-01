#!/usr/bin/env bash

# Curator.
(cd curator; ant -f create-jar.xml)

# Graph.
cp -f ../graph-importer/target/BatchImporter.jar graph
[ -d graph/lib ] || mkdir graph/lib
cp -fr ../graph-importer/target/lib/* graph/lib
cp -f ../graph-qa/target/graph-qa-jar-with-dependencies.jar \
   graph/graph-qa-with-dependencies.jar

# Diagram.
cp -f \
   ../../reactome-pwp/diagram-converter/target/diagram-converter-jar-with-dependencies.jar \
   diagram/diagram-converter-with-dependencies.jar

# Slice.
cp -fr ../release-qa/target/release-qa-*jar-with-dependencies.jar \
   slice/slice-qa-with-dependencies.jar

# Assemble the distro.
mkdir -p dist
tar czf dist/release-qa-pipeline.tar.gz \
    README.md */*.sh */*.jar */lib \
    curator/QA_SkipList curator/resources/*.txt curator/resources/*.properties
