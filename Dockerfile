FROM registry.fedoraproject.org/fedora:35

RUN dnf install -y passwd
RUN echo "root" | passwd root --stdin

RUN dnf update -y &&
    dnf install -y openssh-server openssh-clients \
        zsh findutils hostname iputils \
        make \
        git texlive-scheme-full poppler-utils inkscape librsvg2-tools python3-cairosvg  && \
    dnf clean all -y

ADD sshd_config /etc/ssh/sshd_config
ADD start_ssh.sh /usr/bin/start_ssh.sh

ENTRYPOINT ["/usr/bin/start_ssh.sh"]
