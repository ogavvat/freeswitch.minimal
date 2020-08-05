#!/bin/bash

# Replace RTP Port Settings
sed -i "s/ENV_RTP_START_PORT/$RTP_START_PORT/" /etc/freeswitch/autoload_configs/switch.conf.xml
sed -i "s/ENV_RTP_END_PORT/$RTP_END_PORT/" /etc/freeswitch/autoload_configs/switch.conf.xml

# Replace XML_CDR Settings
sed -i "s/{v_http_protocol}/$XML_CDR_PROTOCOL/"  /etc/freeswitch/autoload_configs/xml_cdr.conf.xml 
sed -i "s/{domain_name}/$XML_CDR_HOST/"  /etc/freeswitch/autoload_configs/xml_cdr.conf.xml 
sed -i "s/{v_user}/$XML_CDR_USER/"  /etc/freeswitch/autoload_configs/xml_cdr.conf.xml 
sed -i "s/{v_pass}/$XML_CDR_PASSWORD/"  /etc/freeswitch/autoload_configs/xml_cdr.conf.xml 
sed -i "s/{v_project_path}//"  /etc/freeswitch/autoload_configs/xml_cdr.conf.xml 

# Replace Memcache Settings
sed -i "s/ENV_MEMCACHE_SERVER/$MEMCACHE_SERVER/"  /etc/freeswitch/autoload_configs/memcache.conf.xml

# Replace Event Socket Settings
sed -i "s/ENV_EVENTSOCKET_PORT/$EVENTSOCKET_PORT/"  /etc/freeswitch/autoload_configs/event_socket.conf.xml
sed -i "s/ENV_EVENTSOCKET_PORT/$EVENTSOCKET_PORT/"  /etc/fs_cli.conf

# Start server.
echo 'Starting Freeswitch...'
/usr/bin/freeswitch
