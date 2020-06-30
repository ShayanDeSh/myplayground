FROM ubuntu:latest

Run apt-get update && \
    apt-get install -y openssh-server netcat net-tools curl pwgen wget && \
    apt-get clean all

Run apt-get update && \
    apt-get install -y build-essential python python-dev libxml2-dev \
    libxslt-dev libssl-dev zlib1g-dev libyaml-dev libffi-dev && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python2 get-pip.py

Run pip install --upgrade pip \
    virtualenv requests

Run ln -sf /usr/share/zoneinfo/Iran/ /etc/localtime
Run mkdir /var/run/sshd

Copy id_rsa.pub /root/.ssh/authorized_keys
Run chmod 400 /root/.ssh/authorized_keys

Expose 22
CMD ["/usr/sbin/sshd", "-D"]
