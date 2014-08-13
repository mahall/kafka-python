#!/bin/bash

#git submodule update --init
#(cd servers/0.8.0/kafka-src && ./sbt update package assembly-package-dependency)
#(cd servers/0.8.1/kafka-src && ./gradlew jar)

SCALA_VERSION=2.8.0
KAFKA_VERSIONS="0.8.0 0.8.1 0.8.1.1"
pushd servers
  mkdir -p dist
  pushd dist
    for kafka in $KAFKA_VERSIONS; do
      echo "-------------------------------------"
      echo "Checking kafka binaries for v${kafka}"
      echo
      wget -N https://archive.apache.org/dist/kafka/$kafka/kafka_${SCALA_VERSION}-${kafka}.tgz || wget -N https://archive.apache.org/dist/kafka/$kafka/kafka_${SCALA_VERSION}-${kafka}.tar.gz
      echo
      if [ ! -d "../$kafka/kafka-bin" ]; then
        echo "Extracting kafka binaries for v${kafka}"
        tar xzvf kafka_${SCALA_VERSION}-${kafka}.t* -C ../$kafka/
        mv ../$kafka/kafka_${SCALA_VERSION}-${kafka} ../$kafka/kafka-bin
      else
        echo "$kafka/kafka-bin directory already exists -- skipping tgz extraction"
      fi
      echo
    done
  popd
popd
