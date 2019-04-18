
while IFS='' read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^#.*$ ]] && continue

    user=$(echo $line |cut -d ";" -f 1)
    host=$(echo $line |cut -d ";" -f 2)
    remote_path=$(echo $line |cut -d ";" -f 3)
    local_path=$(echo $line |cut -d ";" -f 4)

    mountpoint -q $local_path
    if [ $? -eq 1 ]
    then
      sshfs $user@$host:$remote_path $local_path -o nonempty,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,cache=yes,kernel_cache,compression=no,Ciphers=aes128-ctr
    fi
done < ~/cadriciel/conf/mountpoints.conf
