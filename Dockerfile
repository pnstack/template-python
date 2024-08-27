FROM python:3.11-slim AS base
ENV LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONFAULTHANDLER=1
RUN apt-get update && \
  apt-get install -y --no-install-recommends gcc && \
  apt-get install -y ffmpeg libsm6 libxext6 && \
  apt-get install -y zbar-tools && \
  apt-get install -y libzbar-dev
RUN pip install --upgrade pip

FROM base AS builder
RUN python -m venv /.venv
ENV PATH="/.venv/bin:$PATH"
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM base as runtime
WORKDIR /app
COPY --from=builder /.venv /.venv
ENV PATH="/.venv/bin:$PATH"
COPY . /app
EXPOSE 8000
CMD ["python", "main.py"]