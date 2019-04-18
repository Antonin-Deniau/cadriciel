#####################
# Display next ctfs #
#####################
function ctf() {
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq is not installed.' >&2
        exit 1
    fi
    if ! [ -x "$(command -v curl)" ]; then
        echo 'Error: curl is not installed.' >&2
        exit 1
    fi

    echo "Upcomming CTFs: "

    max_ctf=5
    next_n_days=30

    datestart=$(date +%s)
    dateend=$(date +%s -d "+$next_n_days days")

    filter="limit($max_ctf;.[])|{title:.title,onsite:.onsite,start:.start,url:.url}"
    ctfs=$(curl -s "https://ctftime.org/api/v1/events/?limit=100&start=$datestart&finish=$dateend" > /dev/null | jq -Mrc $filter)

    while read line
    do
        ctf=$(echo $line)

        if ! $(echo $ctf |jq -e ".onsite"); then
            title=$(echo $ctf |jq ".title")
            url=$(echo $ctf |jq ".url")
            date=$(echo $ctf |jq ".start"|xargs date +"%A %d %B %Hh" -d)

            echo "$date: $title ($url)"
        fi
    done  < <(echo $ctfs)
}
