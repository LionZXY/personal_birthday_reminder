FROM python:3.9-alpine

WORKDIR /app/

ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"

RUN apk --no-cache add \
    musl-locales \
    musl-locales-lang \
    tzdata

ENV TZ=Europe/Moscow

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY common.py /app/
COPY birthday.csv /app/
COPY cron_builder.py /app/

RUN python /app/cron_builder.py  >> /var/spool/cron/crontabs/root

COPY secret.py /app/
COPY telegram_send.py /app/

CMD crond -f -l 2
