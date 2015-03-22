#!/bin/bash
inotifywait -m -e modify ../conf --exclude ".swp" --format '%f %e %w' -q
