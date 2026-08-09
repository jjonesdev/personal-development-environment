#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="${repo_dir}/skills"
codex_skills_dir="${HOME}/.agents/skills"
claude_config_dir="${CLAUDE_CONFIG_DIR:-${HOME}/.claude}"
claude_skills_dir="${claude_config_dir}/skills"

link_skill() {
  local source_path="$1"
  local target_dir="$2"
  local tool_name="$3"
  local skill_name
  local target_path

  skill_name="$(basename -- "${source_path}")"
  target_path="${target_dir}/${skill_name}"

  mkdir -p "${target_dir}"

  if [[ -L "${target_path}" || -e "${target_path}" ]]; then
    if [[ "${target_path}" -ef "${source_path}" ]]; then
      echo "${tool_name}: ${skill_name} is already linked."
      return
    fi

    echo "${tool_name}: skipping ${skill_name}; ${target_path} already exists and was left unchanged." >&2
    return
  fi

  ln -s "${source_path}" "${target_path}"
  echo "${tool_name}: linked ${target_path} -> ${source_path}."
}

skill_count=0

for skill_dir in "${skills_dir}"/*; do
  [[ -d "${skill_dir}" ]] || continue

  if [[ ! -f "${skill_dir}/SKILL.md" ]]; then
    echo "Skipping ${skill_dir}: missing SKILL.md." >&2
    continue
  fi

  skill_count=$((skill_count + 1))
  link_skill "${skill_dir}" "${codex_skills_dir}" "Codex"
  link_skill "${skill_dir}" "${claude_skills_dir}" "Claude"
done

if [[ "${skill_count}" -eq 0 ]]; then
  echo "No managed skills found in ${skills_dir}."
fi
