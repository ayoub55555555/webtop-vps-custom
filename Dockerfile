FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# ملصقات وصفية لزيادة التوافق مع GHCR والأدوات الأخرى
LABEL org.opencontainers.image.source="https://github.com/ayoub55555555/webtop-vps-custom"
LABEL org.opencontainers.image.description="Webtop VPS with SSH and tmate pre-installed"
LABEL org.opencontainers.image.licenses=MIT
LABEL maintainer="ayoub55555555"

# تثبيت الحزم المطلوبة
RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y \
    openssh-server \
    tmate \
    sudo && \
  echo "**** setup ssh ****" && \
  mkdir -p /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# إضافة سكربت الإقلاع
COPY init.sh /etc/cont-init.d/99-custom-init

# تعيين أذونات التنفيذ للسكربت
RUN chmod +x /etc/cont-init.d/99-custom-init

# فتح المنافذ المطلوبة
EXPOSE 22 3000 3001
