export P2P_EMAIL=barak@shemtov.com

echo "#####################################################

            STOPPING AND TERMINATING ALL
                    CONTAINERS

####################################################"
sudo docker rm -f $(docker ps -aq)
echo "#####################################################

          ALL CONTAINERS STOPPED & REMOVED

####################################################"

echo "#####################################################

              TERMINATING VPN SESSION

####################################################"

openvpn3 session-manage --disconnect --config $HOME/conf/uk001.ovpn
sleep 5s
echo "#####################################################

               VPN SESSION TERMINATED

####################################################"
export IP=$(ip route get 1 | awk '{print $(NF-2);exit}')

echo "#####################################################

              RESTARTING VPN SESSION

####################################################"
openvpn3 session-start --config $HOME/conf/uk001.ovpn

echo "################################################

          Starting Peer2Profit Instances

################################################"

sudo docker run -d --name=p2p-vpn-1 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-2 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-3 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-4 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-5 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-6 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-7 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-8 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-9 fazalfarhan01/peer2profit $P2P_EMAIL
sleep 2s
sudo docker run -d --name=p2p-vpn-10 fazalfarhan01/peer2profit $P2P_EMAIL

echo "################################################

            STARTING MONITORING TOOL

################################################"

sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

echo "################################################

              Starting Auto-Updater

################################################"

sudo docker run -d --restart=always --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --include-stopped --revive-stopped --interval 60

# export IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export PUBLIC_IP=$(curl --silent myip.wtf/text)


echo "##########################################################################

                            DONE...!
                       Everything is done...!
                    Keep an eye on the dashboard.
              $PUBLIC_IP is your Public IP from VPN
            View more info on your VPN IP fron link below
            https://whatismyipaddress.com/ip/$PUBLIC_IP

        Visit http://$IP:9000/ to monitor containers

##########################################################################"
