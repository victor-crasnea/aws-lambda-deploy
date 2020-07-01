FROM jenkins/jenkins
USER root
RUN apt-get update
RUN apt-get install -y python3 python3-pip sudo zip
RUN pip3 install boto3
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash