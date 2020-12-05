FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-runtime

WORKDIR /workspace

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# No bytecode
ENV PYTHONDONTWRITEBYTECODE 1
# No log buffering
ENV PYTHONUNBUFFERED 1

# Exposing some ports
EXPOSE 8888

COPY . . 

CMD bash
