#!/bin/bash

echo "###################"
echo "      START"
echo "###################"

TEST_RESULT_FOLDER="./build/test-results/ciphertest"

function testApplication() {
    port=$1
    profile=$2
    server_log_file="$TEST_RESULT_FOLDER/$profile-server.log"
    echo "# TEST application ($profile)"
    
    echo "> Stop application with at port $port (if existing)"
    curl --insecure -X POST https://localhost:$port/actuator/shutdown
    
    echo "> Start application with profile: $profile"
    echo "  server log file at $server_log_file"
    java -Dspring.profiles.active=$profile -Dserver.port=$port -jar ./build/libs/demo-0.0.1-SNAPSHOT.jar > $server_log_file &
    
    echo "> Check $profile"
    ./generate-ciphertest-file.sh localhost:$port $profile

    echo "> Stop application with profile $profile"
    curl --insecure -X POST https://localhost:$port/actuator/shutdown
    echo ""
    echo ""
}
echo ""
echo "# Cleanup test results"
rm -rf $TEST_RESULT_FOLDER
mkdir -p $TEST_RESULT_FOLDER
echo "> content of $TEST_RESULT_FOLDER"
ls -al $TEST_RESULT_FOLDER 

echo ""
echo "# Build application"
./gradlew bootJar

testApplication 8444 cipher1
testApplication 8445 cipher2

