# VBS_Descobre_IPFixo
Script para identificar máquinas com IP fixo na rede


1) Crie uma pasta compartilhada com duas subpastas: scripts e arquivos.
2) Cole os dois scripts dentro da pasta scripts, e dê permissão de somente leitura nesta pasta para todos os usuários.
3) Edite os scripts e cole os respectivos caminhos de rede destas pastas, como no exemplo (yt video).
4) Crie uma política de grupo, nas configurações de usuário, preferências, adicione uma tarefa agendada do tipo Imediata (at least windows 7).
5) Na ação da tarefa agendada, no campo programa insira cscript.exe, no argumento cole o caminho do script descobre_ip_fixo.vbs (exemplo: \\servidor\pasta\scripts\descobre_ip_fixo.vbs).
6) Salve a tarega agendada.
7) Aguarde as máquinas atualizarem a política de grupo.
8) Edite o script relatorio_Maquinas_ip_fixo.ps1, altere o caminho da rede também.
9) Execute pelo powershell o script relatorio_maquinas_ip_fixo.ps1 e ele vai mostrar numa tabela a lista das máquinas e sua configuração de rede.
10) Use o filtro do grid para exibir somente as máquinas com IP fixo (campo DHCPEnabled é igual a 0).

Ficou com dúvida? Assista o vídeo com o passo-a-passo.
