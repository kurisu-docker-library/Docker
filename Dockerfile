#
# TreasureBoat.org
# by ishimoto
#
# CentOS 6.6 updated
#
# build : docker build -t treasureboat/centos6:0.3 .
# run : docker run -d -P --name tbCentOS6 treasureboat/centos6:0.3

FROM centos:6.6

# address any potential security concerns. 
# install basic packages
RUN yum -y update \
    && yum install -y openssh-server openssh-clients passwd \
    && yum clean all

# set timezone
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#LoginGraceTime 2m/LoginGraceTime 2m/g' /etc/ssh/sshd_config \
    && sed -ri 's/#StrictModes yes/StrictModes yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#RSAAuthentication yes/RSAAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

CMD ["/usr/sbin/sshd","-D"]
