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

targets=(
	darwin_arm64
	js_wasm32
)

run_check() {
	for target in "${targets[@]}"; do
		echo "Checking for '${target}' ..."
		# `-thread-count:1` works around an intermittent segmentation
		# fault of the multithreaded checker, seen in Odin
		# [`dev-2026-09:a2fb372b7`](https://github.com/odin-lang/Odin/releases/tag/dev-2026-09),
		# about once in 20 runs.
		#
		# TODO: Consider reporting this crash to Odin. Unless it is already
		#       fixed in a newer version.
		# TODO: Remove the single-threading once the issue is fixed.
		odin check ./src \
			-collection:beetpx=../beetpx-odin/beetpx/ \
			-disable-non-constant-globals \
			-strict-style \
			-thread-count:1 \
			-vet \
			-vet-cast \
			-vet-tabs \
			-vet-packages:main \
			-vet-using-param \
			-vet-using-stmt \
			-warnings-as-errors \
			-target:"${target}" ||
			return 1
	done
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
		--watch ../beetpx-odin/beetpx \
		-- ./scripts/check.sh
fi

run_check
echo "All checks passed."
