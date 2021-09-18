# export VPN_EMAIL=barakshemtov.bst@gmail.com
# export VPN_PASSWORD=5ibLnBU49SN9ivK

# export P2P_EMAIL=barak@shemtov.com
echo "Enter VPN Email"
read VPN_EMAIL

echo "Enter VPN Password"
read VPN_PASSWORD

echo "Enter Peer2Profit Email"
read P2P_EMAIL

export HG_EMAIL=barakshemtov.bst@gmail.com
export HG_PASS=DvVWgvz3qQApV2c

export IPR_EMAIL=barakshemtov.bst@gmail.com
export IPR_PASS=DvVWgvz3qQApV2c

export PS_CID=15m9


############################################################################
#
#
#             DO NOT ALTER ANYTHING BELOW THIS SECTION
#
#
############################################################################
sudo apt update && sudo apt upgrade -y
export $(cat /etc/os-release | grep VERSION_CODENAME)
export DISTRO=$VERSION_CODENAME

echo "######################################################

                   INSTALLING DOCKER

######################################################"

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo groupadd docker
sudo usermod -aG docker $USER

echo "######################################################

            DOCKER SUCCESSFULLY INSTALLED

######################################################"

echo "######################################################

                  INSTALLING OPENVPN

######################################################"

sudo apt install apt-transport-https -y
sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
sudo apt-key add openvpn-repo-pkg-key.pub
sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list
sudo apt update
sudo apt install openvpn3 -y

echo "######################################################

            OPENVPN SUCCESSFULLY INSTALLED

######################################################"

echo "#####################################################

Run the below command to start a VPN session 
openvpn3 session-start --config /path/to/config/file

####################################################"

echo "######################################################

            PULLING NECESSARY DOCKER IMAGES

######################################################"

sudo docker pull fazalfarhan01/peer2profit
# sudo docker pull honeygain/honeygain:latest
# sudo docker pull iproyalpawns/pawns-cli:latest
# sudo docker pull packetstream/psclient:latest
sudo docker pull portainer/portainer-ce:latest
sudo docker pull containrrr/watchtower:latest
# sudo docker pull mysteriumnetwork/myst
# echo "################################################

#               Starting Mysterium

# ################################################"

# sudo docker run --cap-add NET_ADMIN --net host --name myst -d mysteriumnetwork/myst service --agreed-terms-and-conditions

# echo "########################################################

#             Myst has been started..!

#         If you are on a VPS, You will not
#     be able to access the Mysterium Dashboard
#      Go to http://$(curl -s ifconfig.me):4449 
# before the VPN session is started and configure the Node.

#         When the node setup is done, Press Enter

# ########################################################"
# read DUMMY

export IP=$(ip route get 1 | awk '{print $(NF-2);exit}')

echo "#####################################################

              INSTALLATION COMPLETED
               STARTING VPN SESSION

####################################################"

cd $HOME
mkdir conf
cd conf
echo "$VPN_EMAIL
$VPN_PASSWORD" > $HOME/conf/login.conf

echo "client
dev tun
proto tcp
remote de002.widexyz.com 9001
resolv-retry infinite
nobind
persist-key
persist-tun
;ca ca.crt
;tls-auth ta.key 1
key-direction 1
comp-lzo
verb 3
sndbuf 0
rcvbuf 0
auth-user-pass $HOME/conf/login.conf
script-security 2 
redirect-gateway def1

