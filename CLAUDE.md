# CLAUDE.md

This repo is a possibly 1-to-1 rewrite of Avoid Your Past tiny game.

Initially, [the game was implemented for Lua-based](https://github.com/beetrootpaul/avoid-your-past) [PICO-8 fantasy console](https://www.lexaloffle.com/pico-8.php). Then, [it was rewritten in TypeScript](https://github.com/beetrootpaul/avoid-your-past-beetpx) as a way to drive development of [BeetPx pixel art browser games framework](https://github.com/beetrootpaul/beetpx/tree/v0.56.1).

Now, we are rewriting it to [Odin](https://odin-lang.org/), again as a way to drive develpoment of the Odin variant of BeetPx.

## Version Control System

This repo is instrumented with both git and jj (jujutsu).

That being said, a very important rule: you do **not** modify the repo history on your own. Do not commit code, do not squash or rebase or merge, etc. Act like there is no VCS in place.

User is the sole reposnisble person for managing the commits, switching between jj changes/revisions, pushing the changes to `origin`, etc. Users wants a complete control over the VCS.

If you ever write a commit message (e.g. when the user allows you to commit), end it with an `Assisted-by:` trailer naming the tool, e.g. `Assisted-by: Claude Code`. Do not add `Co-Authored-By:` or `Claude-Session:` lines.

## Repo layout and scripts

- The game's code is the single Odin package in `./src/`.
- BeetPx is not part of this repo. It is referenced as the `beetpx` collection from `../beetpx-odin/beetpx/` (see `ols.json` and the scripts).
- `./scripts/check.sh` checks the game for every target (use it to verify changes), `./scripts/format.sh` formats it with `odinfmt` (config in `odinfmt.json`), `./scripts/run.sh <target>` runs it. See `README.md` for details.

## Odin programming langauge

- Overview: https://odin-lang.org/docs/overview/
- Packages: https://pkg.odin-lang.org/
- `demo.odin` which covers most of the langauge features, in an idiomatic code: https://github.com/odin-lang/Odin/blob/master/examples/demo/demo.odin
- Examples of how to do Xyz in Odin: https://github.com/odin-lang/examples

## Maintenance of CLAUDE.md

Whenever you realized there are some useful its of knowledge that you would benefit from if they were included in this CLAUDE.md file here, add them in the same session of work. If another model is working on the

In the end, the user will decide whether to keep given changes or not.
