---
title: "Lecturer's AI Guide — Replicating Research with AI Tools"
created: 2026-02-17
version: 1.0
status: draft
tags:
  - ai-pedagogy
  - research-replication
  - cursor-ide
  - agents
---

# Lecturer's AI Guide: Replicating Economics Research with AI

## 1 Introduction

### Why Use AI for Research Replication in Teaching?

Research replication is one of the most pedagogically valuable exercises in economics: it forces students to engage deeply with methodology, data, and interpretation. However, preparing a replication exercise — especially from a paper like Palma (2022) with complex panel data and local projections — is enormously time-consuming.

AI tools can dramatically accelerate the **mechanical** aspects of this preparation (data wrangling, plotting, boilerplate code) while you retain full control over the **pedagogical** decisions (question design, difficulty calibration, learning outcomes). This guide shows you how.

---

## 2 What AGENTS.md Do I Need?

### What is AGENTS.md?

`AGENTS.md` is the open, plain-Markdown instruction file that coding agents read before they work. The format is documented at [agents.md](https://agents.md/). Cursor, Codex, and Antigravity read it directly. Claude Code reads it when the repo has no `CLAUDE.md`; if you also keep a `CLAUDE.md`, import the shared file with `@AGENTS.md` so the two cannot drift. Cursor rules that need a glob or `alwaysApply` go in `.cursor/rules/*.mdc`, not in a second copy of the brief.

Keep the file short (well under 200 lines; 30–80 is plenty here). It is always-on context. A repeated procedure belongs in a skill, not in this file.

### Recommended AGENTS.md for This Project

Create an `AGENTS.md` file at the root of your `CourseworkMock/` folder:

```markdown
# AGENTS.md — CourseworkMock (Palma 2022 Replication)

## Project Context
This project creates teaching materials for a Python replication exercise
based on Palma (2022) "The Real Effects of Monetary Expansions" (Review
of Economic Studies).

## Target Audience
- First-year economics undergraduates at LSE
- Students have basic Python/pandas skills from the EC1B1 course
- No knowledge of advanced Python (no classes, decorators, generators)

## Coding Standards
- Python 3.10+, pandas, numpy, matplotlib, statsmodels
- PEP 8 style, snake_case naming
- All file paths must be relative (never absolute)
- All plots need: title, axis labels, legend, source note
- Use Newey-West (HAC) standard errors for time series regressions
- All code must be executable from top to bottom in a clean environment

## Content Standards
- All data from Zenodo replication package (DOI: <https://doi.org/10.5281/zenodo.4727681>)
- Cite Palma (2022) using author-year format
- Student materials must NEVER contain solutions
- Difficulty follows Bloom's taxonomy progression

## Key Paper Details
- 6 European countries: England, Holland, Italy, Spain, Portugal, Germany
- Period: 1531–1790 (annual data)
- Natural experiment: precious metals from Americas
- Main method: local projections (Jordà, 2005)
- Key result: 10% metals shock → ~0.9% real GDP increase (hump-shaped)
```

### Why This Matters

With this `AGENTS.md`, every time you ask the AI to:

- Write code, it will use the correct libraries and style
- Create content, it will pitch it at the right level
- Generate analysis, it will use the appropriate statistical methods
- Work with data, it will reference the correct source and variables

---

## 3 What Skills Should I Create?

### What are Skills?

A skill is a folder with one `SKILL.md`, following the [Agent Skills specification](https://agentskills.io/specification). The agent sees the `name` and `description` first and loads the procedure only when the task matches. Unlike `AGENTS.md` (always on, and about this project), a skill is a portable checklist.

Save a project skill at `.agents/skills/<name>/SKILL.md`. Cursor also reads `.cursor/skills/`, `.claude/skills/`, and `.codex/skills/`. Claude Code's own project path is `.claude/skills/`. A personal skill that should not travel with the repo goes in `~/.agents/skills/` or `~/.cursor/skills/`. In Cursor, `/create-skill` scaffolds the folder. The student-facing walkthrough is the Agent Skills page on the course site (Resources).

### Recommended Skills for Economics Research Replication

#### Skill 1: `econ-replication` — Research Paper Replication Workflow

Save as `.agents/skills/econ-replication/SKILL.md`:

```markdown
---
name: econ-replication
description: Replication workflow for an economics paper. Use when mapping a published table or figure to data files and code, or when checking a result against the paper.
---

# Economics research replication

## Workflow
1. **Read the paper**: Identify key tables, figures, and equations to replicate
2. **Find the replication package**: Check journal website, Zenodo, Dataverse, author's page
3. **Inventory the data**: List all files, variables, units, time periods
4. **Map paper to code**: For each figure/table, identify the exact data and transformations
5. **Implement incrementally**: Start with data loading, then descriptive stats, then main results
6. **Verify against published results**: Compare your outputs to the paper's

## Standards
- Always cite the paper and data source
- Use the paper's variable names in comments
- Implement equations exactly as published, with page references
- Note any discrepancies between your results and the published ones
```

#### Skill 2: `local-projections` — Jordà Local Projections

Save as `.agents/skills/local-projections/SKILL.md`:

```markdown
---
name: local-projections
description: Implements Jordà (2005) local projections. Use when estimating horizon-by-horizon impulse responses with OLS, fixed effects, and HAC standard errors.
---

# Local projections (Jordà 2005)

## Specification
For horizon h = 0, 1, ..., H:
  y_{i,t+h} - y_{i,t-1} = α_i^h + β^h · shock_{i,t} + γ^h · X_{i,t-1} + ε_{i,t+h}

## Implementation
1. Loop over horizons h
2. For each h, construct the dependent variable (cumulative change)
3. Estimate by OLS with entity fixed effects (country dummies)
4. Use Newey-West (HAC) standard errors with bandwidth = h + 1
5. Store β^h and 95% CI
6. Plot IRF with confidence bands

## Python Libraries
- statsmodels.api for OLS
- statsmodels.stats.sandwich_covariance for Newey-West
- matplotlib for IRF plots
```

#### Skill 3: `coursework-creator` — Teaching Materials Generator

Save as `.agents/skills/coursework-creator/SKILL.md`:

```markdown
---
name: coursework-creator
description: Drafts economics teaching materials. Use when writing a problem set, a scaffolded notebook, or a marking rubric. Student-facing files must not contain solutions.
---

# Economics coursework creator

## Standards
- Map every question to a learning outcome
- Progress through Bloom's taxonomy levels
- Scaffold code: full → partial → minimal → blank
- Include marking rubric for every assessed question
- Student materials must never contain solutions
- Estimate time for each section
```

---

## 4 Do I Need Subagents? Which Ones?

### What are Subagents?

A sub-agent is a helper with its own context window. It does one job and returns a summary to the parent chat. Cursor's built-in helpers are **Explore** (search the project) and **Browser** (drive a page). Anything else is a file you write. Docs: [Cursor subagents](https://cursor.com/docs/subagents). Ask Cursor to create one with `/create-subagent`, or save the file yourself.

A skill is still the right tool for a repeated checklist. A sub-agent is worth it when the pass is long, or when you want a review that did not watch the drafting.

### Recommended roles for this project

| Role | Where it lives | Example task |
| --- | --- | --- |
| Explore (built in) | Cursor uses it automatically | "What files are in the Zenodo package, and which columns does each have?" |
| Parent agent | The chat you already have | Implement one section of the local projection after you have accepted a plan |
| `consistency-reviewer` | `.cursor/agents/consistency-reviewer.md` with `readonly: true` | Check that variable names, units, and the written interpretation still match |
| `notebook-verifier` | A second read-only file, same folder | Run the solutions notebook from the top and report cells that fail |

Claude Code reads `.claude/agents/<name>.md`. Antigravity reads `.agents/agents/<name>.md`. Codex uses TOML in `.codex/agents/`. The same reviewer, in each format, is on the course page Skills, Sub-Agents, and Swarms (Resources).

`readonly: true` is a Cursor frontmatter field. Codex custom agents inherit the parent's permissions, so a "do not edit" instruction there is a request, not a sandbox. Read the diff either way.

### Orchestration

Use one parent and this order:

1. Plan from `AGENTS.md` and the spec. You approve the plan.
2. One writer implements a single chunk.
3. Explore inventories unfamiliar files. The reviewer checks consistency and does not edit.
4. You read the diff before the next chunk.

Several agents at once are for independent jobs (a cloud agent on its own branch, a data inventory while you edit a figure). Two writers in the same notebook will overwrite each other. Claude Code agent teams are experimental and off by default. If you later write an orchestrator in Python, start from the [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/), LangGraph, CrewAI, Microsoft Agent Framework, or Google ADK. OpenAI Swarm and AutoGen are not maintained starting points.

### When a sub-agent is the wrong tool

- A one-line edit, a definition, or a quick question: stay in the main chat.
- A checklist you will run again: make it a skill.
- Searching one file you already have open: read it yourself.

---

## 5 What Prompts Can I Use to Get Started?

### Phase 1: Understanding the Paper

```text
Prompt 1 — Paper Summary:
"Read Palma (2022) 'The Real Effects of Monetary Expansions' 
(Review of Economic Studies). Summarize: (a) the research question, 
(b) the natural experiment and identification strategy, (c) the data 
used, (d) the main empirical method (local projections), and 
(e) the key results (Figures 7-8). Cite specific page numbers."

Prompt 2 — Replication Package Inventory:
"Download and inventory the Zenodo replication package at
<https://doi.org/10.5281/zenodo.4727681>. List all data files, their formats, 
variable names, and the time/country coverage. Map each file to the 
figures and tables in the paper."

Prompt 3 — Equation Extraction:
"Extract the exact local projection specification from Palma (2022) 
Section 3. Write it in LaTeX and then translate it into Python 
pseudocode using statsmodels. Include details on: dependent variable 
construction, shock variable, controls, fixed effects, and standard 
error computation."
```

### Phase 2: Data and Code

```text
Prompt 4 — Data Loading:
"Load the Palma (2022) replication data from the CSV files in 
student/data/. Inspect the data structure, handle missing values, 
and construct the derived variables listed in the coursework brief 
Section 3.3. Follow the coding standards in steering/coding-standards.md."

Prompt 5 — Figure Replication:
"Replicate Figure 4 from Palma (2022) showing precious metals 
production over time. Use matplotlib with publication-quality 
formatting. Annotate key events: Potosí discovery (~1545), mercury 
amalgamation (~1571), Brazilian gold (~1690s)."

Prompt 6 — Local Projections:
"Implement the local projection impulse response functions from 
Palma (2022) for horizons h=0 to h=20. For each horizon, estimate 
OLS with country fixed effects and Newey-West standard errors 
(bandwidth = h+1). Plot the IRFs for real GDP, prices, and nominal 
GDP with 95% confidence bands."
```

### Phase 3: Teaching Materials

```text
Prompt 7 — Scaffolding:
"Take the solutions notebook and create a student version. For 
Sections 2-3, provide full or partial code. For Section 4.1-4.2, 
provide plotting templates. For Section 4.3-4.5, provide only 
function signatures and specifications. For Section 6, provide 
blank cells with instructions only. Remove all solutions."

Prompt 8 — Comprehension Questions:
"Generate comprehension questions about Palma (2022) that connect 
to EC1B1 Lecture 2 (Medieval Economy). Questions should progress 
through Bloom's taxonomy: remember/understand for Q1, 
analyze/evaluate for Q2-Q3. Include model answers for the 
instructor's reference."
```

### Phase 4: Quality Control

```text
Prompt 9 — Verification:
"Run the solutions notebook from top to bottom. Verify that: 
(a) all cells execute without errors, (b) the replicated figures 
match the patterns in Palma (2022), (c) the IRF shows a hump-shaped 
response of real GDP peaking at 6-9 years, (d) prices respond with 
a lag. Report any discrepancies."

Prompt 10 — Code Review:
"Review the student notebook as a senior instructor. Check that: 
(a) difficulty progresses through Bloom's taxonomy, (b) scaffolding 
decreases across sections, (c) no solutions leak into student 
materials, (d) all code is executable, (e) time estimates are 
realistic."
```

---

## 6 How Can I Use AI to Read the Research Article and Understand It?

### Strategy 1: Structured Reading Protocol

AI is excellent at extracting structured information from papers. Use this systematic approach:

```text
Step 1 — Abstract + Introduction:
"Read the abstract and introduction of Palma (2022). What is the 
research question? What is the main finding? What gap in the 
literature does this paper fill?"

Step 2 — Identification Strategy:
"Read Section 2 (Historical Background and Data). Explain the 
natural experiment: why is precious metals production in America 
exogenous to the European economy? What are the potential threats 
to identification?"

Step 3 — Empirical Method:
"Read Section 3 (Identification). Describe the local projection 
specification in detail. What is the dependent variable? What is 
the shock variable? What controls are included? How are standard 
errors computed?"

Step 4 — Results:
"Read the results figures (Figures 7-8). Describe the impulse 
response functions. Is the response of GDP hump-shaped? What is 
the peak magnitude and timing? How do prices respond?"

Step 5 — Robustness:
"Read Section 4 (Robustness). What statistical tests does Palma 
use to defend the natural experiment? What are the IV results? 
Do placebo tests pass?"
```

### Strategy 2: Comparative Analysis

```text
"Compare the identification strategy in Palma (2022) to another 
well-known natural experiment in macroeconomics (e.g. Friedman & 
Schwartz on the Great Depression, or Romer & Romer's narrative 
approach to monetary shocks). How are they similar? How do they 
differ? Which aspects are stronger in each approach?"
```

### Strategy 3: Visual Understanding

If you have the PDF:

```text
"I've attached Figures 7 and 8 from Palma (2022). Describe 
what each panel shows. What is the x-axis? What is the y-axis? 
What do the shaded bands represent? What is the key economic 
message from these figures?"
```

### Strategy 4: Data Exploration with AI

```text
"Load the replication data and generate a comprehensive 
exploratory data analysis: summary statistics, distributions, 
correlations, time series plots for each variable by country. 
Highlight any anomalies or interesting patterns."
```

### Tips for Using AI Effectively with Research Papers

1. **Break the paper into sections**: Don't ask the AI to "summarize the whole paper." Process it section by section.
2. **Ask for specifics**: "What is the coefficient on the metals shock at horizon h=6?" is better than "What are the results?"
3. **Cross-reference**: Ask the AI to connect figures to tables to equations. This catches inconsistencies.
4. **Challenge the AI**: Ask "What are the weaknesses of this paper?" and "What might the author be wrong about?" The AI's responses will help you design better extension questions.
5. **Use the replication package**: The code in the replication package is ground truth. When in doubt, ask the AI to read the Stata/R/Python code from the replication package rather than interpreting the paper text.

---

## 7 Recommended Project Workflow

### For a Lecturer Setting Up This Exercise

```text
Day 1 (2 hours): Understanding
├── Read the paper with AI assistance (Strategy 1 above)
├── Download and inventory the replication package
└── Run the original replication code to understand the outputs

Day 2 (3 hours): Building
├── Ask the parent agent for a plan against AGENTS.md and the spec, then approve it
├── Implement the replication in Python one section at a time
├── Create the solutions notebook with AI assistance
└── Verify replication results against the paper

Day 3 (2 hours): Polishing
├── Create the student notebook by scaffolding the solutions
├── Write comprehension questions and model answers
├── Design the extensions and marking rubric
└── Run notebook-verifier (read-only) for an end-to-end pass

Day 4 (1 hour): Final Review
├── Run consistency-reviewer (read-only) for a quality check
├── Time a walkthrough of the student notebook
├── Prepare any in-class guidance notes
└── Test the video presentation brief
```

### For Students Completing the Exercise

```text
Session (2.5 hours):
├── Preparation (15 min): Install packages, load data, initial exploration
├── Data Cleaning (25 min): Handle missing values, construct variables
├── Replication (60 min): Figures, tables, and local projections
├── Comprehension (15 min): Written answers to theory questions
├── Extensions (30 min): Open-ended analysis
└── Video Brief (10 min): Plan the video (record after session)
```

---

## Appendix: Quick Reference for AI Tools

| Tool | What It Does | When to Use |
|------|-------------|-------------|
| **AGENTS.md** | Always-on project rules ([agents.md](https://agents.md/)) | Once per project. Import it from `CLAUDE.md` if that file exists |
| **Skills** | `SKILL.md` checklist, loaded on demand ([specification](https://agentskills.io/specification)) | A procedure you would otherwise retype |
| **Sub-agents** | A separate context that returns a summary | A long or independent review. One writer besides the parent |
| **Prompts** | This conversation | Day-to-day questions and one-off edits |
| **SDD spec** | Requirements, design, and tasks in `spec/` | Before a multi-file build, as the plan the agent must follow |

---

*This guide was created for the EC1B1 teaching team, 2026.*
