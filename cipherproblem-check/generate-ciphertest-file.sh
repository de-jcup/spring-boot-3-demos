#!/bin/bash
# SPDX-License-Identifier: MIT
# original was `ciphertest.sh` from https://github.com/mercedes-benz/sechub (MIT License)

function usage(){
    echo "usage: ciphertest <server:port> <profile>"
    echo "       - second parameter is for taget type, currently only 'server' (sechub-server) and"
    echo "         'pds' are supported"
    
}

# check if open ssl is available at all
# if not the function will exit with exit code 3
function ensureOpenSSLInstalled(){
     checkCommand="which openssl";
     
     foundOpenSSLPath=$($checkCommand)
     
     if [[ "$foundOpenSSLPath" = "" ]]; then
       echo "Did not found a open SSL installation! So cannot check ciphers!"
       exit 3
    fi
}

# check and print openssl version
ensureOpenSSLInstalled
echo "Using installed $(openssl version)."


if [ -z "$1" ] ; then
    echo "server is missing as first parameter!"
    usage
    exit 1
fi

if [ -z "$2" ] ; then
    echo "profile is missing as second parameter (cipher1|cipher2)"
    usage
    exit 1
fi

PSEUDO_PWD=123456
DEV_CERT_PATH="$(pwd)/src/main/resources/"
DEV_CERT_FILE="$DEV_CERT_PATH/test-certificate.p12"

OUTPUT_FOLDER="./build/test-results/ciphertest"
OUTPUT_FILE="$OUTPUT_FOLDER/ciphertest-output-$2.json"
DEV_CERT_PEM="$OUTPUT_FOLDER/test-certificate.pem"

rm -f $OUTPUT_FILE
mkdir -p $OUTPUT_FOLDER

echo DEV_CERT_FILE=$DEV_CERT_FILE
echo DEV_CERT_PEM=$DEV_CERT_PEM

SERVER=$1

ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')

# convert existing pkcs12 file to a PEM file, so we can use it later to connect to localhost with self signed certificates....
openssl pkcs12 -in $DEV_CERT_FILE -out $DEV_CERT_PEM -clcerts -nokeys -passin pass:$PSEUDO_PWD

echo Obtaining cipher list by openssl

echo "{" > $OUTPUT_FILE
echo "  \"cipherChecks\" : [" >> $OUTPUT_FILE

count=0 

for cipher in ${ciphers[@]}

do
    if [[ "$count" != "0" ]] ; then
        echo "," >> $OUTPUT_FILE
    fi
    count=$count+1
    
    echo -n "   { \"cipher\" : \"$cipher\", \"verified\" :\"" >> $OUTPUT_FILE
    # wyh -tls1_2? only when using tls_1_2 (or below) the given cipher is really used
    #              otherwise client will accept tls1_3 fallback which are then verifified as true
    #              and the test is not possible
    #
    # why -CAfile? We use our former generated PEM file for the self signed certificate
    #              otherwise we have always unknown results because openssl does not
    #              trust the self-signed certificates
    result=$(echo -n | openssl s_client -CAfile $DEV_CERT_PEM -tls1_2 -cipher "$cipher" -connect $SERVER 2>&1)
    
    if [[ "$result" =~ ":error:" ]] ; then

        error=$(echo -n $result | cut -d':' -f6)

        echo -n "false\",\"error\" : \"$error\"" >> $OUTPUT_FILE

    else

        if echo $result | grep -q "Verify return code: 0 (ok)"; then

            echo -n "true\"" >> $OUTPUT_FILE

        else
            echo -n "undefined\", \"error\" : \"$result\"" >> $OUTPUT_FILE
         fi

    fi
    echo -n "}" >> $OUTPUT_FILE

done
echo "] }" >> $OUTPUT_FILE

echo "written to $OUTPUT_FILE"
