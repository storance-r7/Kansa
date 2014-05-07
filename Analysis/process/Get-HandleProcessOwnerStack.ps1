﻿<#
Get-HandleProcessOnwerStack.ps1

Pulls frequency from Get-Handle data based on ProcessName and Owner

Requirements:
logparser.exe in path
Handle data matching *Handle.tsv in pwd
#>


if (Get-Command logparser.exe) {
    $lpquery = @"
    SELECT
        COUNT(ProcessName,
        Owner) as ct,
        ProcessName,
        Owner
    FROM
        *Handle.tsv
    GROUP BY
        ProcessName,
        Owner
    ORDER BY
        ct ASC
"@

    & logparser -i:tsv -dtlines:0 -fixedsep:on -rtp:50 "$lpquery"

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}