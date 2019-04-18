function connect() {
	~/.connect/$1
}

function addconnect() {
	mkdir -p ~/.connect/
	echo "#!/bin/bash" > ~/.connect/$1
	echo $2 >> ~/.connect/$1
	chmod +x ~/.connect/$1
}

function rmconnect() {
	rm ~/.connect/$1
}
