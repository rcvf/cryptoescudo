Enter Dockerfile path and run
docker build -t cryptoescudo:1.1.5.0 .

After build complete start container
docker run -it cryptoescudo:1.1.5.0

Enter container and start daemon 
/opt/cryptoescudo/cesc_daemon.sh

View cryptoescudod logs 
/opt/cryptoescudo/cesc_debug.sh




