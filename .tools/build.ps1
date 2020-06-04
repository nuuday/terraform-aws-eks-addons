[CmdletBinding()]
Param(
  [Parameter(Mandatory)]
  [string] $ModulesPath,
  [Parameter(Mandatory)]
  [string] $VariablesPath,
  [Parameter(Mandatory)]
  [string] $OutputsPath
)

$modules = Get-ChildItem $ModulesPath -Directory
$variables = [System.Collections.Generic.List[string[]]]::new()
$outputs = [System.Collections.Generic.List[string[]]]::new()

foreach ($module in $modules) {
  $blockName = $module.Name.Replace('-','_')
  $moduleName = $module.Name

  # Variables
  $variables.Add(@"
  variable "$($blockName)_enable" {
    default = false
    description = "Enable $moduleName"
  }
"@)

  if(![string]::IsNullOrWhiteSpace(($variables[@($variables).GetUpperBound(0)]))) {
    $variables.Add(' ')
  }

  $variablePath = Join-Path -Path $module -ChildPath 'variables.tf' -Resolve -ErrorAction SilentlyContinue
  if($variablePath) {
    $preVariables = Get-Content -Path $variablePath
    $postVariables = $preVariables -replace '^variable "', "variable `"$($blockName)_"
    $variables.Add($postVariables)
  }

  # Outputs
  $outputPath = Join-Path -Path $module -ChildPath 'outputs.tf' -Resolve -ErrorAction SilentlyContinue
  if($outputPath) {
    $preOutputs = Get-Content -Path $outputPath
    $postOutputs = $preOutputs -replace '^output "', "output `"$($blockName)_"
    $outputs.Add($postOutputs+' ')
  }
}

Set-Content -Path $OutputsPath -Value $outputs
Set-Content -Path $VariablesPath -Value $variables
terraform fmt | Out-Null