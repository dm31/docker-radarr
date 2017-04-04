If you want an update of the docker image, create a pull request with the updated version number.

## Starting the container

If you want to attach to the host network (Firewall works):

```
docker run --rm \
           --name radarr \
           --network host \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/movies:/movies \
           hotio/radarr
```

When you prefer to use the bridge network:

```
docker run --rm \
           --name radarr \
           -p 7878:7878 \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/movies:/movies \
           hotio/radarr
```

## Installing a different version

Add the following to the run command:

```
-e VERSION=0.2.0.307
```

Everytime upon starting the container, the given version will be downloaded and installed. Leaving it out will use the version included in the image.

## Installing additional packages

Add the following to the run command:

```
-e PACKAGES="package1 package2"
```

When running the container for the first time, the additional packages will be installed.
