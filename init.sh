#!/bin/bash

# بدء خدمة SSH
sudo service ssh start

# بدء جلسة tmate في الخلفية
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# استخراج رابط الجلسة وحفظه على سطح المكتب
TMATE_URL=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}')
echo "SSH Connection via tmate: $TMATE_URL" > /config/Desktop/tmate_connection.txt

# الحفاظ على الحاوية تعمل (Webtop سيتولى الباقي)
# لكننا نضمن أن السكربت لا ينتهي فوراً
echo "tmate session started and link saved to Desktop."
