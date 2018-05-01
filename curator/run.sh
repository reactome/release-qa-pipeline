#!/usr/bin/env bash
rm -f QA_Output/*
java -Xmx8G -jar curator-with-dependencies.jar org.gk.qualityCheck.CommandLineRunner
