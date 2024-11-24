#!/bin/bash

fw_depends java maven

mvn clean compile assembly:single
cd target
java -jar bayou_BW-0.1-jar-with-dependencies.jar &
