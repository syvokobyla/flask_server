FROM debian

RUN apt-get -yqq update
RUN apt-get -yqq install python3 pip3


RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

EXPOSE 8080

ENTRYPOINT ["python3"]

CMD ["-m", "upgrade_server", "--config", "/usr/src/app/configs/prod.ini"]