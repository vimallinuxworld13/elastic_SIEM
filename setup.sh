in RHEL machine:
------------------
https://docs.docker.com/engine/install/rhel/#install-using-the-repository
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

in AWS linux machine:
---------------------
[ec2-user@ip-172-31-28-165 ~]$ sudo su - root
[root@ip-172-31-28-165 ~]# yum install docker
# systemctl enable --now docker







docker network create elastic

sysctl vm.max_map_count
sysctl vm.max_map_count=262144
sysctl vm.max_map_count

docker run --name es01 -dit -p 9200:9200 --net elastic   docker.elastic.co/elasticsearch/elasticsearch:9.2.1

docker logs -f es01


docker run --name kib01  -e XPACK_ENCRYPTEDSAVEDOBJECTS_ENCRYPTIONKEY=3e54c5cd0b159bcd5f24b6f3f5650b1a -dit --net elastic -p 5601:5601 docker.elastic.co/kibana/kibana:9.2.1

docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

# docker logs kib01

docker exec -i  es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

echo 3 > /proc/sys/vm/drop_caches



curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-9.2.1-x86_64.rpm
sudo ELASTIC_AGENT_FLAVOR=servers rpm -vi elastic-agent-9.2.1-x86_64.rpm
sudo systemctl enable elastic-agent
sudo systemctl start elastic-agent
sudo elastic-agent enroll \
  --fleet-server-es=https://172.18.0.2:9200 \
  --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE3NjU3MTM5Mzg3NTM6NGpqWkJzME9SZkNxb05TWm1XZUxEUQ \
  --fleet-server-policy=fleet-server-policy \
  --fleet-server-es-ca-trusted-fingerprint=3e951488d30259f4b0c833d387067877194bfbcdb2bb164f9039ba5c063d551c \
  --fleet-server-port=8220

