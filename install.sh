#!/usr/bin/env bash
#
# install.sh — add the electric-zettel workflow to an existing project.
#
# Copies the `go` and `build-skill` skills into <project>/.claude/skills/ so the
# explore -> plan -> garden -> do -> garden loop and its skill-generator are
# available there. The `go` skill bootstraps the ./vault knowledge base on first
# run, so seeding a vault is optional (see --with-vault).
#
# Usage:
#   ./install.sh [options] <project-dir>

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC_SKILLS_DIR="$SCRIPT_DIR/.claude/skills"
SKILLS=(go build-skill)

FORCE=0
WITH_VAULT=0

usage() {
  cat <<'EOF'
install.sh — add the electric-zettel workflow to an existing project.

Copies the `go` and `build-skill` skills into <project>/.claude/skills/ so the
explore -> plan -> garden -> do -> garden loop is available there. The `go` skill
bootstraps the ./vault knowledge base on first run, so seeding a vault is optional.

Usage:
  ./install.sh [options] <project-dir>

Options:
  -f, --force       Overwrite skills that already exist without prompting.
      --with-vault  Also copy the starter vault/ scaffold (skipped if the target
                    already has a vault/ directory).
  -h, --help        Show this help and exit.

Example:
  ./install.sh ~/code/my-project
EOF
}

# --- parse arguments --------------------------------------------------------
POSITIONAL=()
while [ $# -gt 0 ]; do
  case "$1" in
    -f|--force)   FORCE=1; shift ;;
    --with-vault) WITH_VAULT=1; shift ;;
    -h|--help)    usage; exit 0 ;;
    --)           shift; while [ $# -gt 0 ]; do POSITIONAL+=("$1"); shift; done ;;
    -*)           echo "error: unknown option '$1'" >&2; usage >&2; exit 2 ;;
    *)            POSITIONAL+=("$1"); shift ;;
  esac
done

if [ "${#POSITIONAL[@]}" -ne 1 ]; then
  echo "error: expected exactly one <project-dir> argument" >&2
  usage >&2
  exit 2
fi
TARGET="${POSITIONAL[0]}"

# --- validate ---------------------------------------------------------------
if [ ! -d "$TARGET" ]; then
  echo "error: '$TARGET' is not a directory" >&2
  exit 1
fi
TARGET="$(cd -- "$TARGET" && pwd)"   # normalize to an absolute path

if [ "$TARGET" = "$SCRIPT_DIR" ]; then
  echo "error: target is the electric-zettel repo itself — pick a different project" >&2
  exit 1
fi

for skill in "${SKILLS[@]}"; do
  if [ ! -d "$SRC_SKILLS_DIR/$skill" ]; then
    echo "error: source skill '$skill' not found at $SRC_SKILLS_DIR/$skill" >&2
    echo "       run this script from inside a clone of the electric-zettel repo." >&2
    exit 1
  fi
done

# --- install skills ---------------------------------------------------------
DEST_SKILLS_DIR="$TARGET/.claude/skills"
mkdir -p "$DEST_SKILLS_DIR"

for skill in "${SKILLS[@]}"; do
  src="$SRC_SKILLS_DIR/$skill"
  dest="$DEST_SKILLS_DIR/$skill"

  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    if [ -t 0 ]; then
      printf "skill '%s' already exists at %s\n  overwrite? [y/N] " "$skill" "$dest"
      read -r reply || reply=""
      case "$reply" in
        y|Y|yes|YES) ;;
        *) echo "  skipped $skill"; continue ;;
      esac
    else
      echo "skill '$skill' already exists — skipped (use --force to overwrite)"
      continue
    fi
  fi

  rm -rf "$dest"
  cp -R "$src" "$dest"
  echo "installed skill: $skill -> ${dest#"$TARGET"/}"
done

# --- optionally seed the vault ----------------------------------------------
if [ "$WITH_VAULT" -eq 1 ]; then
  if [ -e "$TARGET/vault" ]; then
    echo "vault/ already exists in target — left untouched"
  else
    cp -R "$SCRIPT_DIR/vault" "$TARGET/vault"
    echo "installed starter vault scaffold: vault/"
  fi
fi

# --- next steps -------------------------------------------------------------
cat <<EOF

Done. From within '$TARGET':
  claude            # then run the /go skill to start a session

The /go skill bootstraps ./vault on first run if it does not exist yet.
Create specialized skills with:  /build-skill <name> - <goal>
EOF
