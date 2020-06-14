#!/bin/bash

SERVICE_NAMES=(
    "config-server"
    "cart-service"
    "checkout-service"
    "product-service"
)

PORTS=(
    "8191"
    "8081"
    "8080"
    "8082"
)

#Docker network
NETWORK_NAME=spring-cloud-private-network

echo "Create network if does not exists"
docker network inspect ${NETWORK_NAME} >/dev/null 2>&1 || \
    docker network create --driver bridge ${NETWORK_NAME}

echo "Build jar files out of springboot project"
for SERVICE_NAME in "${SERVICE_NAMES[@]}"; do
    echo "Creating jar file for ${SERVICE_NAME}"
    mvn clean install -f ${SERVICE_NAME}/pom.xml -DskipTests
done

echo "Build docker images"
for SERVICE_NAME in "${SERVICE_NAMES[@]}"; do
    echo "Building docker image for ${SERVICE_NAME}"
    docker image build -t ${SERVICE_NAME} ${SERVICE_NAME}
done

echo "Stop running containers"
for SERVICE_NAME in "${SERVICE_NAMES[@]}"; do
    docker container stop ${SERVICE_NAME} || true
done

echo "Remove stopped containers"
docker container prune


# Accepting spring cloud configurations from user
read -p 'Enter git repository url : ' git_url
read -p 'search path : ' search_path
read -p 'Enter git username : ' username
read -sp 'Enter git password : ' password

#Setting up environement arguments for config server
cloudArgs=(
    "-e spring.cloud.config.server.git.uri=${git_url}"
    "-e spring.cloud.config.server.git.search-paths=${search_path}"
    "-e spring.cloud.config.server.git.username=${username}"
    "-e spring.cloud.config.server.git.password=${password}"
    "-e spring.cloud.config.server.git.skip-ssl-validation=true"
)

echo "Running config server"
docker container run --name=${SERVICE_NAMES[0]} --network=${NETWORK_NAME} -p ${PORTS[0]}:${PORTS[0]} ${cloudArgs[@]} -d ${SERVICE_NAMES[0]}

HTTPS_URL="http://localhost:8191/checkout-service/dev"
CURL_CMD="curl -w httpcode=%{http_code}"

# -m, --max-time <seconds> FOR curl operation
CURL_MAX_CONNECTION_TIMEOUT="-m 100"
CURL_RETURN_CODE=0


attempt_counter=0

until [[ $CURL_RETURN_CODE -eq 200 || $attempt_counter -eq 100 ]]; 
do
   echo "Config server not started yet...";
   CURL_OUTPUT=`${CURL_CMD} ${CURL_MAX_CONNECTION_TIMEOUT} ${HTTPS_URL} 2> /dev/null`
   CURL_RETURN_CODE=$(echo "${CURL_OUTPUT}" | sed -e 's/.*\httpcode=//')
   sleep 1
   ((attempt_counter++))
done


echo `/usr/bin/docker inspect -f {{.State.Running}} config-server`;

# for SERVICE_NAME in "${SERVICE_NAMES[@]:1}"; do
#     echo "Building docker image for ${SERVICE_NAME}"
#     docker container stop ${SERVICE_NAME}
# done

for i in "${!SERVICE_NAMES[@]}"; do
    if [[ $i -eq 0 ]]; then
        continue
    fi
  docker container run --name=${SERVICE_NAMES[i]} --network=${NETWORK_NAME} -p ${PORTS[i]}:${PORTS[i]} -d ${SERVICE_NAMES[i]}
done