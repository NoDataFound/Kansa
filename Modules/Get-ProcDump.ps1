﻿# OUTPUT bin
# BINDEP Procdump.exe
<#
Get-ProcDump
Acquires a Sysinternal procdump of the specified process
Requires prodcump.exe be in $env:SystemRoot
This is really more of a PoC for how one might collect binary
data, like a memory dump, using Kansa.

!! SCRIPT ASSUMES PROCDUMP IS IN $ENV:SYSTEMROOT!!

If you have procdump.exe in your Modules\bin\ path and run the script with the -Pushbin
flag, Kansa will attempt to copy the binary to the ADMIN$. Binaries are not removed, so
subsequent runs won't require -Pushbin.

Also, you should configure this to dump the process you're 
interested in. By default it dumps itself, which is probably
not what you want.
#>

if (Test-Path "$env:SystemRoot\Procdump.exe") {
    $PDOutput = & $env:SystemRoot\Procdump.exe /accepteula $pid 2> $null
    foreach($line in $PDOutput) {
        if ($line -match 'Writing dump file (.*\.dmp) ...') {
            Get-Content -ReadCount 0 -Raw -Encoding Byte $($matches[1])
            Remove-Item $($matches[1])
        }
    }
}