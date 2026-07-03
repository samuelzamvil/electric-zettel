# Electric Zettel

This project is an abstract version of the workflow that I have been using for [Claude Code](https://code.claude.com/docs/en/quickstart). I've found that for long-running projects it's helpful to keep an ongoing self-enriching knowledge repository for LLM agents to continuously reference when planning out new changes. To make this browseable and easily ingestable by an LLM, I chose the [digital gardening approach](https://maggieappleton.com/garden-history) I use for my personal notes. I don't like having LLMs edit my notes, but in this case it is a vault entirely created by and consumed by LLMs (and never edited by humans).

## AI Disclaimer

This Readme was hand authored, but the skills were created from existing LLM-authored skills I have refined in other projects (just with my personal specializations withheld).

## The Workflow

Every session when you begin a new task using the `/go` skill the agent will:

1. Explore the vault starting at the entrypoint `vault/README.md` and follow wikilinks to find relevant information, then explore the code or system being operated on to confirm with the ground truth.
2. Plan changes using the context found and persist the plan into `vault/plans` (so future agents can see why something was done)
3. Garden any new information and update information in the vault that is now stale given the new information
4. Execute the work plan
5. Garden once again to capture any changed state that was a result of executing the plan

Along the way, gardening notes involves trying to maximize the dense interconnection between notes which helps reduce the amount of markdown wikilinks needed to follow to find key info. The LLM will also try to create links to pages that do not exist yet, which when done across notes creates abstract links between concepts that do not have their adjoining page yet authored. At a later date, when relevant info is found the frontier of the Obsidian graph can grow naturally.

## Exploring the Vault

I generally do not explore the notes created by the LLM, but if you want you can explore the vault that is created using Obsidian. Just open the `vault` folder as an Obsidian vault.

<img width="1280" height="955" alt="image" src="https://github.com/user-attachments/assets/f2c6818c-b4a5-4934-8790-4a45b9663e19" />

## Using This Project

### `/go` Skill

The main skill of this project interfaces with the vault workflow. Here's an example:

```
/go initialize a new artifact "light-map" and research publically available databases for light pollution data. Download the data and create a Svelte project using mapbox that shows a light pollution heatmap for the United States
```

Assuming you have already been using this skill for a while in a project, your prompts can become much more terse:

```
/go the heatmap has a bug where it becomes blocky when zoomed in, can you fix it?
```

### `/build-skill` Skill

Sometimes you want something much more specific for a given project or use case. Using the example from the previous section you could:

```
/build-skill lightmap - create a new feature for the lightmap application. Begin by surveying existing patterns, building a plan to refactor and build ontop of what is already there, and avoid reinventing the wheel (search online for libraries that can help). Engage in code review once a feature is drafted in code and ask for user input before iterating on the review feedback. Research code review practices that would benefit this project so that this skill encodes the workflow without having to rebuild it each time.
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

### New Project

You can alternatively just clone this project and start using it without installing it anywhere. This is nice for a greenfield project, or if you just want to test drive this workflow. Just `git clone` and start using `claude` with the `/go` skill.
