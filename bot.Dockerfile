FROM python:3.9-alpine

WORKDIR /app/

ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"

RUN apk --no-cache add \
    musl-locales \
    musl-locales-lang

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY common.py /app/
COPY birthday.csv /app/
COPY secret.py /app/
COPY telegram_bot.py /app/

CMD python /app/telegram_bot.py
