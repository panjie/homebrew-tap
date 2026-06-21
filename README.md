# Homebrew tap for Mods

[Mods](https://github.com/panjie/mods) is an AI agent for your terminal. It
doesn't just answer questions — it reads and edits files, runs shell commands,
searches the web, and chains tool calls to actually finish a task, with a
review step that keeps you in charge of anything risky.

This tap installs the actively maintained
[`panjie/mods`](https://github.com/panjie/mods) fork.

## Install

```sh
brew install panjie/tap/mods
```

Or tap the repository first:

```sh
brew tap panjie/tap
brew install mods
```

Then set an API key and run:

```sh
export OPENAI_API_KEY=sk-...
mods "explain this project in one paragraph"
```

See `mods --help` for everyday options, or `mods --help-all` for the full list.

## Why this fork?

The original [`charmbracelet/mods`](https://github.com/charmbracelet/mods) was
sunset in March 2026. This fork continues active development and adds:

- **Built-in tools** — read/write files, run shell commands, sequential thinking
- **Safety & review** — approve file writes and shell commands before they run,
  with per-conversation "always allow" rules
- **Plan mode** — generate a plan for your approval before any change is applied
- **Multi-provider reasoning** — works with OpenAI, Anthropic, Gemini, DeepSeek,
  GLM, Qwen, Kimi, MiniMax, OpenRouter, Ollama, and more
- **Web search & image input** — DuckDuckGo by default (no API key), plus
  vision-capable image attachment

See the [full feature list](https://github.com/panjie/mods#what-mods-can-do)
and [release notes](https://github.com/panjie/mods/releases).

## Disambiguation

`homebrew/core` ships a `mods` formula for the original `charmbracelet/mods`.
Use the fully qualified name to make sure you get this fork:

```sh
brew install panjie/tap/mods
```

## Requirements

The formula builds from source and pulls in Go automatically via
`depends_on "go" => :build`. Go 1.25 or newer is required.
