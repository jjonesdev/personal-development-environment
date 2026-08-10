---
name: jj-code-review
description: Review pull requests, commits, branches, diffs, and working-tree changes for concrete, actionable defects. Use when asked to perform a code review, inspect a changeset for regressions, or produce prioritized P0-P3 findings. Accept an optional profile argument to add domain-specific review rules.
disable-model-invocation: true
---

# JJ Code Review

Review the proposed changes as a senior engineer. Find defects the author would fix before merging. Optimize for signal, not finding volume.

## Select a review reference

The optional reference selector is: `$ARGUMENTS`

- If no selector is supplied, perform the generic review without loading an additional reference.
- If a selector is supplied, require exactly one lowercase slug containing only letters, numbers, and hyphens.
- Read `references/<selector>.md` completely before reviewing and apply it in addition to these rules.
- Treat the reference as additional qualification guidance, not a checklist that requires findings.
- If the reference does not exist, stop and report the unsupported selector along with the available reference filenames.

## Establish context

1. Identify the exact changeset under review.
2. Read applicable repository guidance.
3. Inspect the complete changed functions and surrounding modules.
4. Trace relevant callers, consumers, data flow, and failure paths.
5. Consult tests when they clarify intended behavior.

Do not judge a diff hunk in isolation. Read only as much surrounding code as needed to confirm or reject a candidate issue.

## Qualification bar

Report an issue only when:

1. It materially affects correctness, reliability, security, privacy, performance, accessibility, or maintainability.
2. It is discrete and actionable.
3. It was introduced, exposed, or materially worsened by the changes.
4. It has a realistic triggering path supported by the code.
5. The author would likely fix it if informed.
6. It is not already prevented by validation, error handling, lifecycle management, type guarantees, or documented system behavior.
7. It is clearly not an intentional behavior change.

Do not claim another component may break without identifying the concrete affected path and explaining how it fails.

## Validate findings

Before reporting a candidate:

- Trace the execution path that triggers it.
- Check relevant guards, callers, and fallback behavior.
- Verify assumptions against types, APIs, and system guarantees.
- Check whether equivalent code elsewhere establishes the intended pattern.
- Distinguish newly introduced defects from pre-existing behavior.

If the trigger or impact cannot be demonstrated, drop the finding.

## Assign priority

Assign every finding exactly one priority:

- **P0 — Critical:** Universally blocking. The change causes catastrophic failure regardless of ordinary input assumptions, such as unrecoverable data loss, a broadly exploitable vulnerability, or a release-wide outage. Use rarely.
- **P1 — High:** Fix before merge or the next release. Causes crashes, corruption, security exposure, major functionality failure, or widespread incorrect behavior under realistic conditions.
- **P2 — Normal:** A concrete defect the author would fix that does not make the change broadly unsafe. Use this for ordinary correctness issues.
- **P3 — Low:** A real, localized defect with limited impact. Never use this for style preferences or speculative improvements.

Base priority on impact and likelihood under the stated triggering conditions. Do not inflate priority to compensate for uncertainty.

When the output format accepts numeric priorities, use `0`, `1`, `2`, or `3`. Otherwise, prefix each finding title or description with `[P0]`, `[P1]`, `[P2]`, or `[P3]`.

If the output schema also requires severity, map P0 and P1 to `important`, P2 and P3 to `nit`, and use `pre_existing` only for a directly relevant issue not introduced or worsened by the change.

## Report findings

Return every qualifying issue, but do not create findings to satisfy a quota.

Each finding must:

- Cover one distinct issue.
- Use the shortest useful file and line range.
- Begin with its priority.
- Explain why the behavior is incorrect.
- State the conditions required to trigger it.
- Describe the resulting user or system impact.
- Remain concise and immediately understandable.

Use suggestion blocks only for concrete replacement code. Keep them minimal and preserve indentation exactly.

Do not report formatting, naming preferences, generic best-practice advice, speculative downstream concerns, broad refactors, missing tests by themselves, unrelated pre-existing issues, or intentional behavior changes.

Prefer no findings over low-confidence noise. Do not summarize unaffected code.

This is a read-only review. Do not modify files, post comments to external services, approve, or block the change.
