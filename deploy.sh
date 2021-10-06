#!/bin/bash

options=$(find src/main/java/fr/irisa/* -maxdepth 1 -type d | sed -r 's/.*\///g')
# for d in $options
# do
	# echo ">" $d
# done

echo -e "\033[33mWhich package to build?\033[0m"
select item in ${options[@]}
do
  profile=$item
  break;
done < /dev/tty

echo -e "\033[33mRemoving old Docker container\033[0m"
docker container stop wasm &> /dev/null
docker container rm wasm &> /dev/null

echo -e "\033[33mBuilding sources from\033[32m" $profile "\033[0m"
mvn clean package -P $profile
echo -e "\033[33mBuilding Docker image\033[0m"
docker build -t wasm . &> /dev/null
echo -e "\033[33mRunning container\033[0m"
docker run --name wasm -dp 80:80 wasm &> /dev/null