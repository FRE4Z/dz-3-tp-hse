#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$PROJECT_DIR/data"
mkdir -p "$DATA_DIR"

build_generator() {
    echo "Building generator image..."
    docker build -t data-generator ./generator
}

run_generator() {
    echo "Running generator container..."
    docker run --rm -v "$DATA_DIR:/data" data-generator
}

create_local_data() {
    echo "Running generator locally..."
    python3 ./generator/generate.py "$DATA_DIR"
    echo "Done! Check $DATA_DIR/data.csv"
}

build_reporter() {
    echo "Building reporter image..."
    docker build -t data-reporter ./reporter
}

run_reporter() {
    echo "Running reporter container..."
    docker run --rm -v "$DATA_DIR:/data" data-reporter
}

structure() {
    echo "Project structure:"
    find . -type f -not -path "./data/*" -not -path "./.git/*" | sort
}

clear_data() {
    echo "Clearing data directory..."
    rm -f "$DATA_DIR"/*.csv "$DATA_DIR"/*.html
    echo "Data cleared. Folder $DATA_DIR is now empty."
}

inside_generator() {
    echo "Contents of /data from inside generator container:"
    docker run --rm -v "$DATA_DIR:/data" data-generator ls -la /data
}

inside_reporter() {
    echo "Contents of /data from inside reporter container:"
    docker run --rm -v "$DATA_DIR:/data" data-reporter ls -la /data
}

case "$1" in
    build_generator)
        build_generator
        ;;
    run_generator)
        run_generator
        ;;
    create_local_data)
        create_local_data
        ;;
    build_reporter)
        build_reporter
        ;;
    run_reporter)
        run_reporter
        ;;
    structure)
        structure
        ;;
    clear_data)
        clear_data
        ;;
    inside_generator)
        inside_generator
        ;;
    inside_reporter)
        inside_reporter
        ;;
    *)
        echo "Usage: $0 {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
        exit 1
        ;;
esac
