# Un script que permeti gestionar els usuaris: ha d'indicar el nombre d'usuaris totals al sistema, comptes d'usuari creats recentment, usuaris que no van canviar la contrasenya, quins hi ha inactius i proposar esborrar-los.
clear
'MENU DE GESTION DE USUARIOS'
while(1 -eq 1) {
'Introduzca la ruta de la ou de usuarios'
'Ejemplo: OU=Usuarios,DC=JoanS,DC=com'
$carpetaUsers = Read-Host -Prompt 'ruta'
Get-ADUser -Filter -SearchBase $carpetaUsers -ErrorAction SilentlyContinue 
if($? -eq 'true'){
$Dias = Read-Host -Prompt 'Introduce la cantidad de dias considerada reciente' 
break
}
else{ 
clear
'la ruta no se ha encontrado.'
sleep (2)
clear
}}
clear
$Tiempo = (Get-Date).AddDays(-($Dias))
while(1 -eq 1) {
'MENU DE GESTION DE USUARIOS';''
'Actualmente hay '+$userNum+'usuarios'
'Seleccione una de las siguientes opciones(numero): '
'1 - Visualizar cuentas recientes'
'2 - Visualizar cuentas que no han cambiado su contraseña o no tienen' 
'3 - Visualizar cuentas inactivas'
'4 - Salir'; ''
$opcion = Read-Host -Prompt 'opcion'
clear
if ($opcion -eq 1) {
Get-ADUser -Filter * -Properties whenCreated | where{$_.whenCreated -gt $Tiempo} | ft *
}
if($opcion -eq 2) {
Get-ADUser -Filter * -Properties PasswordLastSet,WhenCreated | where{(-not ($_.PasswordLastSet -le $_.whencreated)) -or($_.PasswordLastSet -eq $null) } | ft * 
if ($opcion -eq 3) {
$userinactivo = Get-ADUser -Filter {LastLogon Date -lt $Tiempo} -properties * | ft Name,LastLogonDate,LockedOut 
}
if($userinactivo -eq $null){
'No se encontro ningun usuario inactivo.';' '}
else{$userinactivo}
if($opcion -eq 4){
'Cerrando menu..'
sleep (3)
break}
}}
clear