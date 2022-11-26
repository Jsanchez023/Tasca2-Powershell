#Un script que permeti afegir usuaris al sistema des de terminal
New-ADOrganizationalunit -Name 'Usuarios' -ErrorAction Silentlycontinue
clear;
'CREADOR DE USUARIOS'
'Se creara un uusario y se almazenara en la carpeta Usuarios. Si no existe se crearà. '
'Introduzca los siguientes datos'

$nombre =  Read-Host -Prompt 'Introduce el nombre deseado para la cuenta'
$psw = Read-Host -AsSecureString -Prompt 'Introduce la contraseña para la cuenta'
$DC = Get-ADDomain | Select-string -Pattern 'DC'
$path = "OU=Usuarios, "+$DC
New-ADUser -Name $nombre -GivenName $nombre -Surname '' -SamAccountName $nombre -UserPrincipalName $nombre -Path $path -AccountPassword $psw -Enabled Strue -ErrorAction SilentlyContinue
if($? -eq "true"){
clear
}
-SamAccountName $nombre -UserPrincipalName $nombre
'se ha realizado la creacion del usuario'+$nombre+'satisfactoriamente'
else{
clear
'se ha producido un error. El usuario no se ha creado.'
}