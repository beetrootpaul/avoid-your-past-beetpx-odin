#!/usr/bin/env bash
set -euo pipefail

# Runs the BeetPx CLI, e.g. `./scripts/beetpx.sh run js_wasm32`. See
# `../beetpx-odin/beetpx/cli/main.odin` for the available commands.

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# The CLI's executable goes into `./build/`, so that it does not end up in the
# game's root directory when `odin run` gets interrupted before cleaning up.
#
# `-thread-count:1` works around an intermittent segmentation fault of the
# multithreaded checker, seen in Odin
# [`dev-2026-09:a2fb372b7`](https://github.com/odin-lang/Odin/releases/tag/dev-2026-09),
# about once in 20 runs.
#
# TODO: Remove the single-threading once the issue is fixed.
mkdir -p ./build/
exec odin run ../beetpx-odin/beetpx/cli \
	-out:build/beetpx_cli \
	-thread-count:1 \
	-- "$@"
