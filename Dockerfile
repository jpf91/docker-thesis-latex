FROM ghcr.io/jpf91/thesis-latex:2022_01_06
LABEL org.opencontainers.image.source="https://github.com/jpf91/docker-thesis-latex"

RUN dnf install -y texlive-xindy  && \
    dnf clean all -y
