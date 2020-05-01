#!/bin/sh
JAVA_HOME="/opt/jdk-11.0.2/"
sudo update-alternatives --install /usr/bin/java java ${JAVA_HOME}"bin/java" 50
sudo update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}"bin/javac" 50
sudo update-alternatives --install /usr/bin/javap javap ${JAVA_HOME}"bin/javap" 50
sudo update-alternatives --install /usr/bin/javadoc javadoc ${JAVA_HOME}"bin/javadoc" 50