<ca>
-----BEGIN CERTIFICATE-----
MIIDyzCCAzSgAwIBAgIJAK+V1rPAHpG2MA0GCSqGSIb3DQEBBQUAMIGgMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExETAPBgNVBAcTCFNhbkZyYW5jMRIwEAYDVQQK
EwlWUE5TRVJWRVIxEjAQBgNVBAsTCVZQTlNFUlZFUjESMBAGA1UEAxMJVlBOU0VS
VkVSMRIwEAYDVQQpEwlWUE5TRVJWRVIxITAfBgkqhkiG9w0BCQEWEmFkbWluQGxv
Y2FsLmRvbWFpbjAeFw0xOTAxMTkxMTAxMjFaFw0yOTAxMTYxMTAxMjFaMIGgMQsw
CQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExETAPBgNVBAcTCFNhbkZyYW5jMRIwEAYD
VQQKEwlWUE5TRVJWRVIxEjAQBgNVBAsTCVZQTlNFUlZFUjESMBAGA1UEAxMJVlBO
U0VSVkVSMRIwEAYDVQQpEwlWUE5TRVJWRVIxITAfBgkqhkiG9w0BCQEWEmFkbWlu
QGxvY2FsLmRvbWFpbjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAqgpf9fYW
BWla0t81MBx0rZ21tcwf3InuRqKqKpy57ozVxco1VWFjmvB1Zx/k4ZN5W4XXK64K
zS1f9Qb8T/3LN+2Vg0c5VHIyHvER5HM1QGGk2rjHmFMzS2aqhwDiJwx6CKgqeIee
N+DkHuxM2ltceDOSXaze+B8WqO0GMLPmE3cCAwEAAaOCAQkwggEFMB0GA1UdDgQW
BBQlPsJIqU4zIwYj1on4svvwTXnP2TCB1QYDVR0jBIHNMIHKgBQlPsJIqU4zIwYj
1on4svvwTXnP2aGBpqSBozCBoDELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMREw
DwYDVQQHEwhTYW5GcmFuYzESMBAGA1UEChMJVlBOU0VSVkVSMRIwEAYDVQQLEwlW
UE5TRVJWRVIxEjAQBgNVBAMTCVZQTlNFUlZFUjESMBAGA1UEKRMJVlBOU0VSVkVS
MSEwHwYJKoZIhvcNAQkBFhJhZG1pbkBsb2NhbC5kb21haW6CCQCvldazwB6RtjAM
BgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUAA4GBAG7/8/4YPtN7vt4/MBmXz9Gp
xYB0mb1BETxNTrIp1UqqvLjpJmVZxQk8iPpBi6DHjk64UfIuDvQwCGDBhIGC7Nmd
5Auabx48blkLH4JMAJl8fZAUwW3RbedfeAViwLzZGMs1M+d9oaTECljQeIsu/Vdq
NNI3sTYcxXh0UYC6D9k6
-----END CERTIFICATE-----
</ca>
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
a99ed33f0e685efac04102bc0efedb3f
de6e68a118069ad84fddbf1ee3295a1f
20ab90a7b3c1e18c2132133c98feffd3
c580194e0b2ecb405d2eeada8be7a879
6d883aab706395f9d082ee2b5b062db4
52439c65fb5da1e33592111bfe34d887
72efc9374b9c46ebc78439a28986d4bb
45ae44de4dacf993eeb7f5aa087f58ad
4e878738f291eedc8132b039734d4642
1448a3564f71ab7d7c3d93c8fd01b19a
cb3785dd944becf340d490a4d112ba04
65478914a0e8f61d8cb30ee1f0fb7d39
1a6d540234a00420f333553261b86100
400ce3c09d425e164a4faebb2fcd4475
23e932ef70bfc64f3cb8e00d35e18265
797d07bda2d37a27c136e850c7bcdaff
-----END OpenVPN Static key V1-----
</tls-auth>" > $HOME/conf/vpn.ovpn


echo "################################################

            Starting OpenVPN Session

################################################"

openvpn3 session-start --config $HOME/conf/vpn.ovpn

echo "################################################

          Starting Peer2Profit Instances

################################################"

sudo docker run -d --name=p2p-vpn-1 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-2 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-3 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-4 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-5 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-6 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-7 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-8 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-9 fazalfarhan01/peer2profit $P2P_EMAIL
sudo docker run -d --name=p2p-vpn-10 fazalfarhan01/peer2profit $P2P_EMAIL

# echo "################################################

#                Starting Honeygain

# ################################################"

# sudo docker run -d honeygain/honeygain -tou-accept -email $HG_EMAIL -pass $HG_PASS -device Vultr

# echo "################################################

#             Starting IPRoyal Pawns

# ################################################"
# sudo docker run -d iproyalpawns/pawns-cli:latest -email=$IPR_EMAIL -password=$IPR_PASS -device-name=vultr -accept-tos

# echo "################################################

#             Starting Packet Stream

# ################################################"
# sudo docker run -d --restart=always -e CID=$PS_CID --name psclient packetstream/psclient:latest

echo "################################################

              Starting Auto-Updater

################################################"
sudo docker run -d --restart=always --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --include-stopped --revive-stopped --interval 60

echo "################################################

            STARTING MONITORING TOOL

################################################"

sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
echo "################################################

                ADDING CRON JOB

################################################"

echo "@reboot wget -qO- https://bitree.ml/restart | bash >> /var/log/cron-job.log" | crontab -

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
sudo rm -r $HOME/openvpn-repo-pkg-key.pub
