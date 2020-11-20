FROM python:3.6
RUN mkdir -p /opt/services/report/src
WORKDIR /opt/services/report/src
# install tools
RUN apt-get update && apt-get install -y vim
# copy our project code
COPY ./src /opt/services/report/src/
COPY ./requirements.txt /opt/services/report/src/requirements.txt
# install dependencies
RUN pip install --upgrade pip
RUN pip install -r /opt/services/report/src/requirements.txt
# start service
CMD ["gunicorn", "--chdir", "bbin/printingservice", "--bind", ":80", "printingservice.wsgi"]