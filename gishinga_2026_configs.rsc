# 2025-08-12 13:35:34 by RouterOS 7.16.1
# software id = DGNU-VIYY
#
# model = CCR2116-12G-4S+
# serial number = HHE0A76QMKN
/interface bridge
add name=bridge1
add name=bridge2
add name=bridge3-server
add name=dhcp
/interface ethernet
set [ find default-name=ether1 ] name="ether1- internet"
set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no speed=1G-baseX
/interface ovpn-client
add certificate=hospotmtaani1.crt_0 cipher=aes256-cbc connect-to=167.99.82.48 \
    mac-address=02:58:47:F8:28:12 name=ovpn-wispman port=1443 route-nopull=\
    yes user=mtaani
/interface vlan
add interface=sfp-sfpplus1 name=AIRTEL vlan-id=838
/ip hotspot profile
add dns-name=HOSTPOT.NET hotspot-address=10.20.0.1 html-directory=\
    HH_MTAANI_WISPMANHOTSPOT5 html-directory-override=\
    HH_MTAANI_WISPMANHOTSPOT5 login-by=\
    mac,cookie,http-chap,https,http-pap,mac-cookie mac-auth-password=123456 \
    name=hsprof1
/ip pool
add name=Expired-Pool ranges=90.0.0.2-90.0.0.254
add name=PPPOE ranges=92.0.0.0/8
add name=dhcp_pool4 ranges=192.168.60.2-192.168.60.254
add name=dhcp_pool5 ranges=192.168.2.2-192.168.2.254
add name=dhcp_pool6 ranges=192.168.30.2-192.168.30.254
add name=dhcp_pool7 ranges=192.168.2.2-192.168.2.254
add name=dhcp_pool8 ranges=192.168.30.2
add name=dhcp_pool9 ranges=192.168.40.2
add name=dhcp_pool10 ranges=192.168.40.2
add name=dhcp_pool11 ranges=172.20.10.2-172.20.10.254
add name=hs-pool-20 ranges=10.20.0.2-10.20.3.254
/ip dhcp-server
add address-pool=dhcp_pool6 interface=bridge2 name=dhcp2
add address-pool=dhcp_pool10 interface=bridge3-server name=dhcp3
add address-pool=dhcp_pool11 interface=dhcp name=dhcp4
add address-pool=hs-pool-20 interface=bridge1 name=dhcp1
/ip hotspot
add address-pool=hs-pool-20 disabled=no interface=bridge1 name=hotspot1 \
    profile=hsprof1
/ip hotspot user profile
add address-pool=hs-pool-20 name=1hour rate-limit=10M/10M shared-users=2
add address-pool=hs-pool-20 name=12hours rate-limit=10M/10M shared-users=2
add address-pool=hs-pool-20 name=24hours rate-limit=10M/10M shared-users=2
add address-pool=hs-pool-20 name=weekly rate-limit=10M/10M shared-users=2
add address-pool=hs-pool-20 name=monthly rate-limit=10M/10M shared-users=2
add address-pool=hs-pool-20 name=24hours- rate-limit=15M/15M shared-users=2
add address-pool=hs-pool-20 name=24hrs-test rate-limit=10M/10M shared-users=\
    500
add address-pool=hs-pool-20 name=24hrs- rate-limit=20M/20M shared-users=2
/port
set 0 name=serial0
/ppp profile
add change-tcp-mss=no dns-server=90.10.0.1 local-address=90.10.0.1 name=\
    Expired rate-limit=1K/1K remote-address=Expired-Pool
add name=profile1
add local-address=92.0.0.1 name=3mbps rate-limit=3M/3M remote-address=PPPOE
add local-address=92.0.0.1 name=6mbps rate-limit=6M/6M remote-address=PPPOE
add local-address=92.0.0.1 name=8mbps rate-limit=8M/8M remote-address=PPPOE
add local-address=92.0.0.1 name=10mbps rate-limit=10M/10M remote-address=\
    PPPOE
add local-address=92.0.0.1 name=4mbps rate-limit=4M/4M remote-address=PPPOE
add local-address=92.0.0.1 name=20mbps rate-limit=20M/20M remote-address=\
    PPPOE
add local-address=92.0.0.1 name=15mbps rate-limit=15M/15M remote-address=\
    PPPOE
/interface bridge port
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
add bridge=bridge1 interface=ether7
add bridge=bridge1 interface=ether8
add bridge=bridge1 interface=ether10
add bridge=bridge1 interface=ether11
add bridge=bridge2 interface=ether2
add bridge=bridge1 interface=ether6
add bridge=bridge2 interface=ether9
add bridge=dhcp interface=ether12
add bridge=bridge2 interface="ether1- internet"
add bridge=bridge1 interface=ether13
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface pppoe-server server
add authentication=pap disabled=no interface=bridge1 one-session-per-host=yes \
    service-name="PPPoE Server"
/ip address
add address=102.0.18.50 interface=AIRTEL network=102.0.18.51
add address=192.168.30.1/24 interface=bridge2 network=192.168.30.0
add address=192.168.40.1/30 interface=bridge3-server network=192.168.40.0
add address=172.20.10.1/24 interface=dhcp network=172.20.10.0
add address=10.20.0.1/22 comment="hotspot network" interface=bridge1 network=\
    10.20.0.0
/ip dhcp-client
# DHCP client can not run on slave or passthrough interface!
add interface="ether1- internet"
/ip dhcp-server lease
add address=192.168.30.254 client-id=1:d4:1:c3:3:bd:be mac-address=\
    D4:01:C3:03:BD:BE server=dhcp2
add address=10.0.15.252 client-id=1:76:3e:62:90:f2:45 mac-address=\
    76:3E:62:90:F2:45 server=*1
/ip dhcp-server network
add address=10.20.0.0/22 comment="hotspot network" gateway=10.20.0.1
add address=172.20.10.0/24 gateway=172.20.10.1
add address=192.168.2.0/24 dns-server=8.8.8.8,8.8.4.4,208.67.222.222 gateway=\
    192.168.2.1
add address=192.168.30.0/24 dns-server=8.8.8.8,8.8.4.4,208.67.222.222 \
    gateway=192.168.30.1
add address=192.168.40.0/30 gateway=192.168.40.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=input dst-port=9091 protocol=tcp
add action=drop chain=input comment="Block Telnet brute-force IPs" \
    src-address-list=blocked
add action=accept chain=forward dst-port="" in-interface=bridge1 protocol=tcp
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=AIRTEL
add action=dst-nat chain=dstnat comment="T-CINEMA PORT FORWARD" dst-port="" \
    in-interface=bridge1 protocol=tcp to-addresses=192.168.30.254 to-ports=80
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.20.0.0/20
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.20.0.0/22
/ip hotspot user
add name=admin password=123456
add name=esnino
add name=jimmy
add name=chulimlango
add name=velma
add name=mbuthia
add name=regina
add name=TOM password=17
add name=habiba
add name=yasmin
add name=Abdul
add name=sanchez
add name=habibty
add name=vinny
add name=davy
add name=lapi1
add name=jose
add name=main
add name=pedantic
add name=WANGUI
add name=Davy
add name="mah sharif"
add name=jamu
add name=Paul
add name=mwangi01
add name=lombo
add name=Guyo
add name=paul
add name=mteja
add name=Habiba
add name=Doctor
add name=james
add name=tv22
add name=Yasmin
add name=mugo
add name=wanda
add name=ped
add name=said
add name=jj
add name=IBRA
add name=kingpin
add name=teacher
add name=Admin
add name=robsora
add name=AZRA server=hotspot1
add name=izzo
add name=jerusha
add name=ADAN
add name=charles
add name=ixxo
add name=ndnugu
add name=Portugal
add name=user100 profile=24hours
add name=Hbiba
add name=itonyi
add name=madolla
add name="Ben)("
add name=cop
add name=yazmin
add name=mwasv8
add name=daisy
add name=amos
add name=1000
add name=josemlango profile=weekly
add name=ajax
add name=popo
add comment="46:98:D3:21:B3:D8 - 254745243573 Expires on:- 2025-09-01" name=\
    46:98:D3:21:B3:D8 password=123456 profile=monthly
add name=nyasembo
add comment=" - 254759543424 Expires on:- 2025-08-12" name=0E:F6:43:A7:E6:C9 \
    password=123456 profile=weekly
add comment="C4:FE:5B:03:49:13 - 254724763278 Expires on:- 2025-08-13" name=\
    C4:FE:5B:03:49:13 password=123456 profile=weekly
add comment="9A:CC:C2:BF:89:69 - 254769718774 Expires on:- 2025-08-13" name=\
    9A:CC:C2:BF:89:69 password=123456 profile=weekly
add comment="FA:65:04:CC:4B:B5 - 254726959909 Expires on:- 2025-08-17" name=\
    FA:65:04:CC:4B:B5 password=123456 profile=weekly
add comment="34:02:86:FA:F6:9A - 254707897498 Expires on:- 2025-08-17" name=\
    34:02:86:FA:F6:9A password=123456 profile=weekly
add comment="8A:A4:C4:3F:1C:B3 - 254743055806 Expires on:- 2025-08-17" name=\
    8A:A4:C4:3F:1C:B3 password=123456 profile=weekly
add name=carwash
add comment="B6:FE:2F:AB:AF:F0 - 254797993789 Expires on:- 2025-08-12" name=\
    B6:FE:2F:AB:AF:F0 password=123456 profile=12hours
add comment="3E:8B:36:A2:DA:CE - 254702860064 Expires on:- 2025-08-12" name=\
    3E:8B:36:A2:DA:CE password=123456 profile=12hours
add comment="96:D0:CC:0D:B7:D0 - 254112215611 Expires on:- 2025-08-12" name=\
    96:D0:CC:0D:B7:D0 password=123456 profile=12hours
add comment="BE:50:13:74:09:D4 - 254748120747 Expires on:- 2025-08-12" name=\
    BE:50:13:74:09:D4 password=123456 profile=12hours
add comment="5E:51:A9:BD:0B:16 - 254704823044 Expires on:- 2025-08-12" name=\
    5E:51:A9:BD:0B:16 password=123456 profile=12hours
add comment="02:C8:9C:47:FE:2A - 254702435308 Expires on:- 2025-08-12" name=\
    02:C8:9C:47:FE:2A password=123456 profile=12hours
add comment="0E:9B:23:14:E2:E9 - 254795819417 Expires on:- 2025-08-12" \
    limit-uptime=1d name=0E:9B:23:14:E2:E9 password=123456 profile=24hours
add comment="1E:3C:52:21:B6:85 - 254728056679 Expires on:- 2025-08-12" name=\
    1E:3C:52:21:B6:85 password=123456 profile=12hours
add comment="66:3F:7B:CE:D6:DC - 254110425538 Expires on:- 2025-08-12" name=\
    66:3F:7B:CE:D6:DC password=123456 profile=12hours
