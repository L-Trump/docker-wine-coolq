FROM oott123/novnc:v0.3.0

COPY ./docker-root /

# RUN sed -i 's#/archive.ubuntu.com/#/mirrors.ustc.edu.cn/#g' /etc/apt/sources.list

RUN chown root:root /tmp && \
    chmod 1777 /tmp && \
    apt-get update && \
    apt-get install -y wget software-properties-common apt-transport-https && \
    wget -O- -nc https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu && \
    add-apt-repository -y ppa:cybermax-dexter/sdl2-backport && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
        cabextract unzip python-numpy \
        language-pack-zh-hans tzdata fontconfig && \
    apt-get install -y --no-install-recommends \
        fcitx fcitx-ui-classic fcitx-pinyin && \
    apt-get install -y --allow-unauthenticated --install-recommends winehq-devel && \
    wget -O /usr/local/bin/winetricks https://github.com/Winetricks/winetricks/raw/master/src/winetricks && \
    chmod 755 /usr/local/bin/winetricks && \
    wget -O /tmp/gecko.tar.gz http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.tar.bz2 && \
    mkdir -p /usr/share/wine/gecko && \
    tar xf /tmp/gecko.tar.gz -C /usr/share/wine/gecko && \
    apt-get purge -y software-properties-common apt-transport-https && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN chsh -s /bin/bash user && \
    su user -c 'WINEARCH=win32 /usr/bin/wine wineboot' && \
    su user -c '/usr/bin/wine regedit.exe /s /tmp/coolq.reg' && \
    su user -c 'wineboot' && \
    echo 'quiet=on' > /etc/wgetrc && \
    su user -c '/usr/local/bin/winetricks -q win7' && \
    su user -c '/usr/local/bin/winetricks -q /tmp/winhttp_2ksp4.verb' && \
    su user -c '/usr/local/bin/winetricks -q msscript' && \
    su user -c '/usr/local/bin/winetricks -q fontsmooth=rgb' && \
    wget https://raw.githubusercontent.com/L-Trump/Mirai-Docker/master/source/simsun.zip -O /tmp/simsun.zip && \
    mkdir -p /home/user/.wine/drive_c/windows/Fonts && \
    unzip /tmp/simsun.zip -d /home/user/.wine/drive_c/windows/Fonts && \
    mkdir -p /home/user/.fonts/ && \
    ln -s /home/user/.wine/drive_c/windows/Fonts/simsun.ttc /home/user/.fonts/ && \
    chown -R user:user /home/user && \
    su user -c 'fc-cache -v' && \
    mkdir /home/user/coolq && \
    rm -rf /home/user/.cache/winetricks /tmp/* /etc/wgetrc

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    COOLQ_URL=http://xqh.ma:33001/ltrump-onedrive/mirai.zip

VOLUME ["/home/user/coolq"]
