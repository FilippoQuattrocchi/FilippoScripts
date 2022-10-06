$path = 'HKLM:\System\CurrentControlSet\Services\VSS\Diag\'

$sddl = 'D:PAI(A;;KA;;;BA)(A;;KA;;;SY)(A;;CCDCLCSWRPSDRC;;;BO)(A;;CCDCLCSWRPSDRC;;;LS)(A;;CCDCLCSWRPSDRC;;;NS)(A;CIIO;RC;;;OW)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;CIIO;GA;;;BA)(A;CIIO;GA;;;BO)(A;CIIO;GA;;;LS)(A;CIIO;GA;;;NS)(A;CIIO;GA;;;SY)(A;CI;CCDCLCSW;;;S-1-5-80-3273805168-4048181553-3172130058-210131473-390205191)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)S:ARAI'

$acl = Get-Acl -Path $Path

$acl.SetSecurityDescriptorSddlForm($sddl)

Set-Acl -Path $Path -AclObject $acl