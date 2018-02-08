# luzifer-docker / sftp-server

Run a SSH / SFTP server in a Docker container sharing only the folder mounted into the container

## Usage

```bash
## Build container (optional)
$ docker build -t luzifer/sftp-server .

## Execute curator
$ docker run --rm -ti -v $(pwd):/data -e USER=myuser -e PASS=secretpass luzifer/sftp-server
```

## Notes

- Default user / password is `share / changeme`
- User has UID `1000`, so 1000 should be able to read / write files
- To persist the SSH host keys mount `/ssh` to a persistent storage