add comment="CA:D5:23:B6:BD:5C - 254742123104 Expires on:- 2025-08-12" name=\
    CA:D5:23:B6:BD:5C password=123456 profile=12hours
add comment="32:F3:16:47:3E:03 - 254748681786 Expires on:- 2025-08-12" name=\
    32:F3:16:47:3E:03 password=123456 profile=12hours
add comment="7A:80:83:BE:38:DA - 254715654666 Expires on:- 2025-08-12" name=\
    7A:80:83:BE:38:DA password=123456 profile=12hours
add comment="3A:54:6B:AB:5F:E1 - 254743364066 Expires on:- 2025-08-12" name=\
    3A:54:6B:AB:5F:E1 password=123456 profile=12hours
add comment="1E:E7:A7:65:EE:5E - 254757017761 Expires on:- 2025-08-12" name=\
    1E:E7:A7:65:EE:5E password=123456 profile=12hours
add comment="B6:4E:08:23:B2:C3 - 254723959451 Expires on:- 2025-08-12" \
    limit-uptime=1d name=B6:4E:08:23:B2:C3 password=123456 profile=24hours
add comment="46:FD:68:49:A2:F9 - 254746667832 Expires on:- 2025-08-12" name=\
    46:FD:68:49:A2:F9 password=123456 profile=12hours
add comment="82:28:AD:14:83:A8 - 254717399158 Expires on:- 2025-08-12" name=\
    82:28:AD:14:83:A8 password=123456 profile=12hours
add comment="82:E4:9F:00:03:69 - 254743593339 Expires on:- 2025-08-12" name=\
    82:E4:9F:00:03:69 password=123456 profile=12hours
add comment="3A:2C:5A:7F:8B:78 - 254799898674 Expires on:- 2025-08-12" name=\
    3A:2C:5A:7F:8B:78 password=123456 profile=12hours
add comment="72:57:F5:63:19:F8 - 254797666001 Expires on:- 2025-08-12" name=\
    72:57:F5:63:19:F8 password=123456 profile=12hours
add comment="5A:CA:FC:36:20:35 - 254724288472 Expires on:- 2025-08-12" name=\
    5A:CA:FC:36:20:35 password=123456 profile=12hours
add comment="36:98:C3:33:8D:DC - 254707517208 Expires on:- 2025-08-12" name=\
    36:98:C3:33:8D:DC password=123456 profile=12hours
add comment="8E:65:BF:7E:8A:A6 - 254799351836 Expires on:- 2025-08-12" \
    limit-uptime=1d name=8E:65:BF:7E:8A:A6 password=123456 profile=24hours
add comment="D2:B2:63:7B:8E:A2 - 254745395603 Expires on:- 2025-08-12" \
    limit-uptime=1d name=D2:B2:63:7B:8E:A2 password=123456 profile=24hours
add comment="02:46:2A:EF:4C:15 - 254111669821 Expires on:- 2025-08-12" name=\
    02:46:2A:EF:4C:15 password=123456 profile=12hours
add comment="B6:E2:7E:F2:69:33 - 254700536824 Expires on:- 2025-08-12" name=\
    B6:E2:7E:F2:69:33 password=123456 profile=12hours
add comment="CE:02:2A:EE:B2:CF - 254720681160 Expires on:- 2025-08-12" name=\
    CE:02:2A:EE:B2:CF password=123456 profile=12hours
add comment="82:CD:E5:E8:29:82 - 254745192912 Expires on:- 2025-08-12" name=\
    82:CD:E5:E8:29:82 password=123456 profile=12hours
add comment="42:8F:1C:D6:CB:13 - 254705941088 Expires on:- 2025-08-12" name=\
    42:8F:1C:D6:CB:13 password=123456 profile=12hours
add comment="FE:56:8C:B0:E4:B0 - 254790479422 Expires on:- 2025-08-12" name=\
    FE:56:8C:B0:E4:B0 password=123456 profile=12hours
add comment="10:71:FA:F6:F7:D5 - 254714457682 Expires on:- 2025-08-12" name=\
    10:71:FA:F6:F7:D5 password=123456 profile=12hours
add comment="A6:B4:95:C7:C8:7A - 254794069652 Expires on:- 2025-08-12" name=\
    A6:B4:95:C7:C8:7A password=123456 profile=12hours
add comment="7A:2E:09:D7:42:77 - 254758794737 Expires on:- 2025-08-12" name=\
    7A:2E:09:D7:42:77 password=123456 profile=12hours
add comment="5A:95:19:9F:C8:2F - 254798881538 Expires on:- 2025-08-12" name=\
    5A:95:19:9F:C8:2F password=123456 profile=12hours
add comment="9E:94:6E:4C:84:E0 - 254799659648 Expires on:- 2025-08-12" name=\
    9E:94:6E:4C:84:E0 password=123456 profile=12hours
add comment="16:E6:A6:51:B6:A7 - 254714743884 Expires on:- 2025-08-12" name=\
    16:E6:A6:51:B6:A7 password=123456 profile=12hours
add comment="58:A0:23:7A:FF:12 - 254768537010 Expires on:- 2025-08-12" name=\
    58:A0:23:7A:FF:12 password=123456 profile=12hours
add comment="96:AB:09:E5:AF:99 - 254794955508 Expires on:- 2025-08-12" name=\
    96:AB:09:E5:AF:99 password=123456 profile=12hours
add comment="E6:94:4D:D0:A0:EE - 254703704642 Expires on:- 2025-08-12" \
    limit-uptime=1d name=E6:94:4D:D0:A0:EE password=123456 profile=24hours
add comment="9E:28:22:6D:DA:61 - 254712424233 Expires on:- 2025-08-12" name=\
    9E:28:22:6D:DA:61 password=123456 profile=12hours
add comment="3E:88:2D:7C:49:27 - 254712129810 Expires on:- 2025-08-12" name=\
    3E:88:2D:7C:49:27 password=123456 profile=12hours
add comment="6E:F7:E4:3F:B3:07 - 254758644142 Expires on:- 2025-08-12" \
    limit-uptime=1d name=6E:F7:E4:3F:B3:07 password=123456 profile=24hours
add comment="D6:7A:9F:60:FB:88 - 254708504059 Expires on:- 2025-08-12" name=\
    D6:7A:9F:60:FB:88 password=123456 profile=12hours
add comment="26:AE:1E:1A:A5:26 - 254768873534 Expires on:- 2025-08-12" name=\
    26:AE:1E:1A:A5:26 password=123456 profile=12hours
add comment="62:E2:97:5C:61:D7 - 254726398089 Expires on:- 2025-08-12" name=\
    62:E2:97:5C:61:D7 password=123456 profile=12hours
add comment="96:0D:9B:D4:25:FD - 254741689007 Expires on:- 2025-08-12" name=\
    96:0D:9B:D4:25:FD password=123456 profile=12hours
add comment="2E:58:75:E7:07:6B - 254741383539 Expires on:- 2025-08-12" name=\
    2E:58:75:E7:07:6B password=123456 profile=12hours
add comment="C6:3A:1A:6C:4E:2E - 254794136639 Expires on:- 2025-08-12" name=\
    C6:3A:1A:6C:4E:2E password=123456 profile=12hours
add comment="02:CF:C1:37:EE:CB - 254721977130 Expires on:- 2025-08-12" name=\
    02:CF:C1:37:EE:CB password=123456 profile=12hours
add comment="74:C1:7D:E4:10:F8 - 254740295286 Expires on:- 2025-08-12" name=\
    74:C1:7D:E4:10:F8 password=123456 profile=12hours
add comment="EE:6F:BF:0C:FA:55 - 254721899719 Expires on:- 2025-08-12" \
    limit-uptime=1d name=EE:6F:BF:0C:FA:55 password=123456 profile=24hours
add comment="DE:9E:AC:40:65:F1 - 254722437441 Expires on:- 2025-08-12" name=\
    DE:9E:AC:40:65:F1 password=123456 profile=12hours
add comment="D6:6E:E7:49:83:75 - 254790877545 Expires on:- 2025-08-12" name=\
    D6:6E:E7:49:83:75 password=123456 profile=12hours
add comment="36:2C:12:EF:E7:29 - 254743992941 Expires on:- 2025-08-12" \
    limit-uptime=1d name=36:2C:12:EF:E7:29 password=123456 profile=24hours
add comment="6A:BD:55:2D:9B:51 - 254798975928 Expires on:- 2025-08-12" name=\
    6A:BD:55:2D:9B:51 password=123456 profile=12hours
add comment="FC:02:96:C3:B2:7E - 254720850453 Expires on:- 2025-08-12" name=\
    FC:02:96:C3:B2:7E password=123456 profile=12hours
add comment="3A:43:B2:AF:21:F6 - 254795095694 Expires on:- 2025-08-12" name=\
    3A:43:B2:AF:21:F6 password=123456 profile=12hours
add comment="C2:41:4F:AF:48:D7 - 254796533385 Expires on:- 2025-08-12" name=\
    C2:41:4F:AF:48:D7 password=123456 profile=12hours
add comment="EA:59:44:10:6E:01 - 254715616785 Expires on:- 2025-08-12" name=\
    EA:59:44:10:6E:01 password=123456 profile=12hours
add comment="32:76:78:DC:9B:6B - 254769572762 Expires on:- 2025-08-12" name=\
    32:76:78:DC:9B:6B password=123456 profile=12hours
add comment="00:22:FB:8D:50:D8 - 254715846006 Expires on:- 2025-08-12" name=\
    00:22:FB:8D:50:D8 password=123456 profile=12hours
add comment="00:10:0D:3A:AD:4F - 254111753565 Expires on:- 2025-08-12" name=\
    00:10:0D:3A:AD:4F password=123456 profile=12hours
add comment="0A:36:4C:A4:E5:99 - 254757670428 Expires on:- 2025-08-12" name=\
    0A:36:4C:A4:E5:99 password=123456 profile=12hours
add comment="46:B7:43:34:67:38 - 254742629722 Expires on:- 2025-08-12" name=\
    46:B7:43:34:67:38 password=123456 profile=12hours
add comment="7E:D4:B8:42:3D:54 - 254746008803 Expires on:- 2025-08-12" \
    limit-uptime=1d name=7E:D4:B8:42:3D:54 password=123456 profile=24hours
add comment="A0:C9:A0:97:04:9C - 254715434143 Expires on:- 2025-08-12" name=\
    A0:C9:A0:97:04:9C password=123456 profile=12hours
add comment="72:84:EB:97:F1:C8 - 254112339668 Expires on:- 2025-08-12" name=\
    72:84:EB:97:F1:C8 password=123456 profile=12hours
add comment="D6:52:72:7C:87:34 - 254117325226 Expires on:- 2025-08-12" name=\
    D6:52:72:7C:87:34 password=123456 profile=12hours
