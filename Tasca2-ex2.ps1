#Un script que permeti afegir usuaris al sistema des d'un fitxer CSV
New-ADOrganizationalunit -Name 'Usuarios' -ErrorAction Silentlycontinue
clear;
'CREADOR DE USUARIOS'
'Se creara los usuarios del documento indicado y se almazenara en la carpeta Usuarios. Si no existe se crearà. '
'El formato del fichero de texto tiene que tener los apartados nombrados con su nombre original de active directori. (ejemlo: GivenName,Surname,...)'
'Para el proceso solo se usaran las columnas Name y AccountPassword'

$DC = Get-ADDomain | Select-String -Pattern 'DC'
$path = "OU=Usuarios, "+$DC
$resultado = ''
cd /
$file = Read-Host -Prompt 'Introduce la ruta completa del archivo'
$separador = Read-Host -Prompt 'Introduce el separador del archivo'
Import-Csv $file -Delimiter $separador | ForEach-Object { 
New-ADUser -Name $_.Name -GivenName $_.Name -Surname '' -SamAccountName $_.Name -UserPrincipalName $_.Name -Path $path -AccountPassword (ConvertTo-SecureString $_.AccountPassword -AsPlainText -force) -Enabled $true -ErrorAction SilentlyContinue
if($? -eq "true"){
$resultado += "`n -Se ha realizado la creacion del usuario "+$_.Name +"en la ruta "+$path+" satisfactoriamente"
clear
}
else{
$resultado += "`n -No se ha realizado la creacion del usuario "+$_.Name+"Compruebe si esos usuarios ya han sido creados anteriomente."
clear
}}
$resultado; ''