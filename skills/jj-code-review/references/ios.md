# iOS Review Reference

Apply these rules when reviewing an iOS application, framework, extension, test target, build configuration, or an interface consumed by iOS code. In a mixed repository, apply them only to affected iOS paths and their boundaries. Confirm findings against the project's deployment targets, architecture, and established conventions.

## Swift concurrency

Check for concrete failures involving:

- UI state accessed or mutated outside the main actor.
- Incorrect actor-isolation crossings or unsafe non-`Sendable` values.
- Unstructured tasks outliving the object or operation that created them.
- Missing cancellation when obsolete work can still mutate state or produce side effects.
- Continuations resumed more than once or never resumed.
- Races between tasks, callbacks, delegates, publishers, or lifecycle events.
- Synchronous work blocking the main actor.

Account for inherited actor context and existing isolation guarantees before reporting.

## Lifecycle and ownership

Look for:

- Closures, delegates, observers, publishers, timers, or tasks retaining owners unexpectedly.
- Callbacks reaching dismissed, reused, deallocated, or stale UI.
- Resources not cleaned up at the appropriate lifecycle boundary.
- Work started during appearance that repeats unintentionally or survives disappearance.
- Incorrect handling of scene activation, backgrounding, restoration, or termination.
- `weak` or `unowned` references whose lifetime assumptions can realistically fail.

Do not require weak captures mechanically. Report a capture only when it creates a demonstrated cycle or unsafe lifetime.

## SwiftUI

Check for:

- Conflicting sources of truth or incorrect property-wrapper ownership.
- Unstable identity causing lost state, wrong row reuse, or unexpected replacement.
- Side effects performed from `body`.
- Repeated work from `task`, `onAppear`, or observation without appropriate identity or cancellation.
- Navigation or presentation state that can become inconsistent.
- Asynchronous results updating state after their input, destination, or owner changes.
- Expensive work repeated during view recomputation.

Do not treat normal SwiftUI view-value recreation as a lifecycle defect.

## UIKit

Check for invalid lifecycle or presentation timing, broken view-controller containment, cell reuse bugs, inconsistent data-source snapshots, off-main-thread UI mutations, callbacks surviving their owner, and reusable views that fail to reset old state.

## Persistence and networking

Look for:

- Incompatible `Codable` or stored-data schema changes.
- Missing Core Data or SwiftData migration handling.
- Managed objects or model contexts used from invalid executors or queues.
- Partial writes, lost updates, or inconsistent cache state.
- Incorrect Keychain, `UserDefaults`, or file-protection behavior.
- Duplicated or unsafe retries that violate idempotency.
- Offline or reconnection paths that corrupt, discard, or incorrectly replay state.
- Incorrect `URLSession` cancellation, validation, or decoding.
- Stale responses overwriting newer user state.

## Platform integration

Check for APIs unavailable at the deployment target; incomplete availability checks; missing permissions, usage descriptions, entitlements, or capabilities; broken links, notifications, background tasks, app extensions, or scene routing; and build or dependency changes that break supported architectures or configurations.

Do not report missing availability checks when the deployment target already guarantees the API.

## Security and privacy

Require a plausible exposure path when checking for secrets or personal data in logs, sensitive values outside appropriately configured Keychain or protected files, unsafe URL or web-view handling, weakened transport security, excessive permissions, or sensitive information exposed through notifications, pasteboard, snapshots, or diagnostics.

## Performance and energy

Report only user-impacting regressions such as blocking work on the main actor, unbounded collections or task creation, repeated requests or expensive rendering work, high-frequency background activity without a valid lifecycle, and oversized media decoded or retained without appropriate sizing.

Do not report micro-optimizations without observable impact.

## Accessibility and localization

Check for controls that lose usable labels, traits, actions, focus, or hit targets; content unusable with Dynamic Type or assistive technologies; meaning conveyed only through color; incorrect localized strings or formatting; and layouts that fail with longer translations or right-to-left presentation.

Report concrete usability failures, not generic requests to improve accessibility.
