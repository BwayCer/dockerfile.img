FROM bwaycer/enable-systemd.centos

MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


RUN yum upgrade -y
RUN yum install -y bash-completion \
        bzip2

RUN yum install -y \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
        http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm; \
    yum update -y; \
    yum-config-manager --enable remi; \
    yum-config-manager --enable remi-php70;
RUN yum install -y \
        httpd \
        php mysql-server \
        php-mysql php-zip php-dom php-mbstring php-gd

RUN yum clean all

# RUN usermod -u 1000 apache; \
#     groupmod -g 1000 apache; \
#     find / -user 48 -exec chown -h 1000 {} \;
RUN curl  https://download.owncloud.org/community/owncloud-10.0.3.tar.bz2 |  tar -xj -C ~; \
    mv ~/owncloud/* /var/www/html/; \
    chown -R apache.apache /var/www/html/*; \
    rm -rf ~/owncloud;

RUN echo -e "echo '安裝 ownCloud'\n\
echo ''\n\
echo 'chown -R apache.apache /var/www/html/data'\n\
echo ''\n\
echo '設定資料庫'\n\
echo '    mysql_secure_installation'\n\
echo '    mysql -u root -p'\n\
echo \"    CREATE DATABASE owncloud_db; GRANT ALL PRIVILEGES ON owncloud_db.* TO 'owncloud'@'localhost' IDENTIFIED BY 'owncloud_pw'; FLUSH PRIVILEGES; exit;\"\n\
echo '        => owncloud, owncloud_pw, owncloud_db, localhost'\n\
echo ''\n\
echo 'systemctl restart httpd; systemctl restart mysql'\n" > ~/installOwnCloud.sh


CMD [ "/usr/sbin/init" ]
