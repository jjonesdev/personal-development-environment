# Development Environment

This is a personal macOS development environment centered on Neovim and iOS
development. It tracks the editor, command-line tools, mappings, and visual
choices I use—not a starter kit or general-purpose Neovim distribution.

It was originally inspired by
[wojciech-kulik/ios-dev-starter-nvim](https://github.com/wojciech-kulik/ios-dev-starter-nvim)
and [The Complete Guide to iOS & macOS Development in
Neovim](https://wojciechkulik.pl/ios/the-complete-guide-to-ios-macos-development-in-neovim).

The setup includes Xcode project workflows, SourceKit-LSP, simulator builds and
runs, LLDB debugging, tests, diagnostics, formatting, linting, code coverage,
Git review tools, a GitHub dashboard, and an Xcode Dark High Contrast-inspired
Neovim interface.

The repository is public as a reference, but I do not accept external
contributions. Fork it if you want to adapt it for your own workflow.

## Requirements

- macOS with Xcode 26 or Xcode 27
- [Homebrew](https://brew.sh/)
- A terminal with true-color and Nerd Font support

## Installed Tools

- Neovim 0.12 or newer
- [GitHub CLI](https://cli.github.com/)
- [DASH](https://github.com/dlvhdr/gh-dash)
- [Herdr](https://herdr.dev/)
- [XcodeProjectCLI](https://github.com/wojciech-kulik/XcodeProjectCLI)
- [XcodeBuildMCP](https://github.com/getsentry/XcodeBuildMCP) for agent-driven builds, tests, debugging, logs, and simulator automation
- [xcode-build-server](https://github.com/SolaWing/xcode-build-server)
- [pymobiledevice3](https://github.com/doronz88/pymobiledevice3) for physical-device workflows
- [SwiftLint](https://github.com/realm/SwiftLint)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- [xcbeautify](https://github.com/cpisciotta/xcbeautify)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [Delta](https://github.com/dandavison/delta)
- [TUICR](https://github.com/agavra/tuicr)

The included installer handles the Homebrew and `pipx` dependencies. To install
them manually instead:

```bash
brew tap getsentry/xcodebuildmcp
brew trust --formula getsentry/xcodebuildmcp/xcodebuildmcp
brew install neovim gh xcp xcode-build-server xcodebuildmcp xcbeautify swiftformat swiftlint lazygit git-delta tuicr herdr \
  pipx ripgrep fd jq coreutils
gh extension install dlvhdr/gh-dash
pipx install pymobiledevice3
brew services start herdr
```

The interface was designed with **Lilex Nerd Font Mono Medium**. Any Nerd Font
will work, but icon alignment and text weight may differ.

## Installation

Clone the repository into your development directory and run the installer:

```bash
git clone https://github.com/jjonesdev/personal-development-environment.git \
  ~/Developer/personal-development-environment
cd ~/Developer/personal-development-environment
./install.sh
gh auth status || gh auth login
```

The installer:

- installs missing formulae from `Brewfile` without upgrading existing ones
- trusts only the official XcodeBuildMCP formula from its third-party Homebrew tap
- installs `gh-dash` as a GitHub CLI extension when it is missing
- installs `pymobiledevice3` with `pipx` when it is missing
- safely backs up existing configuration paths before replacing them
- links Neovim, LazyGit, TUICR, `gh-dash`, and Herdr to their tracked configurations
- links shared agent skills into the personal Codex and Claude Code skill directories
- registers XcodeBuildMCP with Codex and Claude Code when it is missing
- starts the Herdr session server at login through Homebrew services
- installs the pinned Neovim plugins

GitHub authentication is interactive, so it remains an explicit step after the
installer. Skip `gh auth login` when `gh auth status` already succeeds.

It is safe to rerun after updating the repository. The custom `xcode-dark-hc`
colorscheme is already selected in `nvim/init.lua`, so no additional theme
configuration is required.

To update the configuration later:

```bash
git -C ~/Developer/personal-development-environment pull --ff-only
~/Developer/personal-development-environment/install.sh
```

## Repository Layout

```text
.
├── Brewfile
├── install.sh
├── scripts/
│   ├── update-mcps.sh
│   └── update-skills.sh
├── skills/
│   └── <skill-name>/
│       └── SKILL.md
├── nvim/
│   ├── init.lua
│   ├── lua/
│   ├── colors/
│   └── after/
└── configs/
    ├── gh-dash/
    ├── herdr/
    ├── lazygit/
    └── tuicr/
```

The boundaries are intentional: `nvim/` contains editor behavior, `configs/`
contains settings for standalone tools, `skills/` contains tool-neutral agent
skills, and the scripts own installation and symlinks. Neovim can launch
LazyGit and TUICR without owning their configuration.

The installer manages these paths:

- `~/.config/nvim` → `nvim/`
- LazyGit's platform-specific `config.yml` → `configs/lazygit/config.yml`
- `~/.config/tuicr/config.toml` → `configs/tuicr/config.toml`
- `~/.config/gh-dash/config.yml` → `configs/gh-dash/config.yml`
- `~/.config/herdr/config.toml` → `configs/herdr/config.toml`
- `~/.agents/skills/<skill-name>` → `skills/<skill-name>` for Codex
- `${CLAUDE_CONFIG_DIR:-~/.claude}/skills/<skill-name>` → `skills/<skill-name>` for Claude Code

## Agent MCP Servers

XcodeBuildMCP gives Codex and Claude Code access to iOS build, test, simulator,
debugging, logging, and UI-automation workflows. The same Homebrew package also
provides the `xcodebuildmcp` CLI for direct terminal use.

The installer registers this stdio server when it is missing:

```text
XcodeBuildMCP -> xcodebuildmcp mcp
  workflows -> simulator, debugging, ui-automation
```

Registration is additive. `scripts/update-mcps.sh` checks each client before
adding the server and leaves an existing same-named configuration unchanged.
It does not replace either client's configuration file. Run it directly after
installing Codex or Claude Code on an existing PDE installation:

```bash
./scripts/update-mcps.sh
```

## Agent Skills

The repository uses one source directory for skills shared by Codex and Claude
Code. Both tools support the open Agent Skills format and follow symlinked skill
directories. The updater links skills individually, so it preserves skills
installed by other tools or managed outside this repository.

To add a skill:

```bash
mkdir -p skills/my-skill
$EDITOR skills/my-skill/SKILL.md
./scripts/update-skills.sh
```

Each `SKILL.md` should use portable Agent Skills frontmatter with at least a
`name` and `description`. Avoid tool-specific extensions when the skill should
behave the same in both agents. See the official [Codex skill
documentation](https://developers.openai.com/codex/build-skills) and [Claude
Code skill documentation](https://code.claude.com/docs/en/slash-commands).

Changes to an already linked skill are available immediately because both
tools read the repository directory through the symlink. Run
`scripts/update-skills.sh` again after adding a new skill or repairing a link.
The updater is strictly additive: it never replaces or deletes an existing
skill or skills directory. If a skill name already exists with a different
source, that skill is left untouched and the managed copy is skipped.

Because this repository is public, keep private or work-specific skills out of
Git. To use a local-only skill from the same directory, exclude it locally:

```bash
printf 'skills/work-only/\n' >> .git/info/exclude
```

The included iOS skill bundle comes from
[`junwatu/codex-plugins`](https://github.com/junwatu/codex-plugins/tree/main/plugins/build-ios-apps).
Its debugger skill uses XcodeBuildMCP, while its SwiftUI skills cover Liquid
Glass, performance auditing, UI patterns, and view refactoring.

The repository also includes Antoine van der Lee's
[`swift-concurrency`](https://github.com/AvdLee/Swift-Concurrency-Agent-Skill/tree/main/skills/swift-concurrency)
skill for diagnosing data races, adopting async/await and actors, and guiding
Swift 6 migrations.

## Standalone Tools

- `gh dash` opens the GitHub dashboard.
- `herdr` attaches to the agent-aware terminal multiplexer. Its prefix is
  `Ctrl-s`, and its session server starts automatically at login.
- `lazygit` opens the Git interface with Delta-powered diff rendering.
- `tuicr --working-tree` reviews uncommitted changes.

LazyGit and TUICR remain available from Neovim through `<leader>gg` and
`<leader>gr`, respectively.

## Xcode Selection

The configuration uses the Xcode selected by `xcode-select` or the
`DEVELOPER_DIR` environment variable. Restart Neovim after switching Xcode so
`xcodebuild`, `xcrun`, SourceKit-LSP, LLDB, and the simulator runtime all come
from the same installation.

My pinned [`xcodebuild.nvim`](https://github.com/jjonesdev/xcodebuild.nvim) fork
recognizes destination output from both Xcode 26 and Xcode 27. It does not
hard-code an Xcode version; it accepts both the old and new destination section
headers. Using my fork keeps compatibility updates under the same GitHub
account as this configuration.

## First Project Setup

Open Neovim from the directory containing the Xcode project or workspace:

```bash
cd /path/to/MyApp
nvim .
```

Then run:

```vim
:XcodebuildSetup
:checkhealth
```

Press `<C-r>` inside the device picker to refresh its device list.

xcodebuild.nvim stores its logs, result bundles, device cache, and debugger
state under Neovim's data directory rather than inside the project. The
SourceKit-LSP integration still generates a machine-specific `buildServer.json`
in the project root. Ignore it locally without changing the team's
`.gitignore`:

```bash
printf "buildServer.json\n" >> .git/info/exclude
```

## Key Bindings

`<leader>` is the Space key. Tap it once and pause to open WhichKey. Press
`<leader>x` for the complete iOS development hub or `<leader>?` to open the
complete leader map immediately.

The `<leader>x` hub contains the Xcode actions below plus:

- `<leader>xD` — debugging
- `<leader>xn` — navigation and search
- `<leader>xm` — formatting, linting, messages, and saving

The original shorter bindings remain available.

### Xcode

- `<leader>xo` — open the full Xcode Actions picker
- `<leader>xf` — manage the Xcode project
- `<leader>xb` — build
- `<leader>xB` — build for testing
- `<leader>xr` — build and run
- `<leader>xt` — run tests; in visual mode, run selected tests
- `<leader>xT` — run the current test class
- `<leader>xd` — select a device
- `<leader>xp` — select a test plan
- `<leader>xl` — toggle build logs
- `<leader>xe` — toggle the test explorer
- `<leader>xc` — toggle code coverage
- `<leader>xC` — show the code coverage report
- `<leader>xq` — show the quickfix list

### Git

- `<leader>gg` — open LazyGit
- `<leader>gr` — review uncommitted changes in TUICR

LazyGit uses Delta for syntax-highlighted diff previews when Delta is installed.
In TUICR, press `c` to leave a line-level comment or `y` to copy the complete,
structured review for an agent.

### Debugging

- `<leader>b` — toggle a breakpoint
- `<leader>B` — toggle a message breakpoint
- `<leader>dd` — build and debug
- `<leader>dr` — debug without rebuilding
- `<leader>dt` — debug tests
- `<leader>dT` — debug the current test class
- `<leader>dx` — terminate the debugger

Step, continue, hover, and evaluation mappings appear under `<leader>d` while a
debug session is active.

### Navigation and Tools

- `<leader>e` — toggle the file tree
- `<leader>ff` — find files
- `<leader>fg` — live grep
- `<leader>tt` — toggle Trouble/quickfix results
- `<leader>mp` — format the current buffer or visual selection
- `<leader>ml` — lint the current buffer
- `<leader>mm` — show Neovim messages
- `<leader>w` — save all changes

## Formatting and Linting

Formatting and linting are manual. This configuration does not format on save.
Use visual mode with `<leader>mp` when you want SwiftFormat to operate on a
selection, and review the diff before committing changes in established
codebases.

SwiftLint reads the project's own configuration when present. SwiftFormat uses
the project's configuration when present; otherwise its defaults apply.

## Inspiration

This configuration was inspired by
[wojciech-kulik/ios-dev-starter-nvim](https://github.com/wojciech-kulik/ios-dev-starter-nvim)
and [The Complete Guide to iOS & macOS Development in
Neovim](https://wojciechkulik.pl/ios/the-complete-guide-to-ios-macos-development-in-neovim).
The original MIT license and copyright notice are retained.
