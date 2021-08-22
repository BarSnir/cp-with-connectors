#!/bin/sh



#### /etc/confluent/docker/run & DONT FORGET THIS ONE ####


connector_list=(
  "mysql-source-connector-replica"
  "mysql-sink-connector-v9"
)

# Wait for Kafka Connect listener
echo "Waiting for Kafka Connect to start listening on localhost ⏳"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
  echo " Kafka Connect listener HTTP state:  $curl_status  (waiting for 200)"
  if [ $curl_status == 200 ] ; then
    break
  fi
  sleep 5
done





function get_existing_connectors {
  existing_conenctors=$(curl -s -X GET -H  "Content-Type:application/json" http://localhost:8083/connectors)
  echo $existing_conenctors
}

existing_conenctors=get_existing_connectors()
# existing_conenctors=$(jq -r .[] <<< "$existing_connectors")

for t in ${existing_conenctors}; do
  echo $t
done





# echo -e "\n--\n+> Creating Data Generator source"
# curl -s -X PUT -H  "Content-Type:application/json" http://localhost:8083/connectors/source-datagen-01/config \
#     -d '{
#     "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
#     "key.converter": "org.apache.kafka.connect.storage.StringConverter",
#     "kafka.topic": "ratings",
#     "max.interval":750,
#     "quickstart": "ratings",
#     "tasks.max": 1
# }'
# sleep infinity