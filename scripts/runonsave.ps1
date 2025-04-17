<#
.SYNOPSIS
    This uses the Run On Save vscode extension to add a new Git commit on every file Save
    This is useful for ensuring no loss of minor/major changes and is of use in the development workflow
.DESCRIPTION
    Ever had a small change that when you tested it worked but then subsequent changes break again. This allows you to get a complete changelog to your code base and then locally perform actions like interactive git rebases or automated squashing prior to pushing to the remote repo. Which is very useful if you ever work with very quick iterations and want to test out build/test/packaging when using the every commit is a testable release process, which is often used in conjunction with year-month-day versioning as opposed to semantic versioning, even though the two can be used together by using Major.Minor.Patch and having the patch use year-month-day-hour-minute or year-month-day-dailycommitcount.
.NOTES
    This could be adapted to run whenever a file is changed in a repo, even outside of the RunOnSave extension by registering a on file change event and then running the git commit command & may be something that I do in future instead of using the RunOnSave extension

    This does add lots to the commit history, so beware of that if you are working on a project that has a strict commit history policy or you are concerned about the commit history being too verbose

    This is something I had - and lost due to a hardware issue & will complete this another time as it was
    clever and only got the latest saved file\s and then committed them and invoked a build task in the repository.

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
[CmdletBinding()]
param (
    [Parameter()]
    [TypeName]
    $RepoPath,

    [Parameter()]
    [String]
    $FilePath
)
