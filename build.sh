#!/usr/bin/env bash
#
# build.sh — documentation helper for the UltraGPS Models repository.
#
#   ./build.sh docs         Preview the documentation locally with live reload
#   ./build.sh docs-build   Render the static documentation site into ./site
#   ./build.sh clean        Remove the ./site directory
#
# This repository holds CAD files only, so unlike the sibling software repos
# there is nothing to compile or package — just the MkDocs site.

set -euo pipefail

# Project root
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$PROJECT_DIR/site"

usage() {
    cat <<USAGE
Usage: ./build.sh <command>

Commands:
  docs         Preview the documentation locally with live reload
               (mkdocs serve — http://127.0.0.1:8000, Ctrl-C to stop)
  docs-build   Build the static documentation site into ./site
  clean        Remove the ./site directory

Options:
  -h, --help   Show this help

Examples:
  ./build.sh docs         # live-preview docs without pushing
  ./build.sh docs-build   # render docs to ./site
  ./build.sh clean        # wipe ./site
USAGE
}

# Ensure mkdocs is available before running a docs command; print an install
# hint otherwise.
require_mkdocs() {
    if ! command -v mkdocs >/dev/null 2>&1; then
        echo "error: 'mkdocs' is not installed." >&2
        echo "Install the documentation dependencies with:" >&2
        echo "    pip install -r docs/requirements.txt" >&2
        exit 1
    fi
}

cmd_docs() {
    require_mkdocs
    echo ">> Serving docs at http://127.0.0.1:8000  (Ctrl-C to stop) ..."
    ( cd "$PROJECT_DIR" && mkdocs serve )
}

cmd_docs_build() {
    require_mkdocs
    echo ">> Building static docs into $SITE_DIR ..."
    ( cd "$PROJECT_DIR" && mkdocs build --site-dir "$SITE_DIR" )
    echo ">> Done: $SITE_DIR/index.html"
}

cmd_clean() {
    if [[ -d "$SITE_DIR" ]]; then
        echo ">> Removing $SITE_DIR ..."
        rm -rf "$SITE_DIR"
        echo ">> Clean."
    else
        echo ">> Nothing to clean ($SITE_DIR does not exist)."
    fi
}

# ---- argument parsing -------------------------------------------------------
COMMAND=""
for arg in "$@"; do
    case "$arg" in
        docs|docs-build|clean)  COMMAND="$arg" ;;
        -h|--help)  usage; exit 0 ;;
        *) echo "Unknown argument: $arg" >&2; echo >&2; usage >&2; exit 1 ;;
    esac
done

case "$COMMAND" in
    docs)       cmd_docs ;;
    docs-build) cmd_docs_build ;;
    clean)      cmd_clean ;;
    "")         usage >&2; exit 1 ;;
esac
