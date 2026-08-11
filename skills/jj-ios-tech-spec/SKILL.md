---
name: jj-ios-tech-spec
description: Write a typed iOS call-stack architecture handoff.
disable-model-invocation: true
---

# iOS Tech Spec

An iOS tech spec is a **typed call-stack architecture handoff**: code-shaped contracts plus execution flows. Prefer Swift pseudocode over prose wherever precision matters.

This skill is design-only. Do not implement. Save a file only when the user asks for a file; otherwise return the spec inline.

## Branch selection

1. Use **Path A: Convert context to spec** when the conversation, docs, or codebase already contain enough background to describe the change.
2. Use **Path B: Grill first** when the user wants a new spec but has not provided enough problem, constraints, design direction, affected code, or acceptance criteria.

If a question can be answered by exploring the codebase, inspect the codebase instead of asking.

Completion criterion: the branch is chosen from actual available context; missing architectural decisions are not invented.

## Path A: Convert context to spec

### 1. Load standards and local context

Inspect existing code and docs for local vocabulary, target and module layout, domain concepts, errors, protocols, adapters, observability, app lifecycle and concurrency patterns, UI architecture, persistence, networking, and test style.

Completion criterion: the spec uses project vocabulary and does not introduce a pattern, library, protocol, adapter, persistence model, navigation approach, or test strategy before checking local precedent.

### 2. Extract the design problem

Capture:

- current state;
- problem;
- users/callers;
- goals;
- non-goals;
- constraints;
- invariants;
- affected features, targets, and platform services;
- likely app, scene, view, or deep-link entrypoints;
- lifecycle, concurrency, performance, and runtime concerns;
- risks;
- open questions.

Mark unknowns as open questions instead of filling gaps with plausible design.

Completion criterion: every claimed requirement or constraint is grounded in conversation, code, docs, or an explicit open question.

### 3. Explore design alternatives

Produce materially different alternatives before choosing the recommended design. Alternatives should differ in API shape, seam placement, ownership, call stack, state-management topology, target boundaries, or module boundaries — not just names.

For each alternative, sketch:

- domain types and state model;
- public/module protocols and APIs;
- input/output types;
- expected failure types;
- seams, boundaries, and adapters;
- user-action-or-lifecycle-entrypoint-to-side-effect call stack;
- decoding, mapping, and view-state projection strategy;
- authorization, permissions, privacy, observability, task cancellation, idempotency, persistence transactions, and background execution when reachable;
- test seam strategy;
- tradeoffs.

Compare alternatives on:

- caller burden;
- module depth and leverage;
- locality of invariants and change;
- seam placement;
- boundary decoding and projections;
- error and cancellation model;
- actor isolation and data-race safety;
- testability through real seams;
- app lifecycle and platform fit;
- implementation complexity.

Completion criterion: the recommendation is chosen after comparing alternatives, not before.

### 4. Specify the recommended typed contracts

For the recommended design, outline every new, changed, or deleted:

- domain value;
- refined or validated type;
- enum or state machine variant;
- input/output type;
- request/response type;
- function signature;
- struct, actor, class, or module interface;
- protocol;
- expected-failure or custom `Error` type;
- adapter protocol;
- network or transport DTO;
- persistence model/projection;
- runtime-boundary decoder;
- public API.

Name seams, adapters, implementations, ownership boundaries, actor isolation, and what crosses each boundary. State what each layer may know and what must not leak across the seam.

Completion criterion: every new or changed boundary has a concrete type/protocol/API sketch, or an explicit reason no new contract is needed.

### 5. Specify call stacks and data flow

For every new, changed, or deleted behavior, show the call stack from user action, app lifecycle event, deep link, notification, or other entrypoint to side effects and rendered state.

Include type/data flow:

```txt
raw event / input
  -> platform payload / boundary DTO
  -> decoder
  -> canonical domain/application input
  -> feature or use-case interface
  -> adapter call
  -> typed result/error
  -> view-state projection
  -> SwiftUI/UIKit rendering
```

Include current vs proposed flow when changing existing behavior. Include failure, retry, task cancellation, actor hops, persistence transactionality, idempotency, observability, authorization/permissions, app lifecycle, and background-execution flow when reachable.

Completion criterion: every affected behavior has an end-to-end call stack and type/data-flow trace.

### 6. Map files and modules

List:

