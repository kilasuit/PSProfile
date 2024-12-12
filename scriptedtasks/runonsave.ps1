<#
.SYNOPSIS
   This uses the Run On Save vscode extension to add a new Git commit on every file Save
   This is useful for ensuring no loss of minor/major changes and is of use in the development workflow
.DESCRIPTION
    Ever had a small change that when you tested it worked but then susequent changes break again. This allows you to get a complete changelog to your code base and then locally perform actions like interactive git rebases or automated squashing prior to pushing to the remote repo.
.NOTES
    This could be adapted to run whenever a file is changed in a repo, even outside of the RunOnSave extension.

    AUTHOR
    Ryan Yates <ryan.yates@kilasuit.org>

    LICENSE
    MIT
.LINK
    https://blog.kilasuit.org
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

