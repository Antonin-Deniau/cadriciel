#########
# Vault #
#########

function burry() {
    if ! [ -x "$(command -v gpg)" ]; then
        echo 'Error: gpg is not installed.' >&2
        exit 1
    fi
    if [ $# -eq 0 ]; then
       echo "No folder supplied"
       return
    fi

    tar -cz $1 | gpg -e -o $1.crypt

    sta=$?
    if [ $sta -eq 0 ] && [ -f $1.crypt ]; then
        find $1 -type f -exec shred -u {} \;
        rm -rf $1
    fi
    echo RELOADAGENT | gpg-connect-agent
}

function exhume() {
    if ! [ -x "$(command -v gpg)" ]; then
        echo 'Error: gpg is not installed.' >&2
        exit 1
    fi
    
    gpg -d $1 | tar xz
}

###################
# PERSONAL SAFETY #
###################
shred -u $HISTFILE
a 'exit'='shred -u $HISTFILE | exit'