add comment="3E:BC:A4:2A:EC:DA - 254702885979 Expires on:- 2025-08-12" name=\
    3E:BC:A4:2A:EC:DA password=123456 profile=12hours
add comment="5C:D0:6E:5F:BF:83 - 254719510709 Expires on:- 2025-08-12" name=\
    5C:D0:6E:5F:BF:83 password=123456 profile=12hours
add comment="22:D7:62:6F:B7:76 - 254729836443 Expires on:- 2025-08-12" name=\
    22:D7:62:6F:B7:76 password=123456 profile=12hours
add comment="E6:A3:E1:56:AB:C3 - 254742677300 Expires on:- 2025-08-12" name=\
    E6:A3:E1:56:AB:C3 password=123456 profile=12hours
add comment="AA:51:CF:19:D8:01 - 254746169147 Expires on:- 2025-08-12" name=\
    AA:51:CF:19:D8:01 password=123456 profile=12hours
add comment="BE:FF:6E:40:59:2A - 254759260387 Expires on:- 2025-08-12" name=\
    BE:FF:6E:40:59:2A password=123456 profile=12hours
add comment="4A:3D:28:49:4F:4A - 254111976691 Expires on:- 2025-08-12" name=\
    4A:3D:28:49:4F:4A password=123456 profile=12hours
add comment="72:F7:7B:1C:03:0E - 254710710195 Expires on:- 2025-08-12" name=\
    72:F7:7B:1C:03:0E password=123456 profile=12hours
add comment="DE:94:C4:FF:D0:46 - 254708800891 Expires on:- 2025-08-12" name=\
    DE:94:C4:FF:D0:46 password=123456 profile=12hours
add comment="D6:66:10:93:4D:E5 - 254111735790 Expires on:- 2025-08-12" name=\
    D6:66:10:93:4D:E5 password=123456 profile=12hours
add comment="84:C7:EA:90:87:09 - 254796125503 Expires on:- 2025-08-12" name=\
    84:C7:EA:90:87:09 password=123456 profile=12hours
add comment="3E:48:10:16:60:FA - 254740742094 Expires on:- 2025-08-12" name=\
    3E:48:10:16:60:FA password=123456 profile=12hours
add comment="80:79:5D:25:8A:19 - 254741525394 Expires on:- 2025-08-12" name=\
    80:79:5D:25:8A:19 password=123456 profile=12hours
add comment="E2:7A:4E:2F:FD:B9 - 254116267409 Expires on:- 2025-08-12" name=\
    E2:7A:4E:2F:FD:B9 password=123456 profile=12hours
add comment="C2:C7:18:E6:69:B0 - 254723085224 Expires on:- 2025-08-12" name=\
    C2:C7:18:E6:69:B0 password=123456 profile=12hours
add comment="BE:29:7A:EA:29:F0 - 254793760974 Expires on:- 2025-08-12" name=\
    BE:29:7A:EA:29:F0 password=123456 profile=12hours
add comment="1A:64:38:39:27:FB - 254705973615 Expires on:- 2025-08-12" name=\
    1A:64:38:39:27:FB password=123456 profile=12hours
add comment="A6:CC:62:3C:B0:BD - 254715618469 Expires on:- 2025-08-12" \
    limit-uptime=1d name=A6:CC:62:3C:B0:BD password=123456 profile=24hours
add comment="5E:A5:2E:7B:5A:0D - 254748975427 Expires on:- 2025-08-12" name=\
    5E:A5:2E:7B:5A:0D password=123456 profile=12hours
add comment="5E:93:9D:E2:B7:40 - 254720582649 Expires on:- 2025-08-12" name=\
    5E:93:9D:E2:B7:40 password=123456 profile=12hours
add comment="4A:9F:B8:5D:EE:71 - 254116913771 Expires on:- 2025-08-12" name=\
    4A:9F:B8:5D:EE:71 password=123456 profile=12hours
add comment="FE:04:BE:70:10:81 - 254703200975 Expires on:- 2025-08-12" name=\
    FE:04:BE:70:10:81 password=123456 profile=12hours
add comment="78:3A:6C:7F:0F:C3 - 254758296529 Expires on:- 2025-08-12" name=\
    78:3A:6C:7F:0F:C3 password=123456 profile=12hours
add comment="CA:2E:16:C6:5A:BC - 254703816117 Expires on:- 2025-08-12" name=\
    CA:2E:16:C6:5A:BC password=123456 profile=12hours
add comment="5E:C4:17:28:E7:14 - 254703670069 Expires on:- 2025-08-12" name=\
    5E:C4:17:28:E7:14 password=123456 profile=12hours
add comment="3E:0D:8A:5A:C9:E2 - 254720932245 Expires on:- 2025-08-12" \
    limit-uptime=1d name=3E:0D:8A:5A:C9:E2 password=123456 profile=24hours
add comment="AA:75:83:B4:82:BE - 254796365161 Expires on:- 2025-08-12" name=\
    AA:75:83:B4:82:BE password=123456 profile=12hours
add comment="36:FF:A3:B5:23:52 - 254727897642 Expires on:- 2025-08-12" name=\
    36:FF:A3:B5:23:52 password=123456 profile=12hours
add comment="2E:EB:3E:1F:65:67 - 254707190917 Expires on:- 2025-08-12" name=\
    2E:EB:3E:1F:65:67 password=123456 profile=12hours
add comment="46:04:9D:68:A9:E6 - 254720504083 Expires on:- 2025-08-12" name=\
    46:04:9D:68:A9:E6 password=123456 profile=12hours
add comment="C2:94:15:E5:58:C1 - 254706619721 Expires on:- 2025-08-12" name=\
    C2:94:15:E5:58:C1 password=123456 profile=12hours
add comment="3E:44:D8:14:A2:52 - 254712422894 Expires on:- 2025-08-12" name=\
    3E:44:D8:14:A2:52 password=123456 profile=12hours
add comment="A2:8C:A2:16:97:79 - 254757808024 Expires on:- 2025-08-12" name=\
    A2:8C:A2:16:97:79 password=123456 profile=12hours
add comment="DA:FF:CC:E9:3D:3A - 254718659016 Expires on:- 2025-08-12" name=\
    DA:FF:CC:E9:3D:3A password=123456 profile=12hours
add comment="7A:76:2D:6C:11:39 - 254711571729 Expires on:- 2025-08-12" name=\
    7A:76:2D:6C:11:39 password=123456 profile=12hours
add comment="F0:79:60:28:B1:64 - 254707016749 Expires on:- 2025-08-12" name=\
    F0:79:60:28:B1:64 password=123456 profile=12hours
add comment="9A:CE:56:04:F1:BD - 254799975898 Expires on:- 2025-08-12" name=\
    9A:CE:56:04:F1:BD password=123456 profile=12hours
add comment="A6:F2:A4:3A:25:89 - 254702344714 Expires on:- 2025-08-12" name=\
    A6:F2:A4:3A:25:89 password=123456 profile=12hours
add comment="FA:F1:85:46:B1:36 - 254708637847 Expires on:- 2025-08-12" name=\
    FA:F1:85:46:B1:36 password=123456 profile=12hours
add comment="6A:17:1D:1F:0B:86 - 254723040124 Expires on:- 2025-08-12" name=\
    6A:17:1D:1F:0B:86 password=123456 profile=12hours
add comment="B6:CC:08:28:D5:58 - 254758951092 Expires on:- 2025-08-12" name=\
    B6:CC:08:28:D5:58 password=123456 profile=12hours
add comment="0A:04:70:A6:BE:23 - 254721736319 Expires on:- 2025-08-12" name=\
    0A:04:70:A6:BE:23 password=123456 profile=12hours
add comment="76:93:D0:84:7A:F9 - 254799168830 Expires on:- 2025-08-12" name=\
    76:93:D0:84:7A:F9 password=123456 profile=12hours
add comment="02:65:7A:DB:2A:EF - 254758959355 Expires on:- 2025-08-12" name=\
    02:65:7A:DB:2A:EF password=123456 profile=12hours
add comment="E2:AC:FC:1D:6E:06 - 254745391611 Expires on:- 2025-08-12" name=\
    E2:AC:FC:1D:6E:06 password=123456 profile=12hours
add comment="C6:B4:44:55:6F:1F - 254768535929 Expires on:- 2025-08-12" name=\
    C6:B4:44:55:6F:1F password=123456 profile=12hours
add comment="C2:50:AB:45:DB:81 - 254758386373 Expires on:- 2025-08-12" name=\
    C2:50:AB:45:DB:81 password=123456 profile=12hours
add comment="E2:39:CD:9C:23:4C - 254729126210 Expires on:- 2025-08-12" name=\
    E2:39:CD:9C:23:4C password=123456 profile=12hours
add comment="4A:2E:25:4B:92:FD - 254704219035 Expires on:- 2025-08-12" \
    limit-uptime=1d name=4A:2E:25:4B:92:FD password=123456 profile=24hours
add comment="E2:6D:9C:2E:68:59 - 254114203694 Expires on:- 2025-08-12" name=\
    E2:6D:9C:2E:68:59 password=123456 profile=12hours
add comment="66:D7:1B:A9:E5:CA - 254715519882 Expires on:- 2025-08-12" \
    limit-uptime=1d name=66:D7:1B:A9:E5:CA password=123456 profile=24hours
add comment="76:0B:23:B9:6F:38 - 254712585147 Expires on:- 2025-08-12" name=\
    76:0B:23:B9:6F:38 password=123456 profile=12hours
add comment="9E:7E:88:CA:6B:BC - 254727754399 Expires on:- 2025-08-12" \
    limit-uptime=1d name=9E:7E:88:CA:6B:BC password=123456 profile=24hours
add comment="76:0E:90:8B:07:EB - 254708658261 Expires on:- 2025-08-12" name=\
    76:0E:90:8B:07:EB password=123456 profile=12hours
add comment="AA:EF:BE:F0:8E:29 - 254745595542 Expires on:- 2025-08-12" name=\
    AA:EF:BE:F0:8E:29 password=123456 profile=12hours
add comment="C2:24:BC:C6:D2:70 - 254723095013 Expires on:- 2025-08-12" name=\
    C2:24:BC:C6:D2:70 password=123456 profile=12hours
add comment="9A:53:E3:35:9B:6A - 254708558962 Expires on:- 2025-08-12" name=\
    9A:53:E3:35:9B:6A password=123456 profile=12hours
add comment="12:30:63:B1:C9:AF - 254798646597 Expires on:- 2025-08-12" name=\
    12:30:63:B1:C9:AF password=123456 profile=12hours
add comment="86:F2:78:A6:C1:37 - 254713876843 Expires on:- 2025-08-12" name=\
    86:F2:78:A6:C1:37 password=123456 profile=12hours
add comment="9E:65:09:81:24:CF - 254726321282 Expires on:- 2025-08-12" name=\
    9E:65:09:81:24:CF password=123456 profile=12hours
