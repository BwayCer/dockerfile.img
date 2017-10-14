FROM centos

MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


RUN yum upgrade -y
RUN yum install -y bash-completion \
        # curl \
        which vim wget tree \
        bzip2 unzip

# RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# RUN source ~/.bashrc

RUN yum clean all


CMD sh /home/bwaycer/dockerEnvtree.sh; \
    bash
