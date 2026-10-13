#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

watch=false
for arg in "$@"; do
	case "${arg}" in
	--watch) watch=true ;;
	*)
		echo "Unknown argument: '${arg}'. Usage: $0 [--watch]" >&2
		exit 1
		;;
	esac
done

run_tests() {
	echo "Testing './tests' ..."
	# `-thread-count:1` works around the same intermittent crash of the
	# compiler as in `check.sh`.
	#
	# TODO: Remove the single-threading once the issue is fixed.
	#
	# `BEETPX_PLATFORM=nil` runs the game with no window, so that tests can
	# drive it with `bpx.nil_platform_step`.
	#
	# The `ODIN_TEST_*` defines shorten the output: `LOG_LEVEL=warning` hides
	# the runner's informational header, and `SHORT_LOGS` drops the date, time,
	# and procedure name from every log line.
	odin test ./tests -thread-count:1 \
		-collection:beetpx=../beetpx-odin/beetpx/ \
		-define:BEETPX_PLATFORM=nil \
		-define:ODIN_TEST_FAIL_ON_BAD_MEMORY=true \
		-define:ODIN_TEST_LOG_LEVEL=warning \
		-define:ODIN_TEST_SHORT_LOGS=true
}

if [[ "${watch}" == true ]]; then
	if ! command -v watchexec >/dev/null; then
		echo "'--watch' requires watchexec: https://watchexec.github.io/" >&2
		exit 1
	fi
	# TODO: Consider removing beetpx and other deps from watched files.
	exec watchexec \
		--clear \
		--exts odin \
		--watch ./src \
		--watch ./tests \
		--watch ../beetpx-odin/beetpx \
		-- ./scripts/test.sh
fi

run_tests
echo "All tests passed."
