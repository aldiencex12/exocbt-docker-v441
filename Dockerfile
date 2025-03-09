# Menggunakan base image Ubuntu 21.04
FROM ubuntu:20.04

# Metadata informasi image
LABEL maintainer="aldiviantara"
LABEL version="4.4.1"
LABEL description="ExtraOrdinaryCBT v4.4.2 (Docker) [Unofficial]"

# Menetapkan user root
USER root

# Menentukan working directory
WORKDIR "/app"
RUN apt update && \
    apt install -y tzdata wget nano unzip

# Mengatur zona waktu
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Mengunduh dan mengekstrak file aplikasi
RUN wget https://s3.ekstraordinary.com/extraordinarycbt/release-rosetta/4.4.1-rosetta-ubuntu+2.zip
RUN unzip 4.4.1-rosetta-ubuntu+2.zip
RUN cp -R 4.4.1-rosetta-ubuntu+2/* .
RUN rm -rf 4.4.1-rosetta-ubuntu+2 exocbt.zip

# Menyalin skrip yang diperlukan
COPY entrypoint.sh .
COPY wait-for-it.sh .

# Memberikan izin eksekusi pada skrip
RUN chmod +x *.sh

# Menjalankan aplikasi menggunakan entrypoint
ENTRYPOINT [ "./entrypoint.sh" ]
CMD ["./main-amd64"]
