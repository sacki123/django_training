FROM python:3.6
RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src
# copy our project code
COPY ./src/ /opt/services/djangoapp/src/
COPY ./requirements.txt /opt/services/djangoapp/src/requirements.txt
# install tools
RUN apt-get update && apt-get install -y vim gettext
# install dependencies
RUN pip install --upgrade pip
RUN pip install -r /opt/services/djangoapp/src/requirements.txt
# start service
CMD ["gunicorn", "--chdir", "webapp", "--bind", ":80", "exs_main.wsgi:application"]