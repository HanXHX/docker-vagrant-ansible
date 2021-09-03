#!/bin/bash

BASE_IMG="hanxhx/vagrant-ansible"
TAGS="debian8 debian9 debian10 debian11 ubuntu16.04 ubuntu18.04 ubuntu20.04"

rm -f ./docker-compose.yml
echo -e "---\n" > docker-compose.yml

cat > docker-compose.yml << EOF
---

version: '3.5'

services:

EOF


for tag in $TAGS
do
	cat >> docker-compose.yml << EOF
  ${tag}:
    image: ${BASE_IMG}:${tag} 
    build:
      context: ./${tag}

EOF
done


for tag in $TAGS
do
	docker-compose build ${tag}
	docker-compose push ${tag}
done