add comment="06:31:3F:FF:7C:A2 - 254799973370 Expires on:- 2025-08-12" name=\
    06:31:3F:FF:7C:A2 password=123456 profile=12hours
add comment="DE:D7:85:63:1C:2C - 254112031399 Expires on:- 2025-08-12" name=\
    DE:D7:85:63:1C:2C password=123456 profile=12hours
add comment="40:45:DA:8C:F3:5A - 254116045333 Expires on:- 2025-08-12" name=\
    40:45:DA:8C:F3:5A password=123456 profile=12hours
add comment="62:B3:B4:E2:D6:DA - 254723480583 Expires on:- 2025-08-12" \
    limit-uptime=1d name=62:B3:B4:E2:D6:DA password=123456 profile=24hours
add comment="F6:F0:E8:29:1F:AC - 254722162686 Expires on:- 2025-08-12" \
    limit-uptime=1d name=F6:F0:E8:29:1F:AC password=123456 profile=24hours
add comment="82:B4:1F:97:36:E0 - 254712435050 Expires on:- 2025-08-12" name=\
    82:B4:1F:97:36:E0 password=123456 profile=12hours
add comment="F6:E3:CB:DC:BB:2E - 254722546680 Expires on:- 2025-08-12" name=\
    F6:E3:CB:DC:BB:2E password=123456 profile=12hours
add comment="FE:EF:35:07:37:AE - 254727109595 Expires on:- 2025-08-12" \
    limit-uptime=1d name=FE:EF:35:07:37:AE password=123456 profile=24hours
add comment="EA:4E:1C:4A:04:88 - 254704937835 Expires on:- 2025-08-12" name=\
    EA:4E:1C:4A:04:88 password=123456 profile=12hours
add comment="7E:85:87:EA:2E:5D - 254111203266 Expires on:- 2025-08-12" \
    limit-uptime=1d name=7E:85:87:EA:2E:5D password=123456 profile=24hours-
add comment="BE:0D:52:58:AF:06 - 254704717129 Expires on:- 2025-08-12" \
    limit-uptime=1d name=BE:0D:52:58:AF:06 password=123456 profile=24hours
add comment="06:FA:64:22:45:33 - 254722167252 Expires on:- 2025-08-12" name=\
    06:FA:64:22:45:33 password=123456 profile=12hours
add comment="76:17:C2:3E:DD:80 - 254720045749 Expires on:- 2025-08-12" name=\
    76:17:C2:3E:DD:80 password=123456 profile=12hours
add comment="72:1E:0A:56:68:6E - 254713581050 Expires on:- 2025-08-12" name=\
    72:1E:0A:56:68:6E password=123456 profile=12hours
add comment="3A:3F:C4:71:72:26 - 254796360811 Expires on:- 2025-08-12" name=\
    3A:3F:C4:71:72:26 password=123456 profile=12hours
add comment="3A:1B:88:C2:25:F4 - 254713564204 Expires on:- 2025-08-12" name=\
    3A:1B:88:C2:25:F4 password=123456 profile=12hours
add comment="56:37:A4:89:5B:36 - 254791999498 Expires on:- 2025-08-12" name=\
    56:37:A4:89:5B:36 password=123456 profile=12hours
add comment="00:15:0D:39:06:6B - 254704495842 Expires on:- 2025-08-12" name=\
    00:15:0D:39:06:6B password=123456 profile=12hours
add comment="7E:B5:AA:C2:BB:FB - 254746284651 Expires on:- 2025-08-12" name=\
    7E:B5:AA:C2:BB:FB password=123456 profile=12hours
add comment="4A:A9:7C:B6:BC:27 - 254745245323 Expires on:- 2025-08-12" name=\
    4A:A9:7C:B6:BC:27 password=123456 profile=12hours
add comment="92:BF:8B:D1:A3:82 - 254759201534 Expires on:- 2025-08-12" name=\
    92:BF:8B:D1:A3:82 password=123456 profile=12hours
add comment="1E:6D:F0:BE:D7:36 - 254740301457 Expires on:- 2025-08-12" name=\
    1E:6D:F0:BE:D7:36 password=123456 profile=12hours
add comment="22:81:A7:AB:88:27 - 254794868433 Expires on:- 2025-08-12" name=\
    22:81:A7:AB:88:27 password=123456 profile=12hours
add comment="9E:35:A7:00:7D:49 - 254713672664 Expires on:- 2025-08-12" name=\
    9E:35:A7:00:7D:49 password=123456 profile=12hours
add comment="7E:AE:97:DE:12:0F - 254708696631 Expires on:- 2025-08-12" name=\
    7E:AE:97:DE:12:0F password=123456 profile=12hours
add comment="20:19:0D:39:0A:E8 - 254725349386 Expires on:- 2025-08-12" name=\
    20:19:0D:39:0A:E8 password=123456 profile=12hours
add comment="A8:41:F4:8E:E2:13 - 254722384953 Expires on:- 2025-08-12" name=\
    A8:41:F4:8E:E2:13 password=123456 profile=12hours
add comment="2E:47:F7:D3:DA:8A - 254707772083 Expires on:- 2025-08-12" name=\
    2E:47:F7:D3:DA:8A password=123456 profile=12hours
add comment="E6:BF:2F:9A:5B:F0 - 254115515524 Expires on:- 2025-08-12" name=\
    E6:BF:2F:9A:5B:F0 password=123456 profile=12hours
add comment="AE:F4:86:2C:88:73 - 254757666535 Expires on:- 2025-08-12" name=\
    AE:F4:86:2C:88:73 password=123456 profile=12hours
add comment="E2:47:5E:6B:13:34 - 254742094393 Expires on:- 2025-08-12" name=\
    E2:47:5E:6B:13:34 password=123456 profile=12hours
add comment="EA:8B:39:ED:6D:D3 - 254746311475 Expires on:- 2025-08-12" name=\
    EA:8B:39:ED:6D:D3 password=123456 profile=12hours
add comment="4E:CD:29:DF:CE:FE - 254799926200 Expires on:- 2025-08-12" name=\
    4E:CD:29:DF:CE:FE password=123456 profile=12hours
add comment="96:4F:82:E3:B9:44 - 254712062546 Expires on:- 2025-08-12" name=\
    96:4F:82:E3:B9:44 password=123456 profile=12hours
add comment="9A:8A:24:E2:E0:29 - 254745488870 Expires on:- 2025-08-12" name=\
    9A:8A:24:E2:E0:29 password=123456 profile=12hours
add comment="2E:67:10:D2:FB:28 - 254742364003 Expires on:- 2025-08-12" name=\
    2E:67:10:D2:FB:28 password=123456 profile=12hours
add comment="D6:DD:21:46:20:0B - 254702326929 Expires on:- 2025-08-12" name=\
    D6:DD:21:46:20:0B password=123456 profile=12hours
add comment="CE:84:D5:2E:D4:F3 - 254719277256 Expires on:- 2025-08-12" name=\
    CE:84:D5:2E:D4:F3 password=123456 profile=12hours
add comment="7E:A3:19:CA:D9:31 - 254721416378 Expires on:- 2025-08-12" name=\
    7E:A3:19:CA:D9:31 password=123456 profile=12hours
add comment="8E:12:B2:74:A4:30 - 254713053754 Expires on:- 2025-08-12" \
    limit-uptime=1d name=8E:12:B2:74:A4:30 password=123456 profile=24hours
add comment="26:D1:F7:EE:DC:85 - 254700567644 Expires on:- 2025-08-12" name=\
    26:D1:F7:EE:DC:85 password=123456 profile=12hours
add comment="B2:9F:79:16:0D:74 - 254724946433 Expires on:- 2025-08-12" name=\
    B2:9F:79:16:0D:74 password=123456 profile=12hours
add comment="86:85:C7:45:39:26 - 254790759663 Expires on:- 2025-08-12" name=\
    86:85:C7:45:39:26 password=123456 profile=12hours
add comment="3A:86:B5:C1:A6:E4 - 254704617819 Expires on:- 2025-08-12" name=\
    3A:86:B5:C1:A6:E4 password=123456 profile=12hours
add comment="9E:24:D8:3C:98:E3 - 254768207885 Expires on:- 2025-08-12" name=\
    9E:24:D8:3C:98:E3 password=123456 profile=12hours
add comment="92:07:0B:06:07:47 - 254724697033 Expires on:- 2025-08-12" name=\
    92:07:0B:06:07:47 password=123456 profile=12hours
add comment="66:7F:24:F5:CB:93 - 254722602832 Expires on:- 2025-08-12" name=\
    66:7F:24:F5:CB:93 password=123456 profile=12hours
add comment="82:CC:A5:09:3C:55 - 254793595815 Expires on:- 2025-08-12" name=\
    82:CC:A5:09:3C:55 password=123456 profile=12hours
add comment="FA:EF:2D:CA:03:23 - 254707657188 Expires on:- 2025-08-12" name=\
    FA:EF:2D:CA:03:23 password=123456 profile=12hours
add comment="8E:F9:9D:85:7E:00 - 254792510770 Expires on:- 2025-08-12" name=\
    8E:F9:9D:85:7E:00 password=123456 profile=12hours
add comment="6A:2F:CA:59:E1:F0 - 254726584388 Expires on:- 2025-08-12" name=\
    6A:2F:CA:59:E1:F0 password=123456 profile=12hours
add comment="A6:EB:51:07:8B:6C - 254729822101 Expires on:- 2025-08-12" name=\
    A6:EB:51:07:8B:6C password=123456 profile=12hours
add comment="C6:A9:19:F1:43:ED - 254712169403 Expires on:- 2025-08-12" name=\
    C6:A9:19:F1:43:ED password=123456 profile=12hours
add comment="32:FA:53:88:6B:CE - 254712029604 Expires on:- 2025-08-12" name=\
    32:FA:53:88:6B:CE password=123456 profile=12hours
add comment="E2:D2:F6:F5:88:42 - 254716256514 Expires on:- 2025-08-12" \
    limit-uptime=1d name=E2:D2:F6:F5:88:42 password=123456 profile=24hours
add comment="0E:53:92:03:2C:EC - 254705842844 Expires on:- 2025-08-12" name=\
    0E:53:92:03:2C:EC password=123456 profile=12hours
add comment="3E:5C:AA:76:30:B3 - 254741585005 Expires on:- 2025-08-12" name=\
    3E:5C:AA:76:30:B3 password=123456 profile=12hours
add comment="32:EB:46:A9:F1:6F - 254745832497 Expires on:- 2025-08-12" name=\
    32:EB:46:A9:F1:6F password=123456 profile=12hours
add comment="A2:94:45:B3:FF:0A - 254719531930 Expires on:- 2025-08-12" name=\
    A2:94:45:B3:FF:0A password=123456 profile=12hours
add comment="FA:C8:F7:76:3C:D0 - 254743801928 Expires on:- 2025-08-12" name=\
    FA:C8:F7:76:3C:D0 password=123456 profile=12hours
