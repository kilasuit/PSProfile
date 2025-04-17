# PSProfile

This is my work in progress PowerShell Profile repository that has evolved from the single profile script that I had previously used all the way from 2013.

To learn more on the inspirations behind this project please have a read of [InspiredBy](docs\InspiredBy.md)

In this you will see use of a number of useful features that make my life in PowerShell much easier. I hope that from this project, including it's layout as well as links to other projects that you can be `Inspired` much like I have been to spend the time in developing it and other similar projects over the years. 

However there also is significant amount of work that I am still to add to this and should be an evolving project for as long as I continue working with and using PowerShell.

## Profile

If you aren't aware there are multiple profile locations that PowerShell & the hosts that run it can use as documented in [about_profiles](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.5) 

For most users they likely will want use a single profile script `$PROFILE.CurrentUserAllHosts` as opposed to managing per host specific scripts, however this repo enables you to use either mechanism.

I understand the design decisions behind having it as it is today, and whilst I have never used host specific scripts as I have had checks for what host I am in since the initial profile script that I used, I appreciate teh flexibility that this brings for those that use and ship their own host, like chocolately does, or the vscode-powershell extension.

### Extension of $Profile

I add some additional properties to the profile variable for being able to quickly re-run or jump to my profile directory without using a PSDrive.

This may/may not be something that in future is added to PowerShell  & is here as a PoC of why this layout is of use

## MinProfile

Using PowerShell with my full profile takes too long to load when I want to do any testing of things side by side like in the [Installing PowerShell Side by Side for testing purposes](https://blog.kilasuit.org/2023/09/09/installing-powershell-side-by-side-for-testing-purposes/) blog post. 

This lead me to want [Add options for running with no profile to jumplist & explorer](https://github.com/PowerShell/PowerShell/issues/18148) which I still want, for those instances where you aren't using Windows Terminal & are (for whatever reason) still using conhost based sessions.
Whilst that would still be nice to have for on older systems like Server 2016/2019 or very old and likely unsupported Windows 10 or below systems, I enjoyed discussing it with the Interactive-UX WG at the time as it lead me into an interesting area of other research, at a time where I was just about getting by. 

Over time I have repurposed and redesigned the invocation of things that I need in my profile and this still lead to needing a minprofile script where the functionality is between that of a `-noprofile` & a full profile session.

For more info please read the MinProfile docs & ADR's

# Docs

This repositories documentation is in the Docs folder and contains the following core docs which detail any additional documents as needed

[ArchitectureDecisionRecords](/docs/ArchitectureDecisionRecords.md)

[Changelog](/docs/Changelog.md)

[CommunityNotes](/docs/CommunityNotes.md)

[Contributing](/docs/Contributing.md)

[InspiredBy](/docs/InspiredBy.md)

[MeetingNotes](/docs/MeetingNotes.md)



## Design Decisions

Please see the [Architecture Decision Docs](docs\ArchitectureDecisionRecords), which detail the points considered as part of the Architecture Decisions of the project which includes decisions around processes, layout, as well as more over time 


in how to organise and structure this repo along with other important aspects and is a living breathing regularly updated set of documents to be of use when onboarding or returning to a project like this

### TODO


