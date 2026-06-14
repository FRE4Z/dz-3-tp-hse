# ДЗ №3: Docker + Bash

## Команды

- `./run.sh build_generator` - собрать генератор
- `./run.sh run_generator` - сгенерировать data.csv
- `./run.sh build_reporter` - собрать аналитика
- `./run.sh run_reporter` - создать report.html
- `./run.sh build_server` - собрать веб-сервер
- `./run.sh report_server` - запустить сервер на порту 8080
- `./run.sh clear_data` - очистить папку data
- `./run.sh structure` - показать структуру проекта

## Как открыть report.html в браузере (Codespaces)

1. Запустите сервер: `./run.sh report_server`
2. Откройте вкладку PORTS в Codespaces
3. Нажмите на значок глобуса рядом с портом 8080
4. Добавьте в URL `/report.html`

Пример: `https://название-8080.preview.app.github.dev/report.html`
