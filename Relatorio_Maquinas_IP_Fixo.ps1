<# ----------------------------------------------------------------------------------
' CITRA IT - EXCELÊNCIA EM TI
' Script para exibir a listagem de máquinas com ip fixo na rede.
' Autor: luciano@citrait.com.br
' Data: 11/07/2020  Versão: 1.0 release inicial
' Homologado para estações Windows 7, 8, e 10.
' Importante: Altere o caminho $NETWORK_PATH para a pasta de rede que será 
'  salvo as informações das máquinas.
' ---------------------------------------------------------------------------------- #>

# Caminho na rede onde os arquivos do script verifica_ip_fixo.vbs serão salvos
$NETWORK_PATH = "\\Citrabhad02\ict\Maquinas_IP_Fixo"


# Listando todos os arquivos
$OutputFiles = Get-ChildItem -Path $NETWORK_PATH
$Computers = @()
ForEach($TargetFile in $OutputFiles)
{
	$ComputerObject = [PSCustomObject]@{
		"Computername" = ""
        "User"         = ""
        "DHCPEnabled"  = 0
        "IPAddr"       = ""
        "DateTime"     = ""
		
	}

    $FileContent = Get-Content -Path $TargetFile.FullName
    ForEach($line in $FileContent)
    {
        $key,$value = $line.split("=")
        $ComputerObject.$key = $value
    }

    $Computers += $ComputerObject
	
}

$Computers | Out-GridView -Wait
