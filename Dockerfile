# استخدام نسخة أوبونتو مستقرة
FROM ubuntu:22.04

# منع النوافذ التفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تحديث النظام وتثبيت الأدوات الأساسية (SSH, بايثون, Git, وغيرها)
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    git \
    python3 \
    python3-pip \
    htop \
    && rm -rf /var/lib/apt/lists/*

# إعداد خدمة SSH
RUN mkdir /var/run/sshd
# السماح بتسجيل الدخول كـ Root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# تعيين كلمة مرور افتراضية (يمكنك تغييرها لاحقاً أو تمريرها كمتغير بيئة)
RUN echo 'root:2004' | chpasswd

# إنشاء مجلد العمل الذي سيتم ربطه بالـ Volume
RUN mkdir -p /workspace
WORKDIR /workspace

# فتح منفذ SSH
EXPOSE 22

# تشغيل خدمة SSH وإبقاؤها في الخلفية حتى لا تنطفئ الحاوية
CMD ["/usr/sbin/sshd", "-D"]
