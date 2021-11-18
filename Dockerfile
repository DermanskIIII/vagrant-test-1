FROM python
COPY ./app /app
WORKDIR /app 
RUN pip install -r requirements.txt
ENTRYPOINT ["flask", "run"]
EXPOSE 5000