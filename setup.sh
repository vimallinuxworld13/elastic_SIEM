https://docs.docker.com/engine/install/rhel/#install-using-the-repository

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker


docker network create elastic

docker run --name es01 -dit -p 9200:9200 --net elastic   docker.elastic.co/elasticsearch/elasticsearch:9.2.1
