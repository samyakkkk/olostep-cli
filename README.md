# olostep CLI (staging test build)

Install or update (macOS or Linux, Node.js 22.18 or newer):

```
curl -fsSL https://raw.githubusercontent.com/samyakkkk/olostep-cli/main/install.sh | bash
```

It installs into `~/.olostep` (no sudo) and adds it to your PATH. Then, in a new terminal:

```
olostep auth login
olostep --help
olostep chat "What is my credit balance?"
```

Run the same install command again to get the latest build. This build talks to Olostep's staging server.

To remove it: `rm -rf ~/.olostep` and delete the `# olostep CLI` lines from your shell profile.
