# Galaxy-Module.psm1
Write-Host "Loading ServiceV-Module"

function Export-EnvironmentVars {
   gc "$PSScriptRoot/.env" | % {
      $var = $_.Split('=',2)
      New-Variable -Name $var[0].trim() -Value $var[1].trim() -Scope Global
   }
}
function Build-ReadyApiDockerfile {
   Export-EnvironmentVars
   iex "docker build -t $ImageName --build-arg HttpProxy=$HttpProxy --build-arg HttpsProxy=$HttpsProxy --build-arg LicenseServer=$LicenseServer --build-arg ProjectName=$ProjectName ."
}
function Start-ReadyApiDockerContainer {
   Export-EnvironmentVars
   iex "docker run -d -p $PortBinding -e ProjectName=$ProjectName $ImageName"
}
function Debug-ReadyApiDockerContainer {
   Export-EnvironmentVars
   iex "docker exec -it $(docker ps -q --filter ancestor=$ImageName) /bin/bash"
}
function Stop-ReadyApiDockerContainer {
   Export-EnvironmentVars
   iex "docker rm $(docker stop $(docker ps -a -q --filter ancestor=$ImageName))"
}
function Publish-ReadyApiVirtualService {
   Export-EnvironmentVars
   iex "docker exec -it $(docker ps -q --filter ancestor=$ImageName) /bin/sh -c '/opt/ready-api/bin/virtserver-cli.sh -d /usr/src/$ProjectName -n $VirtualService -a true -r -s $VirtServer -u $UserName -pw $Password'"
}

$servicev_module = $MyInvocation.MyCommand.ScriptBlock.Module
$servicev_module.OnRemove = {Write-Host "Removed ServiceV-Module"}
