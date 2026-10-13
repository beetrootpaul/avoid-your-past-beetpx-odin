# Avoid Your Past (BeetPx)

<!-- TODO: Complete the README -->
<!-- TODO: Make BeetPx part of the repo instead of referencing the development code outside the repo. -->

## Running the game

```sh
./scripts/run.sh <target>
```

`<target>` is `js_wasm32` (web) or `darwin_arm64` (macOS).

The scripts work from any directory.

BeetPx repo has to be cloned next to this one, as `../beetpx-odin/`. `run.sh` and `check.sh` only forward to the BeetPx CLI, through `./scripts/beetpx.sh`, which builds it with Odin and runs it. On Windows, call the CLI with `scripts\beetpx.bat <command>` instead, e.g. `scripts\beetpx.bat run js_wasm32`.

On the web, the script builds the game into `./build/web/` and serves it at <http://127.0.0.1:8000>. On macOS, it builds the game into `./build/macos/` and opens it in a window.

## Other scripts

Check the game, for every supported target:

```sh
./scripts/check.sh
```

Add `--watch` to re-run the check every time an `.odin` file in the game or in
BeetPx changes.

Format the game's code (requires `odinfmt` on your `PATH`):

```sh
./scripts/format.sh
```
