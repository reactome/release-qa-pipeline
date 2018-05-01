#!/usr/bin/env bash

# Curator.
(cd curator; ant -f create-jar.xml)
cp -f ../graph-importer/target/BatchImporter.jar graph

# Graph.
[ -d graph/lib ] || mkdir graph/lib
cp -fr ../graph-importer/target/lib/* graph/lib
cp -fr ../graph-qa/target/graph-qa-jar-with-dependencies.jar \
   graph/graph-qa-with-dependencies.jar

# Diagram.
cp -f \
   ../../reactome-pwp/diagram-converter/target/diagram-converter-jar-with-dependencies.jar \
   diagram/diagram-converter-with-dependencies.jar

# Slice.
cp -fr ../release-qa/target/release-qa-*jar-with-dependencies.jar \
   slice/slice-qa-with-dependencies.jar
