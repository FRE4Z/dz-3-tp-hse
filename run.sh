#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$PROJECT_DIR/data"
mkdir -p "$DATA_DIR"

build_generator() {
    docker build -t data-generator ./generator
}

run_generator() {
    docker run --rm -v "$DATA_DIR:/data" data-generator
}

create_local_data() {
    python3 ./generator/generate.py "$DATA_DIR"
}

build_reporter() {
    docker build -t data-reporter ./reporter
}

run_reporter() {
    docker run --rm -v "$DATA_DIR:/data" data-reporter
}

structure() {
    find . -type f -not -path "./data/*" -not -path "./.git/*" | sort
}

clear_data() {
    rm -f "$DATA_DIR"/*.csv "$DATA_DIR"/*.html
}

inside_generator() {
    docker run --rm -v "$DATA_DIR:/data" data-generator ls -la /data
}

inside_reporter() {
    docker run --rm -v "$DATA_DIR:/data" data-reporter ls -la /data
}

build_server() {
    docker build -t report-server ./server
}

report_server() {
    docker stop report-server 2>/dev/null
    docker rm report-server 2>/dev/null
    docker run -d --name report-server -p 8080:80 -v "$DATA_DIR:/data" report-server
    echo "Server running on port 8080"
}

case "$1" in
    build_generator) build_generator ;;
    run_generator) run_generator ;;
    create_local_data) create_local_data ;;
    build_reporter) build_reporter ;;
    run_reporter) run_reporter ;;
    structure) structure ;;
    clear_data) clear_data ;;
    inside_generator) inside_generator ;;
    inside_reporter) inside_reporter ;;
    build_server) build_server ;;
    report_server) report_server ;;
    *) echo "Unknown command" ;;
esac
