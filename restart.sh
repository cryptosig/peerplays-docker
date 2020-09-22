#/bin/sh
usage="$(basename "$0") [--help] [--nginx] [--node] [--seed] [--witness] 
-- automates screens for peerplays dockers running with no options builds the dockers and starts the nodes detached,
using individual attached nodes are useful for debugging or starting individual nodes

where:
	--help		show this help menu
	--nginx		a web redirector for forwarding webtraffic to the node docker instance (attached)
	--node		starts the api node docker (attached)
	--seed		starts the seed node docker (attached)
	--witness	starts the witness node docker (attached)
	--stop		stops all the nodes
"

if [ -z "$1" ]; 
then 
	docker-compose build

	screen -S node -dm docker-compose up node
	screen -S seed -dm docker-compose up seed
	screen -S witness -dm docker-compose up witness
	screen -S nginx -dm docker-compose up nginx
fi
case $1 in
	"--seed")
		screen -S seed bash -c "docker-compose up seed;exec bash"
	;;
        "--node")
		screen -S node bash -c "docker-compose up node;exec bash"
        ;;
        "--nginx")
		screen -S nginx  bash -c "docker-compose up nginx;exec bash"
        ;;
	"--witness")
		screen -S witness bash -c "docker-compose up witness;exec bash"
	;;
        "--help")
                echo  "$usage"
        ;;
	"--stop")
		bash -c "docker-compose down; screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill"
	;;

esac
