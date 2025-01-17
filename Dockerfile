FROM python:3
ADD app.py /
RUN pip install flask
RUN pip install flask-restful
EXPOSE 9090
CMD [ "python", "./app.py" ]
