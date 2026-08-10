---
name: ios-debugger-agent
description: Use XcodeBuildMCP to build, run, launch, and debug the current iOS project on a simulator. Trigger when asked to run an iOS app, interact with the simulator UI, inspect on-screen state, capture logs/console output, or diagnose runtime behavior using XcodeBuildMCP tools.
---

# iOS Debugger Agent

## Overview
Use XcodeBuildMCP to build and run the current project scheme on an iOS simulator, interact with the UI, and inspect the runtime logs captured by build-and-run or launch operations. Prefer the MCP tools for simulator control, logs, and view inspection.

## Core Workflow
Follow this sequence unless the user asks for a narrower action.

### 1) Inspect defaults and discover a simulator
- Call `mcp__XcodeBuildMCP__session_show_defaults` before the first build, run, or test action.
- If the simulator default is missing or wrong, call `mcp__XcodeBuildMCP__list_sims` and select the requested simulator. Prefer an already booted simulator when the user has not requested a specific device.

### 2) Set session defaults
- Call `mcp__XcodeBuildMCP__session_set_defaults` with:
  - `projectPath` or `workspacePath` (whichever the repo uses)
  - `scheme` for the current app
  - `simulatorId` from the booted device
  - Optional: `configuration: "Debug"`, `useLatestOS: true`

### 3) Build + run (when requested)
- Call `mcp__XcodeBuildMCP__build_run_sim`.
- **If the build fails**, check the error output and retry (optionally with `preferXcodebuild: true`) or escalate to the user before attempting any UI interaction.
- **After a successful build**, verify the app launched by calling `mcp__XcodeBuildMCP__snapshot_ui` or `mcp__XcodeBuildMCP__screenshot` before proceeding to UI interaction.
- If the app is already built and only launch is requested, use `mcp__XcodeBuildMCP__launch_app_sim`.
- If bundle id is unknown:
  1) `mcp__XcodeBuildMCP__get_sim_app_path`
  2) `mcp__XcodeBuildMCP__get_app_bundle_id`

## UI Interaction & Debugging
Use these when asked to inspect or interact with the running app.

- **Inspect UI**: `mcp__XcodeBuildMCP__snapshot_ui` before tapping, typing, or swiping. Refresh it after navigation, scrolling, sheet changes, or obvious layout changes.
- **Tap**: `mcp__XcodeBuildMCP__tap` with an actionable `elementRef` from the latest UI snapshot.
- **Type**: `mcp__XcodeBuildMCP__type_text` with a current field `elementRef`.
- **Gestures**: `mcp__XcodeBuildMCP__gesture` for common scrolls and edge swipes.
- **Screenshot**: `mcp__XcodeBuildMCP__screenshot` for visual confirmation.

## Logs & Console Output
- `mcp__XcodeBuildMCP__build_run_sim` and `mcp__XcodeBuildMCP__launch_app_sim` capture runtime logs automatically and return the log file path.
- Read or search that artifact and summarize the relevant lines. Preserve the full log path in the response so the user can inspect it directly.

## Troubleshooting
- If build fails, ask whether to retry with `preferXcodebuild: true`.
- If the wrong app launches, confirm the scheme and bundle id.
- If UI elements are not hittable, refresh `snapshot_ui` and use an actionable `elementRef` from the new snapshot.
