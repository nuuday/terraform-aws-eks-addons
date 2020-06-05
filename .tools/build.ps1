[CmdletBinding()]
Param(
  [Parameter(Mandatory)]
  [string] $ModulesPath,
  [Parameter(Mandatory)]
  [string] $MainPath,
  [Parameter(Mandatory)]
  [string] $VariablesPath,
  [Parameter(Mandatory)]
  [string] $OutputsPath
)

$modulePaths = Get-ChildItem $ModulesPath -Directory
$modules = [System.Collections.Generic.List[string[]]]::new()
$variables = [System.Collections.Generic.List[string[]]]::new()
$outputs = [System.Collections.Generic.List[string[]]]::new()

foreach ($modulePath in $modulePaths) {
  $blockName = $modulePath.Name.Replace('-','_')
  $moduleName = $modulePath.Name

  # Main
  $modules.Add(@"
module "$blockName" {
  count = var.$($blockName)_enable ? 1 : 0
  source = "./modules/$moduleName"
}
"@)

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

  $variablePath = Join-Path -Path $modulePath -ChildPath 'variables.tf' -Resolve -ErrorAction SilentlyContinue
  if($variablePath) {
    $preVariables = Get-Content -Path $variablePath
    $postVariables = $preVariables -replace '^variable "', "variable `"$($blockName)_"
    $variables.Add($postVariables)
  }

  # Outputs
  $outputs.Add(@"
  outputs "$($blockName)" {
    value = module.$blockName
  }
"@)

  if(![string]::IsNullOrWhiteSpace(($outputs[@($outputs).GetUpperBound(0)]))) {
    $outputs.Add(' ')
  }
}
Set-Content -Path $MainPath -Value $modules
Set-Content -Path $VariablesPath -Value $variables
Set-Content -Path $OutputsPath -Value $outputs
terraform fmt | Out-Null