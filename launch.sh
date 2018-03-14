#!/bin/bash

if [ ! -f web-env-variables.env ]; then
    echo "You must configure your own AMAZON ACCESS KEYS in [web-env-variables.env]!"
    exit 1
fi

docker-compose build

docker-compose up -d

echo "Sleep 30 seconds..."
sleep 15
echo "Sleep 15 seconds..."
sleep 5
echo "Sleep 10 seconds..."
sleep 5
echo "Sleep 5 seconds..."
sleep 1
echo "Sleep 4 seconds..."
sleep 1
echo "Sleep 3 seconds..."
sleep 1
echo "Sleep 2 seconds..."
sleep 1
echo "Sleep 1 seconds..."
sleep 1

echo "If [create database] fails, just run [./launch.sh] again. Likely didn't sleep long enough."

docker-compose run --rm -w /myapp web rake db:create
docker-compose run --rm -w /myapp web rails db:migrate

docker-compose up -d

cat <<EOF
Sample Amazon ASINs (first one is the baby product):

B002QYW8LW

B01N0X3NL5
B018LJZUGK
B079S8G3HC
B00JM5GW10
B07BBMV8MY
B01N9QVIRV
B01N1037CV
B010TQY7A8
B01MRG7T0D
B00000IGGJ
B00005JNBQ
B00006KGC0
B00006KGC2
B0001LJBTE
B00020HALU
B000001DQI
B000003BGP
B00000JWOJ
B000JKXBKC
B000MZ5DD2
B0777GLYJ5
B06XCM9LJ4
B01CB6YQ8M
B00WQEPSY6
B00A85EMVK
EOF