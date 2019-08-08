$module_path = $env:PSModulePath.split(';')[0] + "/ServiceV-Module"
if (Get-Module -Name servicev) {
   echo "removing existing powerShell module..."
   Remove-Module servicev
   rmdir $module_path -Force -Recurse
}
echo "creating powerShell module..."
New-Item -ItemType Directory -Force -Path $module_path > $null
cp ./servicev.psm1 $module_path/ServiceV-Module.psm1
New-ModuleManifest -Path $module_path/ServiceV-Module.psd1 -RootModule ServiceV-Module.psm1 -Author 'Ryan Bartsch' -CompanyName 'FlexiGroup' -Description 'ServiceV' -PowerShellVersion '5.0'
echo "importing module for current session..."
Import-Module ./servicev -Global -DisableNameChecking
