#!/bin/bash
SSH_PEM="/Users/sparr/.ssh/hackathon.pem"
COOKIE="vjas0i398asdjv093ruasoijvkdbn04"
MASTER_SERVER=ec2-52-35-18-14.us-west-2.compute.amazonaws.com
MASTER="master@172.31.18.42"

###########################################
#echo "shutting down master"
#rm vm.args
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && ./rel/master/bin/master stop"
#echo "uploading master"
#tar czf master.tar.gz master
#scp -i $SSH_PEM master.tar.gz ubuntu@$MASTER_SERVER:~
#echo "extracting package"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "tar xzf master.tar.gz"
#echo "building release"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && mix deps.get"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && MIX_ENV=prod mix compile"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && MIX_ENV=prod mix release"
#echo "running master"
#echo "-name $MASTER
#-setcookie $COOKIE" > vm.args
#scp -i $SSH_PEM vm.args ubuntu@$MASTER_SERVER:~/master/rel/master/running-config/vm.args
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && CITIES=~/master/resources/cities.json ./rel/master/bin/master start"
#sleep 1
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd master && ./rel/master/bin/master rpc Elixir.Master start"

###########################################
PROJECT="login"
#echo "###################################"
#echo "shutting down $PROJECT"
#rm vm.args
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && ./rel/$PROJECT/bin/$PROJECT stop"
#echo "uploading $PROJECT"
#tar czf $PROJECT.tar.gz $PROJECT
#scp -i $SSH_PEM $PROJECT.tar.gz ubuntu@$MASTER_SERVER:~
#echo "extracting package"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "tar xzf $PROJECT.tar.gz"
#echo "building release"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && mix deps.get"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix phoenix.digest"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix compile"
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix release"
#echo "running $PROJECT"
#echo "-name $PROJECT@172.31.18.42
#-setcookie $COOKIE" > vm.args
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER mkdir $PROJECT/rel/$PROJECT/running-config
#scp -i $SSH_PEM vm.args ubuntu@$MASTER_SERVER:~/$PROJECT/rel/$PROJECT/running-config/vm.args
#ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MASTER=$MASTER PORT=4000 ./rel/$PROJECT/bin/$PROJECT start"

###########################################
PROJECT="world_map"
echo "###################################"
echo "shutting down $PROJECT"
rm vm.args
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && ./rel/$PROJECT/bin/$PROJECT stop"
echo "uploading $PROJECT"
tar czf $PROJECT.tar.gz $PROJECT
scp -i $SSH_PEM $PROJECT.tar.gz ubuntu@$MASTER_SERVER:~
echo "extracting package"
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "tar xzf $PROJECT.tar.gz"
echo "building release"
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && mix deps.get"
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix phoenix.digest"
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix compile"
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MIX_ENV=prod mix release"
echo "running $PROJECT"
echo "-name $PROJECT@172.31.18.42
-setcookie $COOKIE" > vm.args
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "mkdir ~/$PROJECT/rel/$PROJECT/running-config"
scp -i $SSH_PEM vm.args ubuntu@$MASTER_SERVER:~/$PROJECT/rel/$PROJECT/running-config/vm.args
ssh -i $SSH_PEM ubuntu@$MASTER_SERVER "cd $PROJECT && MASTER=$MASTER PORT=4001 ./rel/$PROJECT/bin/$PROJECT start"

###########################################
###########################################
###########################################
###########################################
###########################################

copy_server()
{
#ssh -i $SSH_PEM ubuntu@$SERVER
echo "###################################"
ssh -i $SSH_PEM ubuntu@$SERVER "rm -rf web"
echo "shutting down $PROJECT"
rm vm.args
ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && ./rel/web/bin/web stop"
echo "uploading $PROJECT"
tar czf $PROJECT.tar.gz web
#scp -i $SSH_PEM $PROJECT.tar.gz ubuntu@$SERVER:~
echo "extracting package"
#ssh -i $SSH_PEM ubuntu@$SERVER "tar xzf $PROJECT.tar.gz"
#ssh -i $SSH_PEM ubuntu@$SERVER "rm -rf $PROJECT"
#ssh -i $SSH_PEM ubuntu@$SERVER "cp -rf web $PROJECT"
#ssh -i $SSH_PEM ubuntu@$SERVER "cp -rf web/lib/* $PROJECT/web/lib/"
#ssh -i $SSH_PEM ubuntu@$SERVER "cp -rf web/web/* $PROJECT/web/web/"
echo "building release"
#ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && mix deps.get"
#ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && MIX_ENV=prod mix phoenix.digest"
#ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && MIX_ENV=prod mix compile"
#ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && MIX_ENV=prod mix release"
echo "running $PROJECT"
echo "-name $PROJECT@$IP
-setcookie $COOKIE" > vm.args
ssh -i $SSH_PEM ubuntu@$SERVER "mkdir ~/$PROJECT/rel/web/running-config"
scp -i $SSH_PEM vm.args ubuntu@$SERVER:~/$PROJECT/rel/web/running-config/vm.args
ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && MASTER=$MASTER PORT=$PORT CITY=$PROJECT SERVER=http://$SERVER:$PORT ./rel/web/bin/web start"
}

