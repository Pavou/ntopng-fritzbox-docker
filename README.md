# ntopng analyzing network traffic from Fritz!Box dockerized

Dockerfile for docker image to monitor Fritz!Box traffic in realtime with ntopng. 

Dockerfile uses the official [ntopng docker image](https://github.com/ntop/docker-ntop) ([Dockerhub](https://hub.docker.com/u/ntop)) and the ntop provided [script](https://github.com/ntop/ntopng/blob/dev/tools/fritzdump.sh) for monitoring Fritz!Box traffic. 
Based on ntop [guide](https://www.ntop.org/ntopng/how-to-use-ntopng-for-realtime-traffic-analysis-on-fritzbox-routers/) for realtime Traffic Analysis on Fritz!Box Routers. 

## How to

### Build image 
```
docker build . -t ntopng-fritzbox-docker
```

### Run image 
```
docker run -d -e FRITZHOST='http://192.168.2.1' -e FRITZUSER='username-goes-here' -e FRITZPWD='password-goes-here' --privileged -p 3000:3000 ntopng-fritzbox-docker
```

*NOTE:* If you use password-only authentication pass "dslf-config" as username
