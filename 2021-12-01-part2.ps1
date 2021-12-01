[int[]]$depthReadings = Get-Content -Path ".\data\depth-readings.txt"
$slidingWindowSize = 3;
$previousDepthSum = 0;
$depthIncreaseCount = 0;
for ($i = 0; $i + $slidingWindowSize -le $depthReadings.Length; $i++) {
    $currentDepthSum = 0;
    
    # Gather the values for this window
    for ($j = 0; $j -lt $slidingWindowSize; $j++) {
        $currentDepthSum += $depthReadings[$i + $j];
    }

    # If this isn't the first window and the window is larger than the previous, count it
    if ($previousDepthSum -gt 0 -and $currentDepthSum -gt $previousDepthSum) {
        $depthIncreaseCount++;
        if ($depthIncreaseCount -lt 10 -or $depthIncreaseCount % 10 -eq 0) {
            Write-Host "$($depthIncreaseCount): Previous depth window is less than current depth window ($previousDepthSum < $currentDepthSum)" -ForegroundColor Gray
        }
    }

    $previousDepthSum = $currentDepthSum;
}

Write-Host "Read $($depthReadings.Length) depth readings." -ForegroundColor White
Write-Host "Found $depthIncreaseCount depth windows that increased." -ForegroundColor Green