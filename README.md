# Olostep CLI (staging)

Install or update (macOS or Linux, Node.js 22.18 or newer):

```
curl -fsSL https://raw.githubusercontent.com/samyakkkk/olostep-cli/main/install.sh | sh
```

It installs into `~/.olostep` without sudo and makes `olostep` available on PATH. If prompted, open a new terminal. Then run:

```
olostep
```

Choose **Sign in** to connect your Olostep account. You can also run `olostep auth login` directly. Product commands require sign-in; help and feedback are available while signed out.

```sh
olostep auth status
olostep scrape example.com -f markdown --dry-run
olostep scrape example.com -f markdown
olostep search "your query"
olostep --help
```

`auth status` shows your account, team, plan and credit balance. `--dry-run` previews a command without executing it. Scraping, searching and other jobs use your normal Olostep credits. Add `--json` for scripts.

Run the install command again to update. This build uses Olostep's staging server. Remove another existing `olostep` installation before using this installer.

To uninstall: `npm uninstall --global --prefix "$HOME/.olostep" olostep`.
