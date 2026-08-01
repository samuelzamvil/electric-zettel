---
name: build-skill
description: Generate or update a self-contained Claude skill for a recurring project workflow while preserving verified project-state gardening. Use when asked to build a specialized skill whose implementation, investigation, review, completion, resolution, cleanup, or handoff should explore, verify, garden, plan, execute, verify again, and perform a final garden without adding task tracking or history to the vault.
---

# build-skill — generate a state-gardening workflow

Turn a named recurring job into a self-contained skill. Every generated skill specializes the
job while preserving the project-state lifecycle:

**explore → verify → garden → plan → do → verify → final garden**

The generated skill may compose with any planning, ticketing, documentation, or coordination
system. It must not duplicate those systems in `./vault`.

## Invocation contract

```text
/build-skill <name> - <goal / type of work>
```

- Split on the first ` - `.
- Slugify `<name>` to lowercase kebab-case for the directory and frontmatter name.
- Treat `<goal>` as both the deliverable and the basis for natural-language trigger phrases.
- If either half is missing, ask for it rather than guessing.

## Generate the skill

### 1. Explore

- Bootstrap `vault/README.md` if `vault/` is absent. Do not create plan or log directories.
- Read the MOC and the smallest relevant set of concept pages.
- Read `.claude/skills/garden/SKILL.md` when present.
- Inspect the existing target skill, if any. Confirm before overwriting it.

### 2. Design the specialization

Determine:

- the workflow's scope and first project entry points;
- what must be verified before acting;
- which current concepts and relationships help narrow discovery;
- the concrete deliverable;
- checks that verify the result;
- what durable state might need gardening before and after the work;
- user-input or authorization points required by the goal;
- phrases that should trigger the skill when work starts, continues, finishes, resolves, closes,
  cleans up, or is handed off.

Do not invent task-management, documentation, or external-system conventions that the goal does
not supply.

### 3. Write a self-contained skill

Create `.claude/skills/<name>/SKILL.md` containing:

1. Frontmatter with only `name` and `description`.
2. A concise statement of the specialized goal.
3. The complete specialized lifecycle: explore, verify, garden, plan, do, verify, final garden.
4. The vault rules and exclusions below.
5. The goal-specific entry points, deliverable, validation, and authorization boundaries.

Do not make the generated skill merely refer to `garden`; it must remain usable on its own.

The description is the trigger surface. State what the skill does and include natural completion
language where appropriate: complete, finish, resolve, close, clean up, wrap up, and hand off.
These phrases trigger the final garden pass; they do not authorize external status changes,
deletion, discarded work, or Git-history rewriting.

### 4. Preserve the vault contract

Every generated skill must instruct the agent to:

- read `vault/README.md` before broad project discovery;
- follow only the smallest relevant set of `[[wikilinks]]`;
- verify load-bearing vault claims against current project reality;
- correct discovered drift before acting;
- form and review an approach proportionate to the work without storing it in the vault;
- execute the specialized work under the project's own instructions;
- verify the result;
- perform a final garden pass before completion or handoff;
- report a valid no-edit garden pass when the vault was already accurate.

Every generated skill must keep the vault limited to concise current concepts, ownership,
dependencies, data flow, boundaries, invariants, current design rationale that constrains future
changes, entry points, and durable gotchas.

Every generated skill must exclude:

- plans, work logs, task status, session histories, handoffs, backlogs, roadmaps, and TODO lists;
- citations, historical decision provenance, justification trails, and lists of consulted material;
- ticket, issue, PR, wiki, or external-document links added merely as references;
- generic documentation, secrets, and credentials;
- speculative stubs and links created only to increase graph density.

Every generated skill must treat plan indexes, work logs, histories, and obsolete linking rules
found in older vaults as legacy artifacts. It must not read them as current-state input or modify,
move, or delete them without maintainer direction.

### 5. Garden the new current state

After creating the skill:

- add or update a vault concept only if the new skill itself is durable project structure that
  future agents need to navigate;
- otherwise leave the vault unchanged and record that the final garden check found no durable
  state to add;
- update the MOC only when a durable concept page was added or removed.

Tell the user which skill was created and how to invoke it.

## Generated skill style

- Use imperative language.
- Keep the skill concise and specific to its recurring job.
- Put all trigger information in the frontmatter description.
- Preserve the current-state model; never turn the vault into an audit trail.
- Include portable relative paths only. Do not include personal names, machine names, absolute
  home paths, or assumptions about a particular task-management system.

## Failure modes

- Do not drop either garden pass.
- Do not require a vault edit when verification found no durable change.
- Do not generate plan persistence, status tracking, work logs, or history.
- Do not overlink or create a page solely because the agent consulted something.
- Do not let completion language bypass verification and the final garden pass.
- Do not overwrite an existing skill without confirmation.
