﻿# OUTPUT tsv
<#
.SYNOPSIS
Get-DNSCache.ps1 acquires DNS cache entries from the target host.
#>

& ipconfig /displaydns | Select-String 'Record Name' | ForEach-Object { $_.ToString().Split(' ')[-1] } | `
  Select-Object -Unique | sort | % {
    $o = "" | Select-Object FQDN
    $o.FQDN = $_
    $o
  }