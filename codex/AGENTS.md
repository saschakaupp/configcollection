# Instructions for agents

These instructions are meant for agents. The main focus of using agents is on agentic coding and server administration.

## Default tools with MCP interface

Use the following MCP integrations when they are configured and available.

### AgentTracker recording

When available, use the configured AgentTracker MCP server to record substantial work automatically.

At session start, create one session record. For every user request that causes the agent to perform implementation, investigation or review, create a task and agent-run record - this does not include simple Q&A; record lifecycle events such as started, completed, blocked, and failed. Use factual, non-sensitive metadata only. If the server is unavailable, continue the task and report the recording gap in the final response.

When AgentTracker is not available, tell the user about it as soon as you take notice of it using the message "*AgentTracker* not available"

### Manifesto integration

If Manifesto is configured and reachable via MCP for a given project, integrate it into the workflow.

When the user asks for a product overview, list the task references and titles of tasks within each lane of the kanban board. Group that list by lane.

When you start work on a Manifesto implementation task, move the task to "in progress" and mark it as being worked on by an agent using Manifesto's MCP interface. After implementing changes, move it to "review" so the user can review the changes before giving feedback. Move tasks only to "done" when the user gives positive feedback for the implementation. When the user gives negative feedback after reviewing the changes, move the task back to "in progress".

When Manifesto is not available, tell the user about it as soon as you take notice of it using the message "*Manifesto* not available"

## Workflows

Whenever files have been changed, provide a meaningful commit message in English, no matter what language the user has been using in the session. When you implemented a task from Manifesto, also note the task reference.

When you implement meaningful changes, give a quick overview of how to test/validate the changes made.

Ask the user for feedback regarding changes.

If a tool needed for the task remains unavailable after any permitted escalation, tell the user which tool is unavailable and what work this prevents. Suggest a workaround only when you know one.

### Agentic coding

- Inspect the relevant code and project instructions before proposing edits.
- For multi-step tasks, share a brief plan, then proceed; report blockers or meaningful scope changes.
- Prefer small, focused changes that fit the existing architecture.
- Run relevant checks when appropriate, and report the commands and results—including checks you couldn’t run.

### Server administration

Agents do not have direct access to affected servers. Treat provided configuration files as snapshots; do not assume they match the current server state.

Use the supplied files and context to investigate. When you need live information, ask for relevant context, such as the OS/version, environment, service manager, and when the snapshot was captured. Provide specific, read-only commands for the user to run, explain what each checks and what output to share, and ask them to redact secrets. Request only the relevant output; avoid broad dumps that could include credentials.

Propose changes to the supplied files and explain their expected effect. For commands that apply changes, explain the impact, prerequisites, backup, validation, and rollback steps. The user runs those commands on the server.

Do not claim a server change was applied or verified until the user confirms it and provides the results.

## Project Coding Guidelines

If a project has a coding-guidelines submodule, follow these guidelines. It will include defaults for UI design, color schemes, CI/CD and specific information on code style.

## Repository workflow

Inspect the working tree before editing, preserve unrelated changes, follow existing project instructions, and report what changed and how it was checked.

The agents must not perform commit or push actions.

## Safety rules

Do not expose secrets in output or metadata.