add comment="4A:F2:77:02:54:A1 - 254711310893 Expires on:- 2025-08-12" name=\
    4A:F2:77:02:54:A1 password=123456 profile=12hours
add comment="86:CB:1F:E2:EC:09 - 254113438389 Expires on:- 2025-08-12" name=\
    86:CB:1F:E2:EC:09 password=123456 profile=12hours
add comment="DE:36:4B:87:8B:1C - 254114677378 Expires on:- 2025-08-12" name=\
    DE:36:4B:87:8B:1C password=123456 profile=12hours
add comment="5E:11:2B:89:49:20 - 254740362805 Expires on:- 2025-08-12" name=\
    5E:11:2B:89:49:20 password=123456 profile=12hours
add comment="1E:07:8D:82:62:66 - 254712790342 Expires on:- 2025-08-12" name=\
    1E:07:8D:82:62:66 password=123456 profile=12hours
add comment="5A:5D:DE:1E:74:48 - 254707187919 Expires on:- 2025-08-12" name=\
    5A:5D:DE:1E:74:48 password=123456 profile=12hours
add comment="B2:87:D8:8D:86:A9 - 254769026762 Expires on:- 2025-08-12" name=\
    B2:87:D8:8D:86:A9 password=123456 profile=12hours
add comment="9E:22:5E:52:63:A3 - 254713489757 Expires on:- 2025-08-12" name=\
    9E:22:5E:52:63:A3 password=123456 profile=12hours
add comment="AA:60:F5:15:84:B0 - 254720358493 Expires on:- 2025-08-12" name=\
    AA:60:F5:15:84:B0 password=123456 profile=12hours
add comment="2E:E1:DB:A6:CE:F3 - 254715965227 Expires on:- 2025-08-12" name=\
    2E:E1:DB:A6:CE:F3 password=123456 profile=12hours
add comment="78:3A:6C:4E:73:1F - 254794869683 Expires on:- 2025-08-12" name=\
    78:3A:6C:4E:73:1F password=123456 profile=12hours
add comment="46:F0:DF:A3:34:9E - 254791386706 Expires on:- 2025-08-12" name=\
    46:F0:DF:A3:34:9E password=123456 profile=12hours
add comment="66:CD:C6:1B:8A:72 - 254710347415 Expires on:- 2025-08-12" name=\
    66:CD:C6:1B:8A:72 password=123456 profile=12hours
add comment="C8:C2:FA:27:95:B3 - 254721161941 Expires on:- 2025-08-12" name=\
    C8:C2:FA:27:95:B3 password=123456 profile=12hours
add comment="22:EB:05:B4:85:74 - 254712212046 Expires on:- 2025-08-12" name=\
    22:EB:05:B4:85:74 password=123456 profile=12hours
add comment="62:AA:2D:E7:F1:29 - 254794237424 Expires on:- 2025-08-12" name=\
    62:AA:2D:E7:F1:29 password=123456 profile=12hours
add comment="A2:DE:83:E7:3F:B1 - 254791247079 Expires on:- 2025-08-12" name=\
    A2:DE:83:E7:3F:B1 password=123456 profile=12hours
add comment="E2:DC:1E:E3:35:91 - 254707825614 Expires on:- 2025-08-12" name=\
    E2:DC:1E:E3:35:91 password=123456 profile=12hours
add comment="9C:A5:13:C9:AE:97 - 254769343183 Expires on:- 2025-08-12" name=\
    9C:A5:13:C9:AE:97 password=123456 profile=12hours
add comment="C6:1B:21:AF:B8:FE - 254711562572 Expires on:- 2025-08-12" name=\
    C6:1B:21:AF:B8:FE password=123456 profile=12hours
add comment="AE:EE:29:B6:75:41 - 254757759330 Expires on:- 2025-08-12" name=\
    AE:EE:29:B6:75:41 password=123456 profile=12hours
add comment="F0:6C:5D:50:E3:4E - 254706619355 Expires on:- 2025-08-12" name=\
    F0:6C:5D:50:E3:4E password=123456 profile=12hours
add comment="D2:11:AB:4C:94:26 - 254710347415 Expires on:- 2025-08-12" name=\
    D2:11:AB:4C:94:26 password=123456 profile=12hours
add comment="EA:E7:2D:46:9F:D8 - 254112065434 Expires on:- 2025-08-12" name=\
    EA:E7:2D:46:9F:D8 password=123456 profile=12hours
add comment="56:C4:D4:D5:7F:78 - 254742186095 Expires on:- 2025-08-12" name=\
    56:C4:D4:D5:7F:78 password=123456 profile=12hours
add comment="92:17:71:FC:BF:D4 - 254720502510 Expires on:- 2025-08-12" name=\
    92:17:71:FC:BF:D4 password=123456 profile=12hours
add comment="7E:3B:6B:22:8D:D6 - 254790289091 Expires on:- 2025-08-12" \
    limit-uptime=1d name=7E:3B:6B:22:8D:D6 password=123456 profile=24hours
add comment="36:E8:C2:7D:AE:A2 - 254117003905 Expires on:- 2025-08-12" name=\
    36:E8:C2:7D:AE:A2 password=123456 profile=12hours
add comment="52:10:28:C2:A0:15 - 254712449772 Expires on:- 2025-08-12" \
    limit-uptime=1d name=52:10:28:C2:A0:15 password=123456 profile=24hours
add comment="4A:E0:3B:F6:FA:6D - 254110730819 Expires on:- 2025-08-12" name=\
    4A:E0:3B:F6:FA:6D password=123456 profile=12hours
add comment="6A:25:4E:71:5E:39 - 254759591394 Expires on:- 2025-08-12" name=\
    6A:25:4E:71:5E:39 password=123456 profile=12hours
add comment="6E:E9:D6:39:36:6D - 254746893922 Expires on:- 2025-08-12" name=\
    6E:E9:D6:39:36:6D password=123456 profile=12hours
add comment="AE:EA:77:E9:4A:1D - 254742366750 Expires on:- 2025-08-12" name=\
    AE:EA:77:E9:4A:1D password=123456 profile=12hours
add comment="04:95:E6:23:F1:30 - 254720216706 Expires on:- 2025-08-12" \
    limit-uptime=1d name=04:95:E6:23:F1:30 password=123456 profile=24hours
add comment="AC:83:F3:50:67:12 - 254713049419 Expires on:- 2025-08-12" name=\
    AC:83:F3:50:67:12 password=123456 profile=12hours
add comment="C2:A8:84:48:4E:EA - 254702798611 Expires on:- 2025-08-12" \
    limit-uptime=1d name=C2:A8:84:48:4E:EA password=123456 profile=24hours
add comment="F6:0B:BD:12:1E:16 - 254799664094 Expires on:- 2025-08-12" name=\
    F6:0B:BD:12:1E:16 password=123456 profile=12hours
add comment="EA:F1:82:82:E1:94 - 254745752603 Expires on:- 2025-08-12" name=\
    EA:F1:82:82:E1:94 password=123456 profile=12hours
add comment="1E:7A:97:69:02:1C - 254722936146 Expires on:- 2025-08-12" name=\
    1E:7A:97:69:02:1C password=123456 profile=12hours
add comment="F6:75:29:89:8E:85 - 254116888633 Expires on:- 2025-08-12" name=\
    F6:75:29:89:8E:85 password=123456 profile=12hours
add comment="5E:E4:ED:49:52:5E - 254719720943 Expires on:- 2025-08-12" name=\
    5E:E4:ED:49:52:5E password=123456 profile=12hours
add comment="66:CA:51:B1:BD:94 - 254116593641 Expires on:- 2025-08-12" \
    limit-uptime=1d name=66:CA:51:B1:BD:94 password=123456 profile=24hours
add comment="E2:1F:85:74:4B:12 - 254798323585 Expires on:- 2025-08-12" name=\
    E2:1F:85:74:4B:12 password=123456 profile=12hours
add comment="6E:E2:21:EA:BE:A7 - 254715313681 Expires on:- 2025-08-12" name=\
    6E:E2:21:EA:BE:A7 password=123456 profile=12hours
add comment="A2:B3:E1:92:A9:E5 - 254115128636 Expires on:- 2025-08-12" name=\
    A2:B3:E1:92:A9:E5 password=123456 profile=12hours
add comment="BA:9F:D0:FF:46:85 - 254743212337 Expires on:- 2025-08-12" name=\
    BA:9F:D0:FF:46:85 password=123456 profile=12hours
add comment="C6:3E:38:8F:DA:A4 - 254795588568 Expires on:- 2025-08-12" name=\
    C6:3E:38:8F:DA:A4 password=123456 profile=12hours
add comment="EE:BB:F0:4F:F0:79 - 254717234173 Expires on:- 2025-08-12" name=\
    EE:BB:F0:4F:F0:79 password=123456 profile=12hours
add comment="EA:20:D2:0C:E0:00 - 254728305776 Expires on:- 2025-08-12" name=\
    EA:20:D2:0C:E0:00 password=123456 profile=12hours
add comment="B6:41:21:0A:0D:51 - 254745313318 Expires on:- 2025-08-12" name=\
    B6:41:21:0A:0D:51 password=123456 profile=12hours
add comment="46:9E:BD:78:C6:A8 - 254705729156 Expires on:- 2025-08-12" \
    limit-uptime=1d name=46:9E:BD:78:C6:A8 password=123456 profile=24hours
add comment="54:92:09:B1:CC:58 - 254711425316 Expires on:- 2025-08-12" name=\
    54:92:09:B1:CC:58 password=123456 profile=12hours
add comment="80:79:5D:EE:FA:ED - 254704448444 Expires on:- 2025-08-12" name=\
    80:79:5D:EE:FA:ED password=123456 profile=12hours
add comment="32:32:21:CB:AD:64 - 254748151887 Expires on:- 2025-08-12" name=\
    32:32:21:CB:AD:64 password=123456 profile=12hours
add comment="9E:EC:A1:1E:1C:24 - 254769638870 Expires on:- 2025-08-12" name=\
    9E:EC:A1:1E:1C:24 password=123456 profile=12hours
add comment="06:D6:1A:7F:1D:67 - 254705239231 Expires on:- 2025-08-12" name=\
    06:D6:1A:7F:1D:67 password=123456 profile=12hours
add comment="6E:5D:D2:ED:7D:9F - 254721649726 Expires on:- 2025-08-12" name=\
    6E:5D:D2:ED:7D:9F password=123456 profile=12hours
add comment="D6:81:35:A0:62:52 - 254768034300 Expires on:- 2025-08-12" name=\
    D6:81:35:A0:62:52 password=123456 profile=12hours
add comment="56:87:7D:60:59:8D - 254796351068 Expires on:- 2025-08-12" name=\
    56:87:7D:60:59:8D password=123456 profile=12hours
