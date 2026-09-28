# Menggunakan base image Debian 12 (Bookworm)
FROM debian:bookworm

# Memperbarui sistem dan menginstal paket dasar termasuk SSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    neofetch \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Menyiapkan direktori SSH
RUN mkdir /var/run/sshd

# Mengatur password untuk user root
RUN echo 'root:noxmbotz007' | chpasswd

# Mengizinkan login root dan password authentication melalui SSH (menggunakan regex fleksibel)
RUN sed -i 's/#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Membuka port 22 untuk koneksi SSH
EXPOSE 22

# Mengubah hostname container
RUN echo "noxmbotz" > /etc/hostname

# Menjalankan service SSH agar container tidak tertutup otomatis
CMD ["/usr/sbin/sshd", "-D"]
