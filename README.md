# HireTrack ATS: BA Case Study

A simulated Business Analysis project. I took a problem I know from HR work: companies that track hiring on email, WhatsApp and Excel, so candidates get lost and nobody knows who is at which stage. For this I wrote the requirements, a process diagram, user stories and a Jira backlog for a simple internal tracking system.

> This is a simulated case study. The numbers and the data are made up, but the problem comes from real HR work.

## The problem

- CVs are spread across email, WhatsApp and Excel.
- Hiring managers keep asking HR where a candidate is.
- Some candidates are interviewed twice by mistake, and some never get feedback.
- Nobody has numbers: how many candidates per stage, how long hiring takes, are we reaching the target.

## Scope

**In the first version:** add jobs and candidates (no duplicates), schedule interviews (no conflicts), record feedback, move candidates between stages, and see the number of candidates per stage.

**Not in the first version:** a candidate portal, automatic emails to candidates, CV reading with AI, LinkedIn integration.

## What is in this repo

```
ats-ba-case-study/
├── README.md
├── docs/
│   ├── requirements.md      17 functional and 4 non-functional requirements, business rules
│   ├── use-cases.md         UC-01 with main and alternative flows
│   └── user-stories.md      19 user stories in 4 epics (Jira keys ATS-5 to ATS-23)
├── diagrams/
│   ├── bpmn-recruitment-cycle.png   the recruitment process (HR, System, Hiring Manager)
│   └── data-model.png               the 4 tables and how they connect
└── sql/
    ├── schema.sql           tables and rules
    ├── sample-data.sql      made-up data: 15 candidates, 2 jobs
    └── queries.sql          6 business questions
```

## How to run the SQL

The files are written for SQLite. Open DB Browser for SQLite (or any online SQLite editor) and run the files in this order:

1. `sql/schema.sql`
2. `sql/sample-data.sql`
3. `sql/queries.sql`

Each query has a comment with the question it answers and the decision it helps with.

## Links

- Full case study (Notion): add the published Notion link here
- Jira: the backlog and Sprint 1 screenshots are in the Notion page

## Skills shown

Requirements writing, stakeholder and persona analysis, process modeling (BPMN), user stories with acceptance criteria, MoSCoW prioritization, roadmap, Jira (Scrum), basic SQL.
