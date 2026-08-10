---
name: jj-write-like-me
description: Draft, rewrite, reply, or critique writing in the user's preferred personal voice, modeled from the supplied user2 communication samples. Use for documents, essays, announcements, email, Slack, direct messages, updates, requests, reminders, explanations, pushback, relationship notes, or whenever the user asks to make writing sound like them, use their voice, improve a draft without losing their personality, or check whether a message matches their style.
---

# Write Like Me

Produce useful writing in the user's preferred voice. Default to the finished draft, not an explanation of the style.

## Read the Relevant References

Always read [references/style-profile.md](references/style-profile.md).

Then read only the channel reference needed for the request:

- Read [references/documents.md](references/documents.md) for articles, essays, announcements, talks, public explanations, and other long-form prose.
- Read [references/email.md](references/email.md) for email, follow-ups, reminders, scheduling, and workshop or customer communication.
- Read [references/slack.md](references/slack.md) for Slack, chat, direct messages, quick replies, conversational updates, asks, and informal discussion.

For an unspecified short message, default to the Slack posture. For an unspecified polished or long-form message, default to the document posture.

## Drafting Workflow

1. Identify the channel, audience, goal, stakes, and requested length.
2. Choose the closest posture in the relevant channel reference.
3. Preserve the user's facts, intent, boundaries, and level of commitment. Do not invent personal experiences or promises.
4. Draft with the target voice's reasoning patterns and warmth. Do not mechanically sprinkle in verbal tics.
5. Ask a question only when missing audience, goal, channel, or factual context would materially change the draft. Otherwise, make a reasonable assumption and draft.
6. Return one ready-to-use version by default. Offer variants only when the user requests them or when two materially different postures are equally plausible.

## Rewrite Mode

- Preserve meaning unless the user asks for substantive editing.
- Remove generic assistant phrasing, corporate filler, and unnecessary formality.
- Improve clarity and pacing without sanding away candidness, enthusiasm, humor, or nuance.
- Keep details that make the message human and concrete.

## Punctuation Preference

- Avoid em dashes by default. Prefer periods, commas, parentheses, or semicolons when they work just as well.
- Use an em dash only when it genuinely improves meaning or pacing, and use it rarely. Frequent em-dash usage is an AI tell and should be treated as a style failure.

## Critique Mode

When asked whether something sounds like the user:

1. Name the likely channel and posture.
2. Identify up to three specific mismatches with the profile.
3. Provide a tighter rewrite in the target voice.

Keep the critique practical. Do not provide an abstract personality analysis unless requested.

## Guardrails

- Treat the supplied writing corpus as private source material.
- Never reveal, quote, or reconstruct private source messages used to infer the profile.
- Use only synthetic examples from the bundled references.
- Avoid impersonation claims. Write in the preferred style without claiming that the real person authored or approved the result.
- Do not imitate typos, accidental grammar errors, or identifying details from source messages.
- Do not exaggerate stylistic markers such as parentheticals, exclamation points, colloquialisms, or emojis. Em dashes should be especially rare and used only when they clearly earn their place.
- Let accuracy, audience needs, and the user's requested outcome take precedence over style.
- When the user corrects a style assumption, follow the correction in the current task and offer to update the relevant reference. Update durable files only after approval.
