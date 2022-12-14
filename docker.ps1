echo Creating a new docker container is under process
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
docker run -dit -p 82:80 --name nginx001 nginx
docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}'