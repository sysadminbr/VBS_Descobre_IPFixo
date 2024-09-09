' ----------------------------------------------------------------------------------
' CITRA IT - EXCELÊNCIA EM TI
' Script para identificar na rede as máquinas configuradas com IP Fixo
' Autor: luciano@citrait.com.br
' Data: 11/07/2020  Versão: 1.0 release inicial
' Homologado para estações Windows 7, 8, e 10.
' Importante: Altere o caminho NETWORK_PATH para a pasta de rede que será 
'  salvo as informações das máquinas.
' ----------------------------------------------------------------------------------
'Option Explicit
'On Error Resume Next

' Caminho da rede onde salvar o arquivo de saida.
' Importante: Deve terminar em barra o caminho!
NETWORK_PATH = "\\Citrabhad02\ict\Maquinas_IP_Fixo\"


' Obtendo o usuário logado
Set objShell	= CreateObject("WSCript.Shell")
ConnectedUser	= objShell.ExpandEnvironmentStrings("%USERNAME%")
ComputerName	= objShell.ExpandEnvironmentStrings("%COMPUTERNAME%")



' Consultando o WMI para listar as placas de rede
Set wmiServices = GetObject("winmgmts:\\.\root\cimv2")
Set objResult = wmiServices.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = TRUE")
DHCPEnabled = True
IPAddr = ""


' Verificando a configuração de cada placa de rede encontrada
If objResult.Count > 0 Then
	For Each obj in objResult
		If obj.DHCPEnabled = False Then
			DHCPEnabled = False
		End If
		For Each ip in obj.IPAddress
			' Excluir endereços IPv6 link-local
			If InStr(ip, "fe80") <> 1 Then
				IPAddr = ip
			End If
		Next
	Next
End If


' Reunindo informações para salvar no arquivo de saída
txtData = "Computername=" & Computername & vbCrLf
txtData = txtData & "User=" & ConnectedUser & vbCrLf
If DHCPEnabled = False Then
	txtData = txtData & "DHCPEnabled=0" & vbCrLf
Else
	txtData = txtData & "DHCPEnabled=1" & vbCrLf
End If
txtData = txtData & "IPAddr=" & IPAddr & vbCrLf
txtData = txtData & "DateTime=" & Now()

' Criando o arquivo de saída na rede
filename   = NETWORK_PATH & Computername & ".txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set outputFile = objFSO.OpenTextFile( filename, 2, True )
outputFile.Write txtData
outputFile.Close

' Limpeza de Variaveis
Set objFSO		= Nothing
Set outputFile	= Nothing
Set objResult	= Nothing
Set wmiServices	= Nothing

' Finalizando o script
Wscript.Quit




