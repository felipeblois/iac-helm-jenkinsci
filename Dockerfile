FROM jenkins/inbound-agent:4.11.2-4

USER 0

RUN apt-get update \
&& apt-get install curl \
&& apt-get install python -y

RUN apt-get  update
RUN apt-get install -y apt-transport-https ca-certificates curl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl


RUN curl -L https://download.docker.com/linux/static/stable/x86_64/docker-20.10.7.tgz | tar xvz -C /

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update \
&& apt-get install -y krb5-user libkrb5-dev \
&& apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev \
&& wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz \
&& tar -xf Python-3.9.1.tgz \
&& cd Python-3.9.1 \
&& ./configure --enable-optimizations \
&& make -j 12 \
&& make altinstall \
&& python3.9 -m pip install --upgrade pip \
&& python3.9 -m pip install "ansible" "docker" "requests" "openshift" "pywinrm[kerberos]" "kerberos" "dnspython" 

#RUN apt-get install apt-transport-https ca-certificates gnupg -y \
#&& echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
#&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
#&& apt-get update && apt-get install google-cloud-sdk -y \
#&& apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
&& apt-get install -y nodejs

#USER jenkins
#RUN echo $HOME

#USER root
#ENV MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven"
#RUN apt-get update -y && apt-get install -y maven && apt-get clean all
#RUN mvn deploy:deploy-file dependency:go-offline || /bin/true




