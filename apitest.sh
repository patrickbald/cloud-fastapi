#!/bin/bash

echo "create runners"
echo $(time (for i in {1..100}; do curl -X POST "http://disc01.crc.nd.edu:9001/runners/" -s -o /dev/null -H  "accept: application/json" -H  "Content-Type: application/json" -d "{\"name\":\"Patrick bald\",\"hometown\":\"Woodstock, Vermont\",\"miles\":200}"; done))

echo "get all runners:"
echo $(time (for i in {1..100}; do curl -X GET "http://disc01.crc.nd.edu:9001/runners/" -s -o /dev/null -H  "accept: application/json"; done))

echo "delete all runners"
echo $(time (for i in {1..100}; do curl -X DELETE "http://disc01.crc.nd.edu:9001/runners/" -s -o /dev/null -H  "accept: application/json"; done))

# Create new runner for further tests
$(curl -X POST "http://disc01.crc.nd.edu:9001/runners/" -H  "accept: application/json" -s -o /dev/null -H  "Content-Type: application/json" -d "{\"name\":\"Patrick bald\",\"hometown\":\"Woodstock, Vermont\",\"miles\":200}")

echo "get specific runner"
echo $(time (for i in {1..100}; do curl -X GET "http://disc01.crc.nd.edu:9001/runners/0" -s -o /dev/null -H  "accept: application/json"; done))

echo "modify existing runner"
echo $(time (for i in {1..100}; do curl -X PUT "http://disc01.crc.nd.edu:9001/runners/0" -s -o /dev/null -H  "accept: application/json" -H  "Content-Type: application/json" -d "{\"name\":\"Charles\",\"hometown\":\"virginia\",\"miles\":2}"; done))

$(curl -X DELETE "http://disc01.crc.nd.edu:9001/runners/0" -s -o /dev/null -H  "accept: application/json")

# making more runners
for i in {1..100}
do 
curl -X POST "http://disc01.crc.nd.edu:9001/runners/" -s -o /dev/null -H  "accept: application/json" -H  "Content-Type: application/json" -d "{\"name\":\"Patrick bald\",\"hometown\":\"Woodstock, Vermont\",\"miles\":200}"
done

echo "patching runners"
echo $(time (for i in {1..100}; do ((id=i-1)); curl -X PATCH "http://disc01.crc.nd.edu:9002/runners/$id?miles=50" -s -o /dev/null -H  "accept: application/json"; done))

echo "delete specific runner"
echo $(time (for i in {1..100}; do ((id=i-1)); curl -X DELETE "http://disc01.crc.nd.edu:9001/runners/$id" -s -o /dev/null -H  "accept: application/json"; done))
