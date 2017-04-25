#!/bin/bash
# RA MOD

aria2_config() {

    echo "Configure aria2 for Mac."
        download_folder="Downloads"
        diskcache='1M'
        fileallocation='falloc'
        download_limit=0
        upload_limit=0
        btmaxpeers=25
        maxjobs=5
        maxthread=10
        tcp_port=51413
        udp_port=51413
        seedtime=525600
        rpc_user=""
        rpc_passwd=""

        aria2_conf_path="/usr/local/opt/aria2/bin/"
        aria2_downloadlist="${aria2_conf_path}/.aria2file.txt"
        aria2_DHT="${aria2_conf_path}/.dht.dat"
        aria2_downloadfolder="${HOME}/${download_folder}"

        [ ! -d "$aria2_conf_path" ] && mkdir -p "$aria2_conf_path"
        [ ! -d "$aria2_downloadfolder" ] && mkdir -p "$aria2_downloadfolder"
        [ ! -f "$aria2_downloadlist" ] && touch "$aria2_downloadlist"
        [ ! -f "$aria2_DHT" ] && touch "$aria2_DHT"

    aria2_configfile="${aria2_conf_path}/.aria2.conf"
    cat > "$aria2_configfile" << EOF
# General Setting
#
continue
peer-id-prefix=-TR2610-
user-agent=Transmission/2.61 (13407)
event-poll=select
on-download-complete="${aria2_conf_path}/post"

# Connection Setting
#
disable-ipv6
check-certificate=false
min-split-size=5M

# BitTorrent Setting
#
enable-dht
enable-dht6=false
enable-peer-exchange
bt-enable-lpd
bt-seed-unverified
bt-save-metadata
bt-hash-check-seed
bt-remove-unselected-file
bt-stop-timeout=900
seed-ratio=0.0
save-session-interval=60
EOF

    cmd="/usr/local/opt/aria2/bin/aria2c -c -D --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all \
    --conf-path=$aria2_configfile \
    --dir=$aria2_downloadfolder \
    --input-file=$aria2_downloadlist \
    --save-session=$aria2_downloadlist \
    --disk-cache=$diskcache \
    --dht-file-path=$aria2_DHT \
    --max-overall-download-limit=$download_limit \
    --max-overall-upload-limit=$upload_limit \
    --bt-max-peers=$btmaxpeers \
    --split=$maxthread \
    --max-connection-per-server=$maxthread \
    --max-concurrent-downloads=$maxjobs \
    --listen-port=$tcp_port \
    --dht-listen-port=$udp_port"

    echo "Start aria2 for Mac:"
    eval "$cmd"

}

start() {
    aria2_config
    sleep 1
    status
}

stop() {
    # must interrupt it to save session
    echo "Stop aria2 for Mac."
    killall -2 aria2c
    sleep 2
}

restart() {
    stop
    start
}

status() {
    lsof -i:6800 || echo "Aria2 is not running."
}

others() {
    cat << EOF
Unknown argument: $1

Syntax: $0 {start|stop|restart|status}

    Commands:
        start   Start the service
        stop    Stop the service
        restart Restart the service
        status  See the status

EOF

}

case $1 in
    start  ) start   ;;
    stop   ) stop    ;;
    status  ) status   ;;
    restart   ) restart    ;;
    *      ) others    ;;
esac