copy_site()
{
#echo "###################################"
echo "shutting down $PROJECT"
ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && ./rel/web/bin/web stop"
echo "running $PROJECT"
ssh -i $SSH_PEM ubuntu@$SERVER "rm -rf $PROJECT"
ssh -i $SSH_PEM ubuntu@$SERVER "cp -rf $SRC $PROJECT"
echo "-name $PROJECT@$IP
-setcookie $COOKIE" > vm.args
ssh -i $SSH_PEM ubuntu@$SERVER "mkdir ~/$PROJECT/rel/web/running-config"
scp -i $SSH_PEM vm.args ubuntu@$SERVER:~/$PROJECT/rel/web/running-config/vm.args
ssh -i $SSH_PEM ubuntu@$SERVER "cd $PROJECT && MASTER=$MASTER PORT=$PORT CITY=$PROJECT SERVER=http://$SERVER:$PORT ./rel/web/bin/web start"
}
#
############################################
#PROJECT="city_osaka_orange"
#SERVER=ec2-52-11-79-226.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.239
#
#copy_server
#
############################################
#PROJECT="city_lagos_yellow"
#PORT=4003
#SRC="city_osaka_orange"
#
#copy_site
#
############################################
#PROJECT="city_johanesberg_yellow"
#PORT=4004
#SRC="city_osaka_orange"
#
#copy_site
#
############################################
#PROJECT="city_stpetersburg_blue"
#SERVER=ec2-52-38-135-214.us-west-2.compute.amazonaws.com
#
#PORT=4002
#IP=172.31.44.240
#
#copy_server
#
############################################
#PROJECT="city_toronto_blue"
#PORT=4003
#SRC="city_stpetersburg_blue"
#
#copy_site
#
############################################
#PROJECT="city_saopaolo_yellow"
#PORT=4004
#SRC="city_stpetersburg_blue"
#
#copy_site
#
#
############################################
#PROJECT="city_milan_blue"
#
#SERVER=ec2-52-38-136-11.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.243
#
#
#copy_server
#
############################################
#PROJECT="city_washington_blue"
#PORT=4003
#SRC="city_milan_blue"
#
#copy_site
#
############################################
#PROJECT="city_manila_orange"
#PORT=4004
#SRC="city_milan_blue"
#
#copy_site
#
#
#
#
#
############################################
#PROJECT="city_london_blue"
#SERVER=ec2-52-38-138-84.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.244
#
#
#copy_server
#
############################################
#PROJECT="city_tokyo_orange"
#PORT=4003
#SRC="city_london_blue"
#copy_site
#
############################################
#PROJECT="city_beijing_orange"
#PORT=4004
#SRC="city_london_blue"
#
#copy_site
#
#
#
#
#
#
###########################################
#PROJECT="city_chicago_blue"
#SERVER=ec2-52-37-157-11.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.241
#
#
#copy_server
#
############################################
#PROJECT="city_paris_blue"
#PORT=4003
#SRC="city_chicago_blue"
#copy_site
#
############################################
#PROJECT="city_taipei_orange"
#PORT=4004
#SRC="city_chicago_blue"
#copy_site
#
#
#
############################################
#PROJECT="city_hongkong_orange"
#SERVER=ec2-52-38-100-240.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.242
#
#copy_server
#
############################################
#PROJECT="city_madrid_blue"
#PORT=4003
#SRC="city_hongkong_orange"
#
#copy_site
#
############################################
#PROJECT="city_lima_yellow"
#PORT=4004
#SRC="city_hongkong_orange"
#
#copy_site
#
#
#
#
############################################
#PROJECT="city_newyork_blue"
#SERVER=ec2-52-38-135-233.us-west-2.compute.amazonaws.com
#
#PORT=4002
#IP=172.31.44.247
#
#copy_server
#
############################################
#PROJECT="city_algiers_black"
#PORT=4003
#SRC="city_newyork_blue"
#
#copy_site
#
############################################
#PROJECT="city_delhi_black"
#
#PORT=4004
#SRC="city_newyork_blue"
#
#copy_site
#
#
#
#
#
############################################
#PROJECT="city_santiago_yellow"
#SERVER=ec2-52-38-128-46.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.248
#
#copy_server
#
############################################
#PROJECT="city_baghdad_black"
#PORT=4003
#SRC="city_santiago_yellow"
#
#copy_site
#
############################################
#PROJECT="city_tehran_black"
#PORT=4004
#SRC="city_santiago_yellow"
#
#copy_site
#
#
#
#
#
#
#
############################################
#PROJECT="city_seoul_orange"
#SERVER=ec2-52-38-66-255.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.245
#
#copy_server
#
############################################
#PROJECT="city_mumbai_black"
#PORT=4003
#SRC="city_seoul_orange"
#
#copy_site
#
############################################
#PROJECT="city_moscow_black"
#PORT=4004
#SRC="city_seoul_orange"
#
#copy_site
#
#
#
#
############################################
#PROJECT="city_shanghai_orange"
#
#SERVER=ec2-52-38-135-209.us-west-2.compute.amazonaws.com
#
#PORT=4002
#IP=172.31.44.246
#
#copy_server
#
############################################
#PROJECT="city_buenosaires_yellow"
#
#PORT=4003
#SRC="city_shanghai_orange"
#
#copy_site
#
############################################
#PROJECT="city_mexicocity_yellow"
#
#PORT=4004
#SRC="city_shanghai_orange"
#
#copy_site
#
#
#
#
#
############################################
#PROJECT="city_khartoum_yellow"
#SERVER=ec2-52-38-135-186.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.251
#
#copy_server
#
############################################
#PROJECT="city_chennai_black"
#PORT=4003
#SRC="city_khartoum_yellow"
#
#copy_site
#
############################################
#PROJECT="city_losangeles_yellow"
#PORT=4004
#SRC="city_khartoum_yellow"
#
#copy_site
#
#
#
#
#
############################################
#PROJECT="city_kolkata_black"
#SERVER=ec2-52-38-43-82.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.252
#
#copy_server
#
############################################
#PROJECT="city_bogota_yellow"
#
#PORT=4003
#SRC="city_kolkata_black"
#
#copy_site
#
############################################
#PROJECT="city_miami_yellow"
#
#PORT=4004
#SRC="city_kolkata_black"
#
#copy_site
#
#
#
#
#
############################################
#PROJECT="city_riyadh_black"
#SERVER=ec2-52-38-135-171.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.249
#
#copy_server
#
############################################
#PROJECT="city_essen_blue"
#PORT=4003
#SRC="city_riyadh_black"
#
#copy_site
#
############################################
#PROJECT="city_kinshasa_yellow"
#PORT=4004
#SRC="city_riyadh_black"
#
#copy_site
#
#
#
#
############################################
#PROJECT="city_jakarta_orange"
#SERVER=ec2-52-38-138-99.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.250
#
#copy_server
#
############################################
#PROJECT="city_karachi_black"
#PORT=4003
#SRC="city_jakarta_orange"
#
#copy_site
#
############################################
#PROJECT="city_atlanta_blue"
#
#PORT=4004
#SRC="city_jakarta_orange"
#
#copy_site
#
#
#
#
############################################
#PROJECT="city_hochimincity_orange"
#SERVER=ec2-52-38-112-43.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.255
#
#copy_server
#
############################################
#PROJECT="city_sydney_orange"
#PORT=4003
#SRC="city_hochimincity_orange"
#
#copy_site
#
############################################
#PROJECT="city_sanfrancisco_blue"
#PORT=4004
#SRC="city_hochimincity_orange"
#
#copy_site
#
#
#
#
############################################
#PROJECT="city_cairo_black"
#SERVER=ec2-52-38-85-74.us-west-2.compute.amazonaws.com
#PORT=4002
#IP=172.31.44.253
#
#copy_server
#
############################################
#PROJECT="city_bangkok_orange"
#PORT=4003
#SRC="city_cairo_black"
#
#copy_site
#
############################################
#PROJECT="city_istanbul_black"
#PORT=4004
#SRC="city_cairo_black"
#
#copy_site

#ssh -i ~/.ssh/hackathon.pem ubuntu@ec2-52-35-18-14.us-west-2.compute.amazonaws.com
#./rel/world_map/bin/world_map stop
#MASTER=master@172.31.18.42 PORT=4001 iex --cookie vjas0i398asdjv093ruasoijvkdbn04 -S mix phoenix.server