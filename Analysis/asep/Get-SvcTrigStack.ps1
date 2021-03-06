﻿<#
Get-SvcTrigStack.ps1
Requires logparser.exe in path
Pulls stack rank of Service Triggers from acquired Service Trigger data

This script expects files matching the pattern *svctrigs.tsv to be in 
the current working directory.
#>

if (Get-Command logparser.exe) {

    $lpquery = @"
    SELECT
        COUNT(Condition, Value) as ct, 
        ServiceName, 
        Action, 
        Condition, 
        Value 
    FROM
        *svctrigs.tsv 
    GROUP BY
        ServiceName, 
        Action, 
        Condition, 
        Value 
    ORDER BY
        ct ASC
"@

    & logparser -i:tsv -fixedsep:on -dtlines:0 -rtp:50 $lpquery

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}