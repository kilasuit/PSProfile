# PSProfile

This is my work in progress PowerShell Profile repository

In this you will see use of a number of useful features that make my life in PowerShell much easier. 

However there also is significant amount of work that I am still to add to this and should be an evolving project for at least the next few years.

## Profile

As most know there is multiple profile locations
I personally would remove the host specific entries and just have
```powershell
$PROFILE.CurrentUserAllHosts
$PROFILE.AllUsersAllHosts
```
Whilst having guidance to control each profile script for each different host in a repository like this

### Extension of $Profile

I add some additional properties to the profile variable

This may/may not be something that in future is added to PowerShell  & is here as a PoC of why this layout is of use

## MinProfile

Using PowerShell with my full profile takes too long to load when I want to do any testing of things side by side like in the [Installing PowerShell Side by Side for testing purposes](https://blog.kilasuit.org/2023/09/09/installing-powershell-side-by-side-for-testing-purposes/) blog post. 

This lead me to want [Add options for running with no profile to jumplist & explorer](https://github.com/PowerShell/PowerShell/issues/18148) which I still want, for those instances where you don't want the overhead of using Windows Terminal - though this is getting less likely unless you are working with older systems like Server 2016/2019 or very old and likely unsupported Windows 10 or below systems.

However, by using a min-profile initiation script I can load a smaller segment of my profile & then later on in the session load the rest of my profile as needed.

I also have the option of switching so that I load the minprofile and then the full profile later on
Or if required a subset of the full profile or even organisational specific profiles as my time doing any Testing or Consultancy in this area continues.

## Design Decisions

Please see the Architecture Decision Docs in the Docs section, which details the points considered in how to organise and structure this repo along with other important aspects and is a living breathing regularly updated set of documents to be of use when onboarding or returning to a project like this

### TODO


