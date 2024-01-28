FROM ubuntu:latest

WORKDIR /app

# Fix certificate issues
RUN apt-get update

COPY requirements.txt ./requirements.txt

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y python3.10 python3-pip

RUN curl -sSL https://install.python-poetry.org | python3 - --preview
RUN pip3 install --upgrade requests
RUN ln -fs /usr/bin/python3 /usr/bin/python

RUN pip3 install --upgrade pip 

RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 8501

RUN python3 ./code_model_training/train.py

ENTRYPOINT ["python3","app.py"]