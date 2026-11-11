---
name: econ-replication
description: Use when working through the Palma (2022) EC1B1 coursework, including inspecting its data, reproducing figures and summary statistics, or checking analysis against the coursework brief.
---

# Palma coursework replication

## Project layout

Run commands from the project root. Use relative paths:
- Input CSVs: `data/palma2022_panel.csv` and `data/palma2022_descriptive.csv`
- Data dictionary: `data/README_data.md`
- Dependencies: `requirements.txt`
- Coursework specification: `coursework_brief.pdf`
- Paper: `references/palma2022.pdf`
- Original Stata files: `references/original_replication_package/`
- Student notebooks: `notebooks/`

## Workflow

1. Read the relevant coursework brief section and data dictionary before coding.
2. Inspect dimensions, columns, types, missing values, and country/year coverage.
3. Build derived variables within country and state what each measures.
4. Implement the requested analysis in small, clearly commented notebook sections.
5. Label plots with titles, axes, legends, and source notes; compare patterns to the paper.
6. Explain choices, sample restrictions, and limitations in the written analysis.
7. Keep paths relative so the notebook runs from the project root in a clean environment.

## Coursework constraints

- The data cover six European countries and 1531–1790; regression exercises may further restrict the sample to years through 1700 as specified.
- Use the precise variables and transformations named in the brief and data dictionary.
- Do not silently fill missing values; identify their pattern and justify any treatment.
- Preserve the distinction between the student CSV data and the original Stata replication files.
- Help the student understand and interpret results; do not present generated prose as a substitute for their own comprehension.

## Sources

Cite Palma (2022) and the replication data in analysis. Use the original package and paper as references when resolving discrepancies; describe any differences from the simplified coursework exercise.