- Swift files, targets, packages, or modules to add;
- Swift files, targets, packages, or modules to change;
- Swift files, targets, packages, or modules to delete, if any;
- unit, integration, snapshot, or UI test files;
- asset, entitlement, `Info.plist`, build setting, migration, or runtime configuration files, if any.

For each file, state the contract, code path, boundary, adapter, domain concept, UI responsibility, or test responsibility it owns.

Completion criterion: every contract and call-stack step maps to a file/module or an open question.

### 7. Write the RGR TDD test plan

Use the sibling TDD workflow and testing standards. Plan vertical Red-Green-Refactor slices: one failing behavior test, minimal implementation, repeat. Do not write a horizontal "all tests first, all code later" plan.

Favor behavior through public interfaces and real seams over implementation-coupled mocks.

Use Swift Testing or XCTest according to local project precedent. Cover proportionately:

- happy paths;
- failure paths;
- decoder rejection and accepted payloads;
- domain invariants and state transitions;
- adapter contracts;
- persistence, concurrency, and lifecycle semantics;
- cancellation, retry, idempotency, and background-execution paths;
- actor isolation and `Sendable` boundary behavior where relevant;
- observability and privacy-safe summaries where relevant;
- end-to-end or UI flows for high-consequence behavior.

Completion criterion: every public behavior, invariant, important failure path, changed boundary, and changed seam has a red test slice or an explicit reason not to test it.

### 8. Produce the spec

Return the spec inline unless the user requested a file path. If a file was requested, save it there.

Do not implement and do not ask to implement by default.

Completion criterion: the output follows the outline below and is implementation-ready for another iOS engineer.

## Path B: Grill first

1. Do not write a full spec yet.
   - State that there is not enough context for an implementation-ready iOS tech spec.
   - Completion criterion: the agent has not invented requirements, APIs, files, or call stacks.
2. Start a grilling interview.
   - Ask one question at a time and provide the recommended answer with each question.
   - If a question can be answered by exploring the codebase, inspect the codebase instead of asking.
   - Completion criterion: the interview has enough context for Path A: problem, users/callers, constraints, affected features and targets, desired behavior, boundaries, likely APIs, invariants, lifecycle and concurrency concerns, risks, and acceptance tests.
3. Convert to the spec.
   - Once grilling context is sufficient, run Path A.
   - Completion criterion: the final artifact is a typed iOS call-stack architecture handoff, not interview notes.

## Required spec outline

Use this shape unless the task is tiny enough to compress without losing contracts or call stacks:

```md
# <Title>

## Summary

## Context / Current State

## Goals

## Non-Goals

## Invariants

## Design Constraints

## Alternatives Considered

### Option 1: <name>

### Option 2: <name>

### Option 3: <name>

## Recommendation

## Proposed Design

## Domain Model and Types

## Types, Protocols, and APIs

## Seams, Boundaries, Adapters, and Implementations

## Call Stacks and Data Flow

### Current / Old Flow

### Proposed / New Flow

### Failure Flow

### Retry / Cancellation / Idempotency Flow

### Actor Isolation / App Lifecycle / Background Execution Flow

### Observability Flow

## Files to Add / Change / Delete

## RGR TDD Test Plan

## Risks and Open Questions
```

Omit sections that truly do not apply, but do not omit typed contracts, seams, call stacks, or tests merely because they are hard to specify.

## Writing rules

- Code first: Swift pseudocode defines contracts, APIs, and data flow.
- Prose explains why; types and call stacks define what changes.
- Focus on types, protocols, APIs, inputs/outputs, seams, boundaries, feature modules, domain modules, use cases, platform adapters, and call stacks.
- Prefer precise domain values and enums over strings, booleans, loosely shaped dictionaries, and unnecessary optionals.
- Make isolation explicit: identify `@MainActor`, actor-isolated, `nonisolated`, and `Sendable` boundaries when concurrency is reachable.
- Keep seams real: adapters translate UI frameworks, persistence, networking, time, randomness, telemetry, app lifecycle, notifications, background tasks, or other Apple platform boundaries.
- Avoid speculative abstraction; every seam earns its existence through invariants, locality, leverage, testing, or a real boundary.
- Keep a single source of truth; do not restate the same rule in multiple sections unless one section points to the other.
- Unknowns stay open questions. Do not invent product requirements, domain rules, APIs, UI behavior, or call stacks to make the spec feel complete.
