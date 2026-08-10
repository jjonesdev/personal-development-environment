#!/usr/bin/env bash

set -euo pipefail

server_name="XcodeBuildMCP"
server_command=(xcodebuildmcp mcp)
enabled_workflows="simulator,debugging,ui-automation"

if ! command -v xcodebuildmcp >/dev/null 2>&1; then
  echo "XcodeBuildMCP: xcodebuildmcp is not installed; run ./install.sh first." >&2
  exit 1
fi

register_codex_server() {
  if ! command -v codex >/dev/null 2>&1; then
    echo "Codex: not installed; skipped ${server_name}."
    return
  fi

  if codex mcp get "${server_name}" >/dev/null 2>&1; then
    echo "Codex: ${server_name} already exists and was left unchanged."
    return
  fi

  codex mcp add --env "XCODEBUILDMCP_ENABLED_WORKFLOWS=${enabled_workflows}" \
    "${server_name}" -- "${server_command[@]}"
  echo "Codex: registered ${server_name}."
}

register_claude_server() {
  if ! command -v claude >/dev/null 2>&1; then
    echo "Claude: not installed; skipped ${server_name}."
    return
  fi

  if claude mcp get "${server_name}" >/dev/null 2>&1; then
    echo "Claude: ${server_name} already exists and was left unchanged."
    return
  fi

  claude mcp add --scope user "${server_name}" \
    --env "XCODEBUILDMCP_ENABLED_WORKFLOWS=${enabled_workflows}" \
    -- "${server_command[@]}"
  echo "Claude: registered ${server_name}."
}

register_codex_server
register_claude_server
