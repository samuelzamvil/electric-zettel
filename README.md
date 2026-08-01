# Electric Zettel

This project is an abstract version of the workflow that I have been using for [Claude Code](https://code.claude.com/docs/en/quickstart). For long-running projects, it keeps a compact, self-enriching map of current project state and relationships that LLM agents can consult before rediscovering the same structure. To make that map browsable and selectively ingestible, it uses the [digital gardening approach](https://maggieappleton.com/garden-history). The vault is created and maintained for agent use.

Electric Zettel is deliberately not a task tracker. Projects can keep plans, status, history, evidence, tickets, and documentation in whatever systems they already use. The vault concentrates on current concepts, ownership, dependencies, data flow, boundaries, invariants, current design rationale that constrains future changes, entry points, and durable gotchas.

## AI Disclaimer

This project began as a hand-authored description of a workflow whose skills were adapted from LLM-authored skills refined in other projects. Its documentation and skills may now include both human and LLM-authored revisions.

## The Workflow

When `/garden` is invoked for starting, continuing, completing, resolving, closing, cleaning up, or handing off project work, the agent will:

1. Explore the vault starting at the entrypoint `vault/README.md` and follow wikilinks to find relevant information, then explore the code or system being operated on to confirm with the ground truth.
2. Verify any vault claims that the work depends on.
3. Garden stale state or missing durable relationships before acting.
4. Form and review an approach proportionate to the work without storing it in the vault.
5. Execute the requested work using the project's existing workflow.
6. Verify the resulting project state.
7. Perform a final garden pass before declaring the work finished or handing it off.

Both garden passes are mandatory checks, but they do not manufacture edits. If the vault already matches reality and the work produces no durable knowledge change, the correct result is a verified no-edit pass.

Vault pages describe current project state rather than session history. Wikilinks connect concepts only when the relationship helps future agents navigate or reason about the project; the workflow does not create speculative stubs or add links merely because an agent consulted something.

The completion words above refer to completing the local knowledge lifecycle. They do not authorize external status changes or destructive cleanup.

## Exploring the Vault

I generally do not explore the notes created by the LLM, but if you want you can explore the vault that is created using Obsidian. Just open the `vault` folder as an Obsidian vault.

<img width="1280" height="955" alt="image" src="https://github.com/user-attachments/assets/f2c6818c-b4a5-4934-8790-4a45b9663e19" />

## Using This Project

### `/garden` Skill

The main skill of this project interfaces with the vault workflow. Here's an example:

```
/garden initialize a new artifact "light-map" and research publically available databases for light pollution data. Download the data and create a Svelte project using mapbox that shows a light pollution heatmap for the United States
```

Assuming you have already been using this skill for a while in a project, your prompts can become much more terse:

```
/garden the heatmap has a bug where it becomes blocky when zoomed in, can you fix it?
```

### `/build-skill` Skill

Sometimes you want something much more specific for a given project or use case. `/build-skill` creates a self-contained workflow that retains the same state-gardening lifecycle without adding plans, work logs, or task status to the vault. Using the example from the previous section you could:

```
/build-skill lightmap - create and review features for the lightmap application, reuse verified existing patterns, ask for user input before revising review findings, and finish by reconciling the project vault with the verified result
```

Once this is done, you can interface with the new skill:

```
/lightmap please add the ability to search for an address
```

## Installation

### Existing Project

If you already have a project you want to add this functionality to, either copy the skills in this project directly or run the included `install.sh` command:

```sh
./install.sh /path/to/project
```

### Upgrading an existing installation

The primary skill is now named `/garden`. After upgrading, remove the old
`.claude/skills/go/` directory once you have preserved any local customization; the installer
warns but does not delete it. The installer replaces selected skills but never rewrites an existing `vault/`. Older vaults may
therefore retain plan records or instructions encouraging dense and dangling links. Preserve that
material until you choose where its history belongs, but remove obsolete instructions from the
MOC before relying on the new workflow. The `/garden` skill treats legacy plans and logs as
historical artifacts rather than current-state input and will not modify or delete them
automatically. `install.sh` prints a warning when it recognizes this legacy shape.

### New Project

You can alternatively just clone this project and start using it without installing it anywhere. This is nice for a greenfield project, or if you just want to test drive this workflow. Just `git clone` and start using `claude` with the `/garden` skill.
