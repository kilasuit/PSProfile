---
id: 001
title: Initial
date: 2024-12-12
time: 07:05 UTC-0
updatedDate: 2025-04-15
updatedTime: 14:45 UTC+1 (UK BST)
attendees: 
- '@kilasuit'
#apologies:
outcome: Partial
impactedAreas: 
- Repo Layout
- Repo Scope
- Tech Used
---
<!-- markdownlint-disable MD025 -->
# 001 - 2024-Dec-12 - Initial 

## Status

PartialDecision above 80%

See more in the Accepted , Declined & Deferred sections

## Context

As part of initial starting of a project we need to have a project structure along with a number of key decision points, like what technologies we are using and licensing to use.

We should also link to projects that have inspired this as to allow others to goforthwith and have a look at how they've done it.

We should also decide initial scope and what it means to be at a push publicly stage.

## Decision

### Decided by

@kilasuit - Ryan Yates

### Accepted

#### Use of ADR's

ADR's (Architecture Decision Records / Any Decision Records) are useful to allow users, including maintainers, to comeback to a project and understand why decisions were made. These can be linked to in Issues, and in comments in  code, allowing reviews at a later date.

ADR's can be either made public or kept private. 

In this instance it was decided to make them public as part of the project & this initial ADR layout will be used in future projects as well.


#### Project Layout

The layout is as following most accepted practices, with a minor change in that all project docs are stored in a docs folder

This project would like to have used a `.config` folder where all folders like `.vscode` `.github` & other configuration files could be contained but due to most tools expecting them in the root this not possible and is somewhat irritating.

In future this project will be used as a reference for a project template that can be used when building any new project that meets similar needs

For more on Repository Templates please see [official GitHub Documentation on them](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)

#### Documentation 

This project will have useful AND up to date documentation to the best ability of the team

It will be in English (UK not US)

We would like at somepoint for this to be localised, but that is not a goal for anytime soon.

#### Project Scope

This project will only have items relating to PowerShell Profiles, and serves as living research & will be used for multi-device & multi-platform use of PowerShell Profiles for the lead maitainer.

It will include a number of sample `.vscode` & `.github` docs as well as a number of other files 


#### Used Technologies

- VScode
  - VSCode is our editor of choice
  - We use the stable for most work but also make use of the Insiders build too
 
- GitHub
  - We use GitHub to host the public version of this repo
  - We use GitHub Issues, PR's and Projects
  - We may use GitHub Actions in future
  - We may use wiki's however docs files in the repo seems useful enough for now.
  - We will use GH CLI where possible instead of the Github UI to speed things up

- Azure DevOps
  - We may use of Azure Repos for a secondary host and either a private version of this repo.
  - We may use Azure Pipelines for build and release
  - We may synchronise Issues to Azure Boards

- CoPilot/AI
  - We will have access and can make use of CoPilot/AI to help with this project only for segments of the code.
  - We don't intend to use AI for reviewing

- PowerShell v5 Support
  - whilst predominantly for v7+ we intend to support v5 in places

- PowerShell v2,v3,v4 Support
  - We will **not** support v2

- OS Support
  - We support Windows 10/11 & Server 2019-2025
  - We may support below Server 2016 & Windows 10
  - We will eventually test with the latest LTS of Ubuntu
    - We may support other Linux OSes
  - We have no current plans to support MacOS

- Host Support
  - Windows Terminal
  - Console host
  - ISE
  - VSCode PowerShell Ext Host
  - Standard VSCode Host
  - Others are TBD

#### Project Marketing Plan

Talk about it in the PowerShell Discord
Pre-release add some posts to Bsky, Twitter (X), LinkedIn, Mastadon

Release - additionally add Reddit & PowerShell.org & PowerShell.org.uk posts about it. 


### Declined

Declined publishing the repository publicly at this time.
Declined accepting PR's at this time.


### Deferred

When to publish source publicly, but rough thoughts sometime in April (either 4th or at PSCommunity call). 

When to accept PR's.
If to use a changelog or just keep our commit history as tidy as we can.
What images/logos to use.

#### Long term plans - Post initial release

As there are lots of things we could do we are deferring this till a Future ADR

### Notes


This repository and others, are part of the research I am doing on personal/business productivity in the world of software development and content creation based on any of the lessons learn in the research, development, deployment, review, continued development & re-deployment process. This is typically known as both ALM (Application Lifecycle Management) or SDLC (Software Development Lifecycle Management) 


This will in time be publish and linked to my [public ORCiD profile](https://orcid.org/0009-0009-6030-3517) and will allow for [blog posts](https://blog.kilasuit.org) as well as a number of future presentations on this wider topic.

Whilst originally authored in Dec 2024  
Minor updates to this ADR were added on 2025/01/13, 2025/04/15, 2025/04/16 & 2025/04/17 by @kilasuit 
