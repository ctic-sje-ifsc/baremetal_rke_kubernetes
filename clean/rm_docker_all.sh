docker stop $(docker ps -a -q)
docker rm -f $(docker ps -a -q)
docker volume prune -f
#docker rmi -f $(docker image ls -a -q)