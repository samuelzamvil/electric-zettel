---
name: go
description: Maintain verified project state and relationship memory while starting, continuing, completing, resolving, closing, cleaning up, or handing off project work. Use for implementation, investigation, fixes, reviews, and other project work so each session explores, verifies, gardens, executes, verifies again, and performs a final garden that leaves local knowledge consistent with the project.
---

# go — project state gardening

Maintain a project-local knowledge garden at `./vault/`. The vault gives future agents a compact
map of the project's current concepts, relationships, boundaries, invariants, and durable gotchas.
It is not a task tracker, work log, decision archive, or substitute for the project's existing
systems.

Every invocation runs this lifecycle:

**explore → verify → garden → do → verify → final garden**

- **explore** — read the relevant map before searching the project broadly.
- **verify** — confirm load-bearing vault claims against the current project.
- **garden** — correct the map before acting when exploration found drift or a durable gap.
- **do** — perform the requested work using the project's own workflow.
- **verify** — check the resulting project state.
- **final garden** — reconcile the vault with that result before finishing or handing off.

Both garden passes are required checks. They may correctly produce no edit when the vault already
matches reality and the session learned no durable project fact.

## Vault shape

- Keep concept pages directly in `vault/`. Filenames mirror Obsidian links: `Build System.md`
  is the target of `[[Build System]]`.
- Use `vault/README.md` as the small map of content (MOC).
- Describe current state, not how it became current.
- Link project concepts when the relationship helps an agent navigate or reason about the project.
- Prefer verified relationships such as ownership, dependency, data flow, boundaries, invariants,
  workflow entry points, and recurring gotchas.
- Keep pages short enough that following a few links costs less context than rediscovering the
  same structure.

Do not maximize link count. Do not create dangling links as speculative TODOs. Add a link only
when the relationship is current, useful, and supported by the project.

## Lifecycle

### 0. Bootstrap

If `vault/` is absent, create `vault/README.md` with:

- a one-sentence project description;
- brief usage rules;
- empty sections suited to the project's current concepts.

Do not create plans, logs, histories, registries, or speculative concept pages during bootstrap.

### 1. Explore

Read `vault/README.md` first. Select the smallest relevant set of concept pages, normally one to
five, and follow only links that materially help with the request. Then inspect the project
artifacts that can confirm the map.

The vault narrows discovery; it never overrides current reality or project instructions.

### 2. Verify before relying

Verify every vault claim that is load-bearing for the current work. Use the nearest source of
truth available in the project: code, configuration, generated output, tests, or observable
behavior.

If the project disagrees with the vault, trust the project and correct the vault before acting.
If the claim cannot be verified, label the uncertainty only when it is still useful; otherwise
remove it.

### 3. Garden before acting

Reconcile durable knowledge learned during exploration:

- replace stale facts rather than appending updates;
- add a missing concept or relationship only when it improves future navigation or reasoning;
- remove obsolete or misleading relationships;
- merge duplicate concepts instead of preserving parallel explanations;
- update `vault/README.md` when the map's useful entry points change.

Do not garden merely to record what this session read or plans to do.

### 4. Do

Perform the requested work. Follow the project's own instructions and use its existing systems
for planning, task management, history, evidence, and coordination.

### 5. Verify the result

Run checks proportionate to the work and inspect the resulting state. Distinguish verified facts
from assumptions before the final garden pass.

### 6. Final garden — always

Before declaring work complete, resolved, closed, clean, or ready for handoff, reconcile the vault
with the verified result:

- update concepts and relationships changed by the work;
- remove facts, links, stubs, and gotchas that are no longer true or useful;
- capture newly discovered durable boundaries, invariants, entry points, or gotchas;
- check that every edited page describes current state rather than session history;
- keep the MOC accurate and compact.

Here, **clean** means that local project knowledge is internally consistent with the resulting
project. It does not authorize deleting files, discarding changes, rewriting Git history, or
performing any other destructive cleanup.

If the final pass produces no vault edit, state that the existing map was checked and remains
accurate. If it produces edits, briefly name the pages changed.

## Page style

- Start with `# Page Name`, matching the filename.
- Lead with what the concept is in this project.
- Prefer concise, concrete statements and inline `[[wikilinks]]` where relationships matter.
- Use paths, commands, identifiers, and values only when they describe durable current state.
- Mark meaningful uncertainty plainly; remove it once resolved.
- Replace stale content in place. Never append changelog-style “Update” sections.
- Keep short pages short. Do not add sections mechanically.
- Do not use decorative headings, emoji, or marketing language.

## Exclusions

Never put these in the vault:

- plans, task status, work logs, session histories, handoffs, backlogs, roadmaps, or time-bound TODOs;
- decision provenance, citations, justification trails, or lists of material consulted;
- ticket, issue, pull-request, wiki, or external-document links added merely for reference;
- generic documentation available from a framework or web search;
- secrets, credentials, private keys, tokens, or connection strings.

A project may independently define other systems and conventions. Do not copy their contents or
rules into the vault unless they describe the project's current internal structure and the
project itself requires that representation.

## Irreversible and privileged actions

Do not treat “resolve,” “close,” or “clean” as authorization for external state changes or
destructive actions. Follow the project's own authority rules and obtain confirmation where
required.

## Failure modes

- Do not answer or act before reading the MOC.
- Do not trust the vault without checking load-bearing claims.
- Do not skip either garden check because another workflow manages the task.
- Do not manufacture a vault edit when no durable state changed.
- Do not preserve history in current-state pages.
- Do not overlink, create speculative stubs, or stamp the vault with everything consulted.
- Do not let completion language end the session before the final garden pass.
