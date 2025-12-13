https://docs.docker.com/engine/install/rhel/#install-using-the-repository

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker


docker network create elastic

docker run --name es01 -dit -p 9200:9200 --net elastic   docker.elastic.co/elasticsearch/elasticsearch:9.2.1

docker run --name kib01  -e XPACK_ENCRYPTEDSAVEDOBJECTS_ENCRYPTIONKEY=3e54c5cd0b159bcd5f24b6f3f5650b1a -dit --net elastic -p 5601:5601 docker.elastic.co/kibana/kibana:9.2.1

docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

docker exec -i  es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic


