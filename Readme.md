# [jpfau/thesis-latex](https://github.com/jpf91/docker-thesis-latex) [![Docker Repository on Quay](https://quay.io/repository/jpfau/thesis-latex/status "Docker Repository on Quay")](https://quay.io/repository/jpfau/thesis-latex)

This image provides a full texlive installation, some related tools (svg/pdf conversion utilities) and an SSH server.

Using Visual Studio Code's Remote SSH feature it's possible to connect to the container and build a latex project with consistent latex tool versions. In addition, this image can be used in CI workflows to automatically build documents in the same environment.

Instead of mounting a directory into the container, you can also directly clone your latex document from a git repository in the container.

## Tags

New versions of the image will be based on the same original fedora version. In addition, tags are provided for each update.
This way, a fixed, old version of an image can be used to ensure there won't be any latex build breakages.

Current tags:
* 2022_01_06

## Usage

The container exclusively uses the root user. This makes uid mapping for filesystems easy, if you use podman in rootless mode.
The password for the root user is `root`.
Here are some instructions and snippets to help you get started creating a container:

### Running using podman cli

```
touch ./ssh_keys/authorized_keys
podman run --rm --name thesis-latex  \
    -p 3222:22 \
    -v ./ssh_keys:/etc/ssh/keys/:Z \
    -v ./ssh_keys/authorized_keys:/root/.ssh/authorized_keys:Z \
    -v ./root_home:/root/:Z \
    -v ./latex_doc/:/root/latex_doc:Z \
    quay.io/jpfau/thesis-latex:2022_01_06
```

SSH hot keys will be automatically generated and placed in `ssh_keys`. You can then place your latex documents in `latex_doc` as that folder is shared with the container.
Usually, a better way to access the containter is using Visual Studio Code and the remote ssh tools.

 To connect to the container using SSH:
```bash
ssh -p 3222 root@127.0.0.1
```

If you want to use public key login, make sure that the `/root/.ssh/authorized_keys` file is mounted to persistent storage as shown above. Then:
```
ssh-copy-id -p 3222 root@localhost
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 22` | To expose the SSH port. |
| `-v /etc/ssh/keys/` | If you want to have persistent SSH host keys so your SSH clients don't complain about changed keys when connecting. |
| `-v /root/latex_doc` | If you want to mount your latex document from somewhere. |
| `-v /root/` | To make the root folder persistent. VSCode installs it's server there, so to avoid having to reinstall all the time. |


## Support Info

* Shell access whilst the container is running: `podman exec -it thesis-latex /bin/bash`
* To monitor the logs of the container in realtime: `podman logs -f thesis-latex`
* Report bugs [here](https://github.com/jpf91/docker-thesis-latex).

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/jpf91/docker-thesis-latex.git
cd docker-thesis-latex
podman build -t quay.io/jpfau/thesis-latex:latest .
```

## Versions

* **06.01.22:** - Initial Release.
