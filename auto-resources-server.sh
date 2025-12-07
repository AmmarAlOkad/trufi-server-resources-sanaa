#!/bin/bash

export envfile="./config/Yemen-AmanatAlAsimah.env"

cd map-pbf-builder && docker-compose --env-file ../$envfile -f docker-compose.yml up && cd ..

sudo chown -R $USER:$USER ./data
cp ./data/Yemen-AmanatAlAsimah/otp/data/Yemen-AmanatAlAsimah.osm.pbf \
./gtfs-builder/cities/Yemen-AmanatAlAsimah/

cd ./gtfs-builder && npm install && cd ..
node ./gtfs-builder/cities/Yemen-AmanatAlAsimah

cp ./gtfs-builder/cities/Yemen-AmanatAlAsimah/Yemen-AmanatAlAsimah.osm.pbf \
./data/Yemen-AmanatAlAsimah/otp/data/

cd gtfs-builder/cities/Yemen-AmanatAlAsimah/out/gtfs
zip -r graphs.zip .
cp -f graphs.zip ../../../../../data/Yemen-AmanatAlAsimah/otp/data/
mv -f graphs.zip ../
cd ../../../../..

cd graph-builder && sudo docker-compose --env-file ../$envfile up && cd ..

# cp -f ./data/Yemen-AmanatAlAsimah/otp/data/Graph.obj \
# ../trufi-server-modules/otp/data

# scp -i ~/.ssh/trufi-ssh.pem ./data/Yemen-AmanatAlAsimah/otp/data/Graph.obj \
# ec2-user@3.28.123.11:/home/ec2-user/otp-java-dirctly/graphs

cp ./data/Yemen-AmanatAlAsimah/otp/data/Graph.obj ../otp-java-dirctly/graphs