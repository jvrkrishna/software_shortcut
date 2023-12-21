echo -e "\e[36mDownloading Elasticsearch repo \e[0m"
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cp /home/centos/software_shortcut/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo 

echo -e "\e[36mInstalling Elastic search\e[0m"
yum install elasticsearch -y

echo -e "\e[36mConfiguring elasticsearch.yml file\e[0m"
IPADDR=$(hostname -i | awk '{print $NF}')
sed -i -e "/network.host/ c network.host: 0.0.0.0" -e "/http.port/ c http.port: 9200" -e "/cluster.initial_master_nodes/ c cluster.initial_master_nodes: \[\"${IPADDR}\"\]" /etc/elasticsearch/elasticsearch.yml

echo -e "\e[36mEnabling and starting Elasticsearch\e[0m"
systemctl enable elasticsearch
systemctl start elasticsearch

echo -e "\e[36mInstalling Kibana\e[0m"
yum install kibana -y
echo -e "\e[36mEnabling and starting kibana\e[0m"
systemctl enable kibana
systemctl start kibana

echo -e "\e[36mInstalling Logstash\e[0m"
yum install logstash -y
echo -e "\e[36mcopying logstash.conf file\e[0m"
cp /home/centos/software_shortcut/logstash.conf  /etc/logstash/conf.d/logstash.conf
echo -e "\e[36mEnabling and starting logstash\e[0m"
systemctl enable logstash
systemctl start logstash

echo -e "\e[36mInstalling Nginx Server\e[0m"
yum install nginx -y
echo -e "\e[36mRemoving Default nginx conf file\e[0m"
rm -rf  /etc/nginx/nginx.conf
echo -e "\e[36mAdding nginx conf file\e[0m"
cp /home/centos/software_shortcut/nginx.conf  /etc/logstash/conf.d/nginx.conf
echo -e "\e[36mEnabling and starting Nginx\e[0m"
systemctl enable nginx
systemctl start nginx
