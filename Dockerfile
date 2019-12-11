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
    && yum install -y wget tar gcc which rsyslog openssh-server openssh-clients passwd \
    && yum clean all

# set timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

CMD ["/usr/sbin/sshd","-D"]
