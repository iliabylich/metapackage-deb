FROM debian:unstable

RUN echo "deb http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
RUN rm -f /etc/apt/sources.list.d/debian.sources

RUN apt update
RUN apt install -y debhelper pkg-config curl gnupg2

RUN curl -s --compressed "https://iliabylich.github.io/ppa/iliabylich_ppa.gpg" | gpg --dearmor | tee /etc/apt/trusted.gpg.d/iliabylich_ppa.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/trusted.gpg.d/iliabylich_ppa.gpg] https://iliabylich.github.io/ppa ./" | tee /etc/apt/sources.list.d/iliabylich-ppa.list > /dev/null

RUN apt update

CMD ["/shared/build-in-docker.sh"]