add comment="C2:7A:F9:3A:55:0D - 254795806446 Expires on:- 2025-08-12" name=\
    C2:7A:F9:3A:55:0D password=123456 profile=12hours
add comment="CC:C0:79:73:6C:C9 - 254714558510 Expires on:- 2025-08-12" name=\
    CC:C0:79:73:6C:C9 password=123456 profile=12hours
add comment="7A:2E:60:68:B1:71 - 254724956722 Expires on:- 2025-08-12" name=\
    7A:2E:60:68:B1:71 password=123456 profile=12hours
add comment="9E:6B:F0:D0:78:74 - 254718282326 Expires on:- 2025-08-12" name=\
    9E:6B:F0:D0:78:74 password=123456 profile=12hours
add comment="DE:39:0E:5C:BF:B8 - 254723290803 Expires on:- 2025-08-12" name=\
    DE:39:0E:5C:BF:B8 password=123456 profile=12hours
add comment="6A:B9:93:F7:EA:34 - 254796519574 Expires on:- 2025-08-12" name=\
    6A:B9:93:F7:EA:34 password=123456 profile=12hours
add comment="8A:EB:66:BA:EE:F3 - 254700366798 Expires on:- 2025-08-12" name=\
    8A:EB:66:BA:EE:F3 password=123456 profile=12hours
add comment="DA:29:06:F1:9D:72 - 254721971362 Expires on:- 2025-08-12" name=\
    DA:29:06:F1:9D:72 password=123456 profile=12hours
add comment="8E:95:94:7B:0C:9C - 254795513090 Expires on:- 2025-08-12" name=\
    8E:95:94:7B:0C:9C password=123456 profile=12hours
add comment="E6:7E:91:DC:EA:1C - 254716495719 Expires on:- 2025-08-12" name=\
    E6:7E:91:DC:EA:1C password=123456 profile=12hours
add comment="A2:C6:37:FD:98:BC - 254722384953 Expires on:- 2025-08-12" name=\
    A2:C6:37:FD:98:BC password=123456 profile=12hours
add comment="BE:DD:C8:27:3F:69 - 254723964448 Expires on:- 2025-08-12" name=\
    BE:DD:C8:27:3F:69 password=123456 profile=12hours
add comment="02:03:FC:A7:3B:B7 - 254112090228 Expires on:- 2025-08-12" name=\
    02:03:FC:A7:3B:B7 password=123456 profile=12hours
add comment="22:AD:D5:F7:F6:45 - 254745769605 Expires on:- 2025-08-12" name=\
    22:AD:D5:F7:F6:45 password=123456 profile=12hours
add comment="3A:72:29:1D:9F:AF - 254724434247 Expires on:- 2025-08-12" name=\
    3A:72:29:1D:9F:AF password=123456 profile=12hours
add comment="FE:3F:05:15:A1:90 - 254742501743 Expires on:- 2025-08-12" name=\
    FE:3F:05:15:A1:90 password=123456 profile=12hours
add comment="EE:30:1F:44:25:38 - 254715551898 Expires on:- 2025-08-12" name=\
    EE:30:1F:44:25:38 password=123456 profile=12hours
add comment="E6:36:05:31:56:C0 - 254743651744 Expires on:- 2025-08-12" name=\
    E6:36:05:31:56:C0 password=123456 profile=12hours
add comment="C6:70:B0:BB:0A:9E - 254793530556 Expires on:- 2025-08-12" name=\
    C6:70:B0:BB:0A:9E password=123456 profile=12hours
add comment="FA:60:ED:95:1C:0F - 254724326259 Expires on:- 2025-08-12" name=\
    FA:60:ED:95:1C:0F password=123456 profile=12hours
add comment="8E:AE:50:A1:3F:5D - 254716495719 Expires on:- 2025-08-12" name=\
    8E:AE:50:A1:3F:5D password=123456 profile=12hours
add comment="FE:4E:2C:0B:86:BC - 254713905602 Expires on:- 2025-08-12" name=\
    FE:4E:2C:0B:86:BC password=123456 profile=12hours
add comment="AC:2D:A9:5B:E8:39 - 254757154817 Expires on:- 2025-08-12" name=\
    AC:2D:A9:5B:E8:39 password=123456 profile=12hours
add comment="C6:D6:97:BA:FF:13 - 254792937634 Expires on:- 2025-08-12" name=\
    C6:D6:97:BA:FF:13 password=123456 profile=12hours
add comment="DA:65:AE:A3:7A:46 - 254724061852 Expires on:- 2025-08-12" name=\
    DA:65:AE:A3:7A:46 password=123456 profile=12hours
add comment="AE:E8:2E:D3:B5:EA - 254706027804 Expires on:- 2025-08-12" name=\
    AE:E8:2E:D3:B5:EA password=123456 profile=12hours
add comment="2A:39:EA:A2:46:AF - 254799976442 Expires on:- 2025-08-12" name=\
    2A:39:EA:A2:46:AF password=123456 profile=12hours
add comment="0A:42:EB:81:5A:B9 - 254748648418 Expires on:- 2025-08-12" name=\
    0A:42:EB:81:5A:B9 password=123456 profile=12hours
add comment="42:8E:93:C6:2E:E1 - 254726075713 Expires on:- 2025-08-12" \
    limit-uptime=1d name=42:8E:93:C6:2E:E1 password=123456 profile=24hours
add comment="06:2B:65:F8:2B:45 - 254704452792 Expires on:- 2025-08-12" name=\
    06:2B:65:F8:2B:45 password=123456 profile=12hours
add comment="EE:32:83:F3:BA:D5 - 254799069099 Expires on:- 2025-08-12" name=\
    EE:32:83:F3:BA:D5 password=123456 profile=12hours
add comment=" - 254722289979 Expires on:- 2025-08-12" name=E6:46:D7:2B:AC:8A \
    password=123456 profile=12hours
add comment=" - 254701054353 Expires on:- 2025-08-12" name=A2:2D:12:82:0A:5F \
    password=123456 profile=12hours
add comment="B6:FF:F6:85:1F:78 - 254706876597 Expires on:- 2025-08-12" \
    limit-uptime=1d name=B6:FF:F6:85:1F:78 password=123456 profile=24hours
add comment="42:B6:A7:E4:54:2D - 254794856004 Expires on:- 2025-08-12" name=\
    42:B6:A7:E4:54:2D password=123456 profile=12hours
add comment="EE:10:EF:37:D1:32 - 254794770532 Expires on:- 2025-08-12" name=\
    EE:10:EF:37:D1:32 password=123456 profile=12hours
add comment="62:7F:AB:03:BE:D4 - 254112065434 Expires on:- 2025-08-12" name=\
    62:7F:AB:03:BE:D4 password=123456 profile=12hours
add comment="5A:13:95:57:EE:C0 - 254791171945 Expires on:- 2025-08-12" name=\
    5A:13:95:57:EE:C0 password=123456 profile=12hours
add comment="D4:98:B9:32:42:5C - 254722716965 Expires on:- 2025-08-12" name=\
    D4:98:B9:32:42:5C password=123456 profile=12hours
add comment="EA:7A:5D:26:3C:A5 - 254716062831 Expires on:- 2025-08-12" name=\
    EA:7A:5D:26:3C:A5 password=123456 profile=12hours
add comment="3E:57:31:B5:C5:B8 - 254741754968 Expires on:- 2025-08-12" name=\
    3E:57:31:B5:C5:B8 password=123456 profile=12hours
add comment="AE:0B:73:3B:2A:60 - 254712640842 Expires on:- 2025-08-12" name=\
    AE:0B:73:3B:2A:60 password=123456 profile=12hours
add comment="30:07:4D:B3:CC:85 - 254721729426 Expires on:- 2025-08-12" \
    limit-uptime=1d name=30:07:4D:B3:CC:85 password=123456 profile=24hours
add comment="26:58:57:8B:92:95 - 254703491996 Expires on:- 2025-08-12" name=\
    26:58:57:8B:92:95 password=123456 profile=12hours
add comment="1A:C5:9C:9F:24:EE - 254117707798 Expires on:- 2025-08-12" name=\
    1A:C5:9C:9F:24:EE password=123456 profile=12hours
add comment="12:5C:B0:8C:07:2C - 254702326929 Expires on:- 2025-08-12" name=\
    12:5C:B0:8C:07:2C password=123456 profile=12hours
add comment="8A:05:32:28:E5:44 - 254797281894 Expires on:- 2025-08-12" name=\
    8A:05:32:28:E5:44 password=123456 profile=12hours
add comment="6E:18:3A:09:FB:D2 - 254746562209 Expires on:- 2025-08-12" name=\
    6E:18:3A:09:FB:D2 password=123456 profile=12hours
add comment="D2:B2:FD:2F:EE:A4 - 254748332421 Expires on:- 2025-08-12" name=\
    D2:B2:FD:2F:EE:A4 password=123456 profile=12hours
add comment="4A:9C:67:D4:06:5C - 254700686483 Expires on:- 2025-08-12" name=\
    4A:9C:67:D4:06:5C password=123456 profile=12hours
add comment="62:02:58:99:38:F0 - 254714963108 Expires on:- 2025-08-12" name=\
    62:02:58:99:38:F0 password=123456 profile=12hours
add comment="E6:61:ED:8E:06:6F - 254757062122 Expires on:- 2025-08-12" name=\
    E6:61:ED:8E:06:6F password=123456 profile=12hours
add comment="DA:DD:BA:71:D3:BC - 254724207166 Expires on:- 2025-08-12" \
    limit-uptime=1d name=DA:DD:BA:71:D3:BC password=123456 profile=24hours
add comment="E6:2C:E1:97:8F:B7 - 254757350206 Expires on:- 2025-08-12" name=\
    E6:2C:E1:97:8F:B7 password=123456 profile=12hours
add comment="6E:C1:6E:CC:B2:66 - 254722294753 Expires on:- 2025-08-12" name=\
    6E:C1:6E:CC:B2:66 password=123456 profile=12hours
add comment="06:12:34:5F:49:41 - 254718883587 Expires on:- 2025-08-12" name=\
    06:12:34:5F:49:41 password=123456 profile=12hours
add comment="BA:96:9B:46:93:93 - 254742060781 Expires on:- 2025-08-12" name=\
    BA:96:9B:46:93:93 password=123456 profile=12hours
add comment="0E:FE:F3:FF:F9:96 - 254714524933 Expires on:- 2025-08-12" name=\
    0E:FE:F3:FF:F9:96 password=123456 profile=12hours
add comment="32:E5:14:1A:7F:67 - 254726270886 Expires on:- 2025-08-12" name=\
    32:E5:14:1A:7F:67 password=123456 profile=12hours
add comment="9E:DD:CF:4F:B2:6E - 254115744836 Expires on:- 2025-08-12" name=\
    9E:DD:CF:4F:B2:6E password=123456 profile=12hours
