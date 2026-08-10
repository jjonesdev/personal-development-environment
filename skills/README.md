# Managed Skills

Each immediate subdirectory is one shared agent skill and must contain a
`SKILL.md` file. Keep the skill compatible with the open Agent Skills format so
the same source works in both Codex and Claude Code.

```text
skills/
└── example-skill/
    ├── SKILL.md
    ├── scripts/      # optional
    ├── references/   # optional
    └── assets/       # optional
```

After adding a skill, run `../scripts/update-skills.sh` from this directory or
`./scripts/update-skills.sh` from the repository root. The script links each
skill into the personal skills directories for Codex and Claude Code.

The updater is additive. It creates missing links but never replaces or deletes
an existing skill or skills directory. A same-named existing skill is reported
and skipped.

This repository is public. Do not commit work-specific instructions, secrets,
or proprietary reference material. A local-only skill can live here without
being committed if its directory is added to `.git/info/exclude`.
