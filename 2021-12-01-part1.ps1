[int[]]$depthReadings = Get-Content -Path ".\data\depth-readings.txt"
$previousDepth = 0;
$depthIncreaseCount = 0;
foreach ($currentDepth in $depthReadings) {
    if ($previousDepth -gt 0 -and $currentDepth -gt $previousDepth) {
        $depthIncreaseCount++;
        if ($depthIncreaseCount -lt 10 -or $depthIncreaseCount % 10 -eq 0) {
            Write-Host "$($depthIncreaseCount): Previous depth is less than current depth ($previousDepth < $currentDepth)" -ForegroundColor Gray
        }
    }
    else {
        
    }

    $previousDepth = $currentDepth;
}

Write-Host "Read $($depthReadings.Length) depth readings." -ForegroundColor White
Write-Host "Found $depthIncreaseCount depth increases." -ForegroundColor Green