add comment="1A:EE:DD:36:EE:FA - 254768758431 Expires on:- 2025-08-12" name=\
    1A:EE:DD:36:EE:FA password=123456 profile=12hours
add comment="22:AE:E3:7F:93:17 - 254116272026 Expires on:- 2025-08-12" \
    limit-uptime=1d name=22:AE:E3:7F:93:17 password=123456 profile=24hours
add comment="72:15:08:A2:48:6A - 254748907231 Expires on:- 2025-08-12" name=\
    72:15:08:A2:48:6A password=123456 profile=12hours
add comment=" - 254790736087 Expires on:- 2025-08-12" name=AE:20:E1:03:1D:F0 \
    password=123456 profile=12hours
add comment="FE:BF:B6:D1:07:36 - 254717623263 Expires on:- 2025-08-12" name=\
    FE:BF:B6:D1:07:36 password=123456 profile=12hours
add comment="9E:50:D2:17:35:98 - 254758788254 Expires on:- 2025-08-12" name=\
    9E:50:D2:17:35:98 password=123456 profile=12hours
add comment="8E:49:B2:D1:B3:9B - 254742623608 Expires on:- 2025-08-12" name=\
    8E:49:B2:D1:B3:9B password=123456 profile=12hours
add comment="56:D9:B3:23:B7:58 - 254726336868 Expires on:- 2025-08-12" name=\
    56:D9:B3:23:B7:58 password=123456 profile=12hours
add comment="66:ED:61:86:99:DA - 254115114667 Expires on:- 2025-08-12" name=\
    66:ED:61:86:99:DA password=123456 profile=12hours
add comment="0E:F4:7C:D9:F8:50 - 254768628300 Expires on:- 2025-08-12" name=\
    0E:F4:7C:D9:F8:50 password=123456 profile=12hours
add comment="02:08:F0:D3:CE:93 - 254799271679 Expires on:- 2025-08-12" name=\
    02:08:F0:D3:CE:93 password=123456 profile=12hours
add comment="2E:6B:D0:0B:78:6E - 254725434526 Expires on:- 2025-08-12" name=\
    2E:6B:D0:0B:78:6E password=123456 profile=12hours
add comment="9E:E3:6F:33:00:6E - 254704959230 Expires on:- 2025-08-12" name=\
    9E:E3:6F:33:00:6E password=123456 profile=12hours
add comment="DE:81:36:E5:41:FD - 254757467225 Expires on:- 2025-08-12" name=\
    DE:81:36:E5:41:FD password=123456 profile=12hours
add comment="9E:CC:C8:01:71:B6 - 254113095492 Expires on:- 2025-08-12" name=\
    9E:CC:C8:01:71:B6 password=123456 profile=12hours
add comment="FA:0A:95:B5:CB:FC - 254790056224 Expires on:- 2025-08-12" name=\
    FA:0A:95:B5:CB:FC password=123456 profile=12hours
add comment="06:01:6F:1F:58:A5 - 254707987174 Expires on:- 2025-08-12" name=\
    06:01:6F:1F:58:A5 password=123456 profile=12hours
add comment="EA:4F:30:55:E5:5C - 254790044734 Expires on:- 2025-08-12" \
    limit-uptime=1d name=EA:4F:30:55:E5:5C password=123456 profile=24hours
add comment="1A:16:5D:92:91:E4 - 254116653399 Expires on:- 2025-08-12" name=\
    1A:16:5D:92:91:E4 password=123456 profile=12hours
add comment="56:E7:73:05:F3:92 - 254115350893 Expires on:- 2025-08-12" name=\
    56:E7:73:05:F3:92 password=123456 profile=12hours
add comment="7A:54:99:47:DF:C4 - 254768093616 Expires on:- 2025-08-12" name=\
    7A:54:99:47:DF:C4 password=123456 profile=12hours
add comment="14:D1:69:71:C3:1A - 254798929473 Expires on:- 2025-08-12" name=\
    14:D1:69:71:C3:1A password=123456 profile=12hours
add comment="4E:9C:3E:FC:41:CC - 254704217748 Expires on:- 2025-08-12" name=\
    4E:9C:3E:FC:41:CC password=123456 profile=12hours
add comment="6E:C5:07:39:36:17 - 254798202635 Expires on:- 2025-08-12" name=\
    6E:C5:07:39:36:17 password=123456 profile=12hours
add comment="A0:CC:2B:12:86:9E - 254790780364 Expires on:- 2025-08-12" name=\
    A0:CC:2B:12:86:9E password=123456 profile=12hours
add comment="62:40:D0:27:B9:EC - 254724244835 Expires on:- 2025-08-12" name=\
    62:40:D0:27:B9:EC password=123456 profile=12hours
add comment="56:CC:C6:18:1C:B1 - 254703574039 Expires on:- 2025-08-12" name=\
    56:CC:C6:18:1C:B1 password=123456 profile=12hours
add comment="9E:36:30:28:5F:26 - 254712714152 Expires on:- 2025-08-12" name=\
    9E:36:30:28:5F:26 password=123456 profile=12hours
add comment="16:6E:4D:AA:51:BC - 254793257872 Expires on:- 2025-08-12" name=\
    16:6E:4D:AA:51:BC password=123456 profile=12hours
add comment="06:48:36:8C:E9:0B - 254727713341 Expires on:- 2025-08-12" name=\
    06:48:36:8C:E9:0B password=123456 profile=12hours
add comment="46:F0:56:BE:5D:48 - 254740134721 Expires on:- 2025-08-12" name=\
    46:F0:56:BE:5D:48 password=123456 profile=12hours
add comment="DA:43:6C:83:B0:8C - 254798725669 Expires on:- 2025-08-12" name=\
    DA:43:6C:83:B0:8C password=123456 profile=12hours
add comment="56:6C:0B:06:08:C2 - 254769984588 Expires on:- 2025-08-12" name=\
    56:6C:0B:06:08:C2 password=123456 profile=12hours
add comment="B2:9F:C9:02:18:6E - 254746973450 Expires on:- 2025-08-12" name=\
    B2:9F:C9:02:18:6E password=123456 profile=12hours
add comment="76:11:A8:6B:07:57 - 254746123516 Expires on:- 2025-08-12" name=\
    76:11:A8:6B:07:57 password=123456 profile=12hours
add comment="D6:F1:7C:E7:61:D7 - 254729803365 Expires on:- 2025-08-12" name=\
    D6:F1:7C:E7:61:D7 password=123456 profile=12hours
add comment="82:64:12:0F:F2:17 - 254716586970 Expires on:- 2025-08-12" name=\
    82:64:12:0F:F2:17 password=123456 profile=12hours
add comment="46:7B:A8:6F:8A:D1 - 254799527253 Expires on:- 2025-08-12" name=\
    46:7B:A8:6F:8A:D1 password=123456 profile=12hours
add comment="4A:BE:71:AF:93:EB - 254113737835 Expires on:- 2025-08-12" name=\
    4A:BE:71:AF:93:EB password=123456 profile=12hours
add comment="1E:E9:20:46:D8:6D - 254713565317 Expires on:- 2025-08-12" name=\
    1E:E9:20:46:D8:6D password=123456 profile=12hours
add comment="82:EC:2D:5B:0C:29 - 254710949352 Expires on:- 2025-08-12" name=\
    82:EC:2D:5B:0C:29 password=123456 profile=12hours
add comment="46:95:E2:99:F0:4A - 254790758172 Expires on:- 2025-08-12" \
    limit-uptime=1d name=46:95:E2:99:F0:4A password=123456 profile=24hours
add comment="5A:77:CD:44:4F:3B - 254742830489 Expires on:- 2025-08-12" name=\
    5A:77:CD:44:4F:3B password=123456 profile=12hours
add comment="9E:7A:23:B0:31:E9 - 254704496074 Expires on:- 2025-08-12" name=\
    9E:7A:23:B0:31:E9 password=123456 profile=12hours
add comment="6A:50:33:F2:36:B6 - 254743746167 Expires on:- 2025-08-12" name=\
    6A:50:33:F2:36:B6 password=123456 profile=12hours
add comment="56:F8:40:9A:E6:E3 - 254700367673 Expires on:- 2025-08-12" name=\
    56:F8:40:9A:E6:E3 password=123456 profile=12hours
add comment="EE:00:85:83:AB:76 - 254115230010 Expires on:- 2025-08-12" name=\
    EE:00:85:83:AB:76 password=123456 profile=12hours
add comment="EA:89:B3:D8:58:0C - 254723523833 Expires on:- 2025-08-12" name=\
    EA:89:B3:D8:58:0C password=123456 profile=12hours
add comment="0E:2B:71:C0:26:F8 - 254705970351 Expires on:- 2025-08-12" name=\
    0E:2B:71:C0:26:F8 password=123456 profile=12hours
add comment="DA:70:B6:5A:06:94 - 254757280826 Expires on:- 2025-08-12" name=\
    DA:70:B6:5A:06:94 password=123456 profile=12hours
add comment="B2:9D:A1:2C:07:AE - 254722660094 Expires on:- 2025-08-12" \
    limit-uptime=1d name=B2:9D:A1:2C:07:AE password=123456 profile=24hours
add comment="DA:42:C6:A5:65:BE - 254743183802 Expires on:- 2025-08-12" \
    limit-uptime=1d name=DA:42:C6:A5:65:BE password=123456 profile=24hours
add comment="F2:CF:1F:D4:D4:40 - 254715101710 Expires on:- 2025-08-12" name=\
    F2:CF:1F:D4:D4:40 password=123456 profile=12hours
add comment="16:51:AC:3C:D8:F0 - 254710631267 Expires on:- 2025-08-12" name=\
    16:51:AC:3C:D8:F0 password=123456 profile=12hours
add comment="56:AB:A8:9E:99:99 - 254720879936 Expires on:- 2025-08-12" name=\
    56:AB:A8:9E:99:99 password=123456 profile=12hours
add comment="7E:BD:D3:B3:B7:DB - 254725847822 Expires on:- 2025-08-12" name=\
    7E:BD:D3:B3:B7:DB password=123456 profile=12hours
add comment="C8:17:39:24:3D:54 - 254115256173 Expires on:- 2025-08-12" name=\
    C8:17:39:24:3D:54 password=123456 profile=12hours
add comment="54:EF:92:94:C7:40 - 254116839005 Expires on:- 2025-08-12" name=\
    54:EF:92:94:C7:40 password=123456 profile=12hours
add comment="9E:C1:47:BF:3B:B6 - 254745733955 Expires on:- 2025-08-12" \
    limit-uptime=1d name=9E:C1:47:BF:3B:B6 password=123456 profile=24hours
add comment="6E:E9:81:11:5E:E7 - 254717264459 Expires on:- 2025-08-12" name=\
    6E:E9:81:11:5E:E7 password=123456 profile=12hours
