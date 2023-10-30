# Define the path to your installations
ZOOKEEPER_HOME="/BDMG/Zookeeper/apache-zookeeper-3.7.1-bin"
KAFKA_ZOOKEEPER="/BDMG/Kafka/kafka-3.5.1-src"
KAFKA_HOME="/BDMG/Kafka/kafka-3.5.1-src"
STORM_NIMBUS="/BDMG/Storm/Nimbus/apache-storm-2.5.0"
STORM_SUPERVISOR="/BDMG/Storm/Supervisor/apache-storm-2.5.0"
STORM_UI="/BDMG/Storm/Nimbus/apache-storm-2.5.0"

# Start ZooKeeper
echo "Starting ZooKeeper..."
${ZOOKEEPER_HOME}/bin/zkServer.sh start &
sleep 5

echo "Starting Zookeeper storm..."
${KAFKA_ZOOKEEPER}/bin/zookeeper-server-start.sh ${KAFKA_ZOOKEEPER}/config/zookeeper.properties &
sleep 5

# Start Kafka
echo "Starting Kafka..."
${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties &

sleep 5
# Start Storm Nimbus
echo "Starting Storm Nimbus..."
${STORM_NIMBUS}/bin/storm nimbus &


sleep 5
# Start Storm Supervisor
echo "Starting Storm Supervisor..."
${STORM_SUPERVISOR}/bin/storm supervisor &

sleep 5
echo "starting ui"
${STORM_UI}/bin/storm ui &

sleep 5
# Start the UIs (if available)
# Replace 'ui-command' with the actual command to start the UIs

# Sleep to keep the script running
echo "Services started. Press Ctrl+C to stop"
