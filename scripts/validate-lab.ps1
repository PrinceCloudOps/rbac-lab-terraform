# scripts/validate-lab.ps1
# Validates Lab 2 Azure RBAC role assignments on FS01

$resourceGroup = "RG-Hybrid-Identity-Lab"
$vmName        = "FS01"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Lab 2 - Azure RBAC Validation Check" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Get FS01 Resource ID
$vmId = (az vm show -g $resourceGroup -n $vmName --query id -o tsv)

if (-not $vmId) {
    Write-Host "ERROR: VM '$vmName' not found in '$resourceGroup'!" -ForegroundColor Red
    exit 1
}

Write-Host "
Target Scope: $vmId" -ForegroundColor Yellow

# Query all role assignments scoped directly to this VM
$assignments = az role assignment list --scope $vmId -o json | ConvertFrom-Json

Write-Host "
--- Active Role Assignments on $vmName ---" -ForegroundColor Green
$assignments | ForEach-Object {
    [PSCustomObject]@{
        RoleName    = $_.roleDefinitionName
        PrincipalId = $_.principalId
        Scope       = $_.scope
    }
} | Format-Table -AutoSize

# Export evidence report
$reportPath = ".\RBAC_Lab_Report.txt"
$assignments | ForEach-Object {
    "Role: $($_.roleDefinitionName) | Principal: $($_.principalId) | Scope: $($_.scope)"
} | Out-File -FilePath $reportPath -Encoding utf8

Write-Host "Report exported to $reportPath" -ForegroundColor Green