add comment="36:8F:31:47:3A:45 - 254758530034 Expires on:- 2025-08-13" name=\
    36:8F:31:47:3A:45 password=123456 profile=12hours
add comment="52:34:CF:7A:14:5D - 254115522724 Expires on:- 2025-08-13" name=\
    52:34:CF:7A:14:5D password=123456 profile=12hours
add comment="AE:BE:6B:14:6D:AF - 254712504248 Expires on:- 2025-08-13" name=\
    AE:BE:6B:14:6D:AF password=123456 profile=12hours
add comment="D0:1C:3C:8B:D9:59 - 254701105583 Expires on:- 2025-08-13" name=\
    D0:1C:3C:8B:D9:59 password=123456 profile=12hours
add comment="BA:D2:CA:0E:96:44 - 254720756434 Expires on:- 2025-08-13" name=\
    BA:D2:CA:0E:96:44 password=123456 profile=12hours
add comment="1A:D8:84:A1:F8:4D - 254701534414 Expires on:- 2025-08-13" \
    limit-uptime=1d name=1A:D8:84:A1:F8:4D password=123456 profile=24hours
add comment="C6:BC:DB:9E:F8:42 - 254797800208 Expires on:- 2025-08-13" name=\
    C6:BC:DB:9E:F8:42 password=123456 profile=12hours
add comment="52:6D:5C:A0:DD:F3 - 254745713399 Expires on:- 2025-08-13" name=\
    52:6D:5C:A0:DD:F3 password=123456 profile=12hours
add comment="1E:35:96:C7:86:AD - 254726239433 Expires on:- 2025-08-13" name=\
    1E:35:96:C7:86:AD password=123456 profile=12hours
add comment=" - 254748829132 Expires on:- 2025-08-13" name=22:89:AD:AE:C5:72 \
    password=123456 profile=12hours
add comment="A6:55:92:42:FD:F5 - 254707492307 Expires on:- 2025-08-13" name=\
    A6:55:92:42:FD:F5 password=123456 profile=12hours
add comment="F2:B6:A0:ED:5E:64 - 254768519073 Expires on:- 2025-08-13" \
    limit-uptime=1d name=F2:B6:A0:ED:5E:64 password=123456 profile=24hours
add comment="5E:7C:4B:7A:40:17 - 254718748394 Expires on:- 2025-08-13" name=\
    5E:7C:4B:7A:40:17 password=123456 profile=12hours
add comment="D6:79:B2:D8:CB:F6 - 254707195016 Expires on:- 2025-08-13" name=\
    D6:79:B2:D8:CB:F6 password=123456 profile=12hours
add comment="FE:9B:22:4D:25:D6 - 254746311615 Expires on:- 2025-08-13" name=\
    FE:9B:22:4D:25:D6 password=123456 profile=12hours
add comment="42:09:DD:98:6D:63 - 254707157930 Expires on:- 2025-08-13" name=\
    42:09:DD:98:6D:63 password=123456 profile=12hours
add comment="CA:32:9B:5B:BB:88 - 254110969589 Expires on:- 2025-08-13" \
    limit-uptime=1d name=CA:32:9B:5B:BB:88 password=123456 profile=24hours
add comment="32:16:6D:9F:E6:4C - 254704574056 Expires on:- 2025-08-13" name=\
    32:16:6D:9F:E6:4C password=123456 profile=12hours
add comment="AE:16:39:64:40:EE - 254797014266 Expires on:- 2025-08-13" name=\
    AE:16:39:64:40:EE password=123456 profile=12hours
add comment="AE:B9:29:0C:AB:F1 - 254740286270 Expires on:- 2025-08-13" name=\
    AE:B9:29:0C:AB:F1 password=123456 profile=12hours
add comment="C2:3E:6C:F9:F7:6A - 254726457752 Expires on:- 2025-08-13" \
    limit-uptime=1d name=C2:3E:6C:F9:F7:6A password=123456 profile=24hours
add comment="62:48:6D:87:40:8D - 254792676790 Expires on:- 2025-08-13" \
    limit-uptime=1d name=62:48:6D:87:40:8D password=123456 profile=24hours
add comment="3E:FC:50:13:47:55 - 254710171437 Expires on:- 2025-08-13" name=\
    3E:FC:50:13:47:55 password=123456 profile=12hours
/ip hotspot walled-garden
add comment="place hotspot rules here" disabled=yes
/ip hotspot walled-garden ip
add action=accept disabled=no !dst-address !dst-address-list dst-host=\
    hospotmtaani.wispman.africa !dst-port !protocol !src-address \
    !src-address-list
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=102.0.18.51 \
    pref-src=102.0.18.50 routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh disabled=yes
set api address=10.145.0.1/32
set api-ssl disabled=yes
/ppp secret
add name=sharifmlango password=gishinga profile=6mbps service=pppoe
add name=Mwanziumlango password=gishinga profile=4mbps service=pppoe
add name=mbuthiamlango password=gishinga profile=4mbps service=pppoe
add name=josecaretaker password=gishinga profile=4mbps service=pppoe
add disabled=yes name=nungarimlango password=gishinga profile=6mbps service=\
    pppoe
add disabled=yes name=abdimlango password=gishinga profile=6mbps service=\
    pppoe
add name=ROBSORA password=gishinga profile=6mbps service=pppoe
add name=moshamradi password=gishinga profile=15mbps service=pppoe
add disabled=yes name=fuadeastleigh password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name=karimaeastleigh password=gishinga profile=4mbps \
    service=pppoe
add name=Barwaqoconner password=gishinga profile=4mbps service=pppoe
add name=funiturearea4 password=gishinga profile=4mbps service=pppoe
add name=carwasharea4 password=gishinga profile=6mbps service=pppoe
add name=chiefmradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=nyodongomradi password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name=johnmradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=johnmlangorounda password=gishinga profile=6mbps \
    service=pppoe
add name=stampmradi password=gishinga profile=6mbps service=pppoe
add disabled=yes name=rosemradi password=gishinga profile=4mbps service=pppoe
add name=jovidanmradi password=gishinga profile=4mbps service=pppoe
add name=morrisemradi password=gishinga profile=4mbps service=pppoe
add name=jeophmradi password=gishinga profile=4mbps service=pppoe
add name=juliamradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=sharonmradi password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name=susanmradi password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name=victormradi password=gishinga profile=4mbps service=\
    pppoe
add name=kahiv8 password=gishinga profile=6mbps service=pppoe
add name=keltonv8 password=gishinga service=pppoe
add name=tomamana password=gishinga profile=4mbps service=pppoe
add name=Kelton password=gishinga profile=4mbps service=pppoe
add name=Hotspot password=gishinga profile=20mbps service=pppoe
add name=osoromradi password=gishinga profile=4mbps service=pppoe
add name=Osoromradi password=gishinga profile=4mbps service=pppoe
add name=duncanconner password=gishinga profile=6mbps service=pppoe
add name=wainainamradi password=gishinga profile=6mbps service=pppoe
add disabled=yes name=cameline password=gishinga profile=4mbps service=pppoe
add disabled=yes name="Michael okelo" password=gishinga profile=4mbps \
    service=pppoe
add disabled=yes name=shiroconner password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name=mamaesther password=gishinga profile=4mbps service=\
    pppoe
add name=ndinya password=gishinga profile=4mbps service=pppoe
add name=reginamlango password=gishinga profile=6mbps service=pppoe
add name=kamwana password=gishinga profile=4mbps service=pppoe
add name=tarea password=gishinga profile=4mbps service=pppoe
add name=STLkibato password=gishinga profile=4mbps service=pppoe
add name=SL2kibato password=gishinga profile=4mbps service=pppoe
add name=gregmradi password=gishinga profile=4mbps service=pppoe
add name=basilbaba password=gishinga profile=4mbps service=pppoe
add name=iceword password=gishinga profile=4mbps service=pppoe
add name=madolladeppo password=gishinga profile=4mbps service=pppoe
add name=shofco password=gishinga profile=4mbps service=pppoe
add name=Iceworld password=gishinga profile=6mbps service=pppoe
add name=kevinmradi password=gishinga profile=4mbps service=pppoe
add name=evansamana password=gishinga profile=4mbps service=pppoe
add name=agnesmlango password=gishinga profile=4mbps service=pppoe
add name=benmlango password=gishinga profile=6mbps service=pppoe
add name=simiyuamana password=gishinga profile=4mbps service=pppoe
add name="Riwa high school " password=gishinga profile=20mbps service=pppoe
add name=mosesshofco password=gishinga profile=8mbps service=pppoe
add disabled=yes name=Arkmradi password=gishinga profile=4mbps service=pppoe
add name=Patrickmradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=billygitathuru password=gishinga profile=4mbps service=\
    pppoe
add disabled=yes name="ittefaq travela" password=gishinga profile=10mbps \
    service=pppoe
add name=Dohmmradi password=gishinga profile=4mbps service=pppoe
add name=Fredmradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=JOHNROUNDA password=gishinga profile=4mbps service=\
    pppoe
add name=Bernardmradi password=gishinga profile=6mbps service=pppoe
add name=Kennedyshofco password=gishinga profile=4mbps service=pppoe
add name=Elvismradi password=gishinga profile=4mbps service=pppoe
add name=Quentermradi password=gishinga profile=4mbps service=pppoe
add disabled=yes name=jamesmradi password=gishinga profile=4mbps service=\
    pppoe
add name=felixOumamradi password=gishinga profile=4mbps service=pppoe
add name=Maxwellgitathuru password=gishinga profile=4mbps service=pppoe
add name=jareshovco password=gishinga profile=4mbps service=pppoe
add name=josephconner password=gishinga profile=4mbps service=pppoe
add name="Doctor " password=gishinga profile=4mbps service=pppoe
add name=doctorlasty password=gishinga profile=6mbps service=pppoe
add name=Violetmradi password=gishinga profile=4mbps service=pppoe
add name=Hillarymradi password=gishinga profile=4mbps service=pppoe
add name=joycemradi password=gishinga profile=4mbps service=pppoe
add name=vitalismradi password=gishinga profile=4mbps service=pppoe
add name=jamesamana password=gishinga profile=4mbps service=pppoe
add name=Mamamradi password=gishinga profile=4mbps service=pppoe
add name=joelmradi password=gishinga profile=4mbps service=pppoe
/system clock
set time-zone-name=Africa/Nairobi
/system note
set show-at-login=no
/system package update
set channel=long-term
/system routerboard settings
set enter-setup-on=delete-key
/system scheduler
add interval=1m name=schedule1 on-event=":if ([:len [/ip route find gateway=\"\
    ovpn-wispman\"]] != 1 ) do={\r\
    \n:local id [/interface ovpn-client find name=\"ovpn-wispman\"];\r\
    \n/interface ovpn-client disable \$id;\r\
    \n/interface ovpn-client enable \$id;\r\
    \n}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=1970-01-02 start-time=01:50:28
