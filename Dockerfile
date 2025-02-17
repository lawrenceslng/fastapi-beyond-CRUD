FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ENV HOST 0.0.0.0

CMD /bin/sh -c "alembic upgrade head && fastapi run src --port 8000 --host 0.0.0.0"
