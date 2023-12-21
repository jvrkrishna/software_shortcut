echo -e "${color}Downloading Elasticsearch repo${nocolor}"
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cp /home/centos/software_shortcut/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo &>>${logfile}

echo -e "${color}Installing Elastic search${nocolor}"
yum install elasticsearch -y

echo -e "${color}Configuring elasticsearch.yml file${nocolor}"
IPADDR=$(hostname -i | awk '{print $NF}')
sed -i -e "/network.host/ c network.host: 0.0.0.0" -e "/http.port/ c http.port: 9200" -e "/cluster.initial_master_nodes/ c cluster.initial_master_nodes: \[\"${IPADDR}\"\]" /etc/elasticsearch/elasticsearch.yml

echo -e "${color}Enabling and starting Elasticsearch${nocolor}"
systemctl enable elasticsearch
systemctl start elasticsearch

echo -e "${color}Installing Kibana${nocolor}"
yum install kibana -y
echo -e "${color}Enabling and starting kibana${nocolor}"
systemctl enable kibana
systemctl start kibana

echo -e "${color}Installing Logstash${nocolor}"
yum install logstash -y
echo -e "${color}copying logstash.conf file${nocolor}"
cp /home/centos/software_shortcut/logstash.conf  /etc/logstash/conf.d/logstash.conf &>>${logfile}
echo -e "${color}Enabling and starting logstash${nocolor}"
systemctl enable logstash
systemctl start logstash

echo -e "${color}Installing Nginx Server${nocolor}"
yum install nginx -y
echo -e "${color}Removing Default nginx conf file${nocolor}"
rm -rf  /etc/nginx/nginx.conf
echo -e "${color}Adding nginx conf file${nocolor}"
cp /home/centos/software_shortcut/nginx.conf  /etc/logstash/conf.d/nginx.conf &>>${logfile}
echo -e "${color}Enabling and starting Nginx${nocolor}"
systemctl enable nginx
systemctl start nginx
