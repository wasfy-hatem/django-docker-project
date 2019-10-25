
# My Site
# Version: 1.0
FROM python:3
# Install Python and Package Libraries
RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    libmariadb-dev-compat \
    libmariadb-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim
# Project Files and Settings
#ARG PROJECT=myproject
#ARG PROJECT_DIR=/var/www/${PROJECT}
ARG PROJECT=django-project
#ARG PROJECT_DIR=/home/dev/docker-containers/proj_1/${PROJECT}
ARG PROJECT_DIR=/var/www/${PROJECT}
#COPY . /app  #wasfy check
RUN mkdir -p $PROJECT_DIR
#wasfy
#RUN ls ./home
#
#ADD $PROJECT_DIR $PROJECT_DIR

COPY ./django-project $PROJECT_DIR   
#./django-helloworld is under the directory that contains DockerFile

RUN ls -la $PROJECT_DIR
RUN pwd
#COPY . $PROJECT_DIR
RUN chmod -R 777 $PROJECT_DIR
RUN ls -la $PROJECT_DIR/manage.py

####################
#

WORKDIR $PROJECT_DIR
COPY Pipfile Pipfile.lock ./
RUN pip install -U pipenv
RUN pipenv install --system

#wasfy
#
RUN pip install django

###########
#COPY requirements.txt .
RUN pip install -r requirements.txt


# Server
EXPOSE 8000
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]

#CMD ["ls -la /var/www/django-helloworld/manage.py  "]
#CMD ["ifconfig"]

#CMD ["/bin/bash"]
