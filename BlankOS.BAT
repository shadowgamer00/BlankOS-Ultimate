@echo off
:: =====================================================================================
:: TERMO DE LICENCA E ASSINATURA DIGITAL (EULA)
:: =====================================================================================
:: AUTOR ORIGINAL: carlos-blank
:: VERSAO: 4.9 Ultimate (2026) - BlankOS Blindagem Total (Anti-Crash)
:: 
:: AVISO LEGAL: Este ficheiro original contem comandos oficiais e de desempenho
:: extremo. O autor original isenta-se de qualquer responsabilidade civil.
:: =====================================================================================
set "Assinatura_Autor=carlos-blank"
set "Build_Versao=BlankOS_4.9_2026"

title Otimizador Windows Ultimate - BlankOS V4.9

:: 1. DETECCAO INTELIGENTE DA AREA DE TRABALHO (Fisica ou OneDrive)
set "log=%userprofile%\Desktop\Otimizador_BlankOS_Log.txt"
if exist "%userprofile%\OneDrive\Desktop" (
    set "log=%userprofile%\OneDrive\Desktop\Otimizador_BlankOS_Log.txt"
)

:: 2. VERIFICACAO DE PRIVILEGIOS DE ADMINISTRADOR
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    mode con: cols=80 lines=10
    echo ==========================================================
    echo    ERRO: ESTE SCRIPT PRECISA SER EXECUTADO COMO ADMINISTRADOR
    echo ==========================================================
    echo.
    echo Por favor, clica com o botao direito no ficheiro e 
    echo escolhe "Executar como administrador".
    echo.
    pause
    exit
)

:: Redefine o tamanho e a cor padrao para AZUL CLARO (09)
color 09
mode con: cols=95 lines=50

:: CARREGANDO INFORMACOES DO SISTEMA
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value ^| find "="') do set OS=%%a
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| find "="') do set CPU=%%a

:: INICIALIZACAO RAPIDA DO LOG
echo ===================================================== > "%log%"
echo            RELATORIO DE TELEMETRIA E CRASH LOG
echo ===================================================== >> "%log%"
echo SESSAO INICIADA EM: %date% as %time% >> "%log%"
echo AUTOR COMPILADOR: %Assinatura_Autor% >> "%log%"
echo VERSAO DA BUILD: %Build_Versao% >> "%log%"
echo SISTEMA OPERACIONAL: %OS% >> "%log%"
echo PROCESSADOR DETECTADO: %CPU% >> "%log%"
echo ===================================================== >> "%log%"
echo. >> "%log%"

:MENU
cls
color 09
echo =====================================================================================
echo.
echo       ____   _          _    _   _  _  __  ___   ____  
echo      ^| __ ^) ^| ^|        / \  ^| \ ^| ^|^| ^|/ / / _ \ / ___^| 
echo      ^|  _ \ ^| ^|       / _ \ ^|  \^| ^|^| ' / ^| ^| ^| ^|\___ \ 
echo      ^| ^|_) ^|^| ^|___   / ___ \^| ^|\  ^|^| . \ ^| ^|_^| ^| ___) ^|
echo      ^|____/ ^|_____^| /_/   \_\_^| \_^|^|_^|\_\ \___/ ^|____/ 
echo.
echo                        U L T I M A T E   V 4. 9
echo =====================================================================================
echo   SISTEMA: %OS%
echo   PROCESSADOR: %CPU%
echo =====================================================================================
echo.
echo   [1] Limpeza Profunda (Temporarios, Lixeira e Win Update)
echo   [2] Reparo do Windows (SFC, DISM e CHKDSK)
echo   [3] Otimizar Discos (Desfragmentacao)
echo   [4] Otimizador de Armazenamento Inteligente (USB / HD / SSD)
echo   [5] Reparar Internet (Reset a Rede e DNS)
echo   [6] Diagnostico de Hardware (Saude do HD/SSD e Bateria)
echo   [7] Extrair Senhas de Wi-Fi Salvas
echo   [8] Kit de Sobrevivencia (Matar Travados e Telemetria)
echo   [9] ATIVAR DESEMPENHO EXTREMO (Energia e Zero Stuttering)
echo   [10] ALTERNAR Modo Batata Grafico (Liga / Desliga)
echo   [11] ALTERNAR Modo Hibernacao (Liga / Desliga)
echo   [12] Cacador de Virus (Windows Defender)
echo   [13] Restaurar PC para o Modo Normal
echo   [14] Sair do Programa
echo.

set "opcao="
set /p opcao="Escolha uma opcao (1-14): "

:: BLINDAGEM: Verifica se o utilizador carregou apenas no Enter
if not defined opcao (
    echo.
    echo Opcao invalida!
    timeout /t 2 >nul
    goto MENU
)

:: BLINDAGEM: Usar parenteses de bloco para evitar erros de sintaxe com espacos
if /I "[%opcao%]"=="[1]" goto LIMPEZA
if /I "[%opcao%]"=="[2]" goto REPARO
if /I "[%opcao%]"=="[3]" goto DISCOS
if /I "[%opcao%]"=="[4]" goto ARMAZENAMENTO
if /I "[%opcao%]"=="[5]" goto INTERNET
if /I "[%opcao%]"=="[6]" goto DIAGNOSTICO
if /I "[%opcao%]"=="[7]" goto WIFI
if /I "[%opcao%]"=="[8]" goto SOBREVIVENCIA
if /I "[%opcao%]"=="[9]" goto EXTREMO
if /I "[%opcao%]"=="[10]" goto BATATA
if /I "[%opcao%]"=="[11]" goto HIBERNACAO
if /I "[%opcao%]"=="[12]" goto ANTIVIRUS
if /I "[%opcao%]"=="[13]" goto NORMAL
if /I "[%opcao%]"=="[14]" exit

echo.
echo Opcao invalida!
timeout /t 2 >nul
goto MENU

:LIMPEZA
cls
echo INICIANDO LIMPEZA PROFUNDA...
echo [%time%] [LIMPEZA] Iniciando rotina de limpeza profunda... >> "%log%"
rd /s /q %systemdrive%\$Recycle.Bin >> "%log%" 2>&1
del /q /f /s "%temp%\*" >> "%log%" 2>&1
del /q /f /s "C:\Windows\Temp\*" >> "%log%" 2>&1
net stop wuauserv >> "%log%" 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >> "%log%" 2>&1
net start wuauserv >> "%log%" 2>&1
echo [%time%] [LIMPEZA] Operacao finalizada com sucesso. >> "%log%"
echo LIMPEZA CONCLUIDA!
pause
goto FIM_OPERACAO

:REPARO
cls
echo REPARANDO ARQUIVOS DO SISTEMA...
echo [%time%] [REPARO] Iniciando varredura e correcao do sistema... >> "%log%"
sfc /scannow >> "%log%" 2>&1
dism /online /cleanup-image /restorehealth >> "%log%" 2>&1
echo s | chkdsk /f >> "%log%" 2>&1
echo [%time%] [REPARO] Verificacoes estruturais concluidas. >> "%log%"
echo REPARO FINALIZADO! (Reinicie o PC depois)
pause
goto FIM_OPERACAO

:DISCOS
cls
echo OTIMIZANDO DISCOS...
echo [%time%] [DISCOS] Iniciando defrag e comando TRIM para SSDs... >> "%log%"
defrag C: /O /U /V >> "%log%" 2>&1
echo [%time%] [DISCOS] Processamento de otimizacao encerrado. >> "%log%"
echo OTIMIZACAO CONCLUIDA!
pause
goto FIM_OPERACAO

:ARMAZENAMENTO
cls
echo =====================================
echo OTIMIZADOR DE ARMAZENAMENTO (USB / HD / SSD)
echo =====================================
echo [%time%] [ARMAZENAMENTO] Modulo de reconhecimento ativado. >> "%log%"
echo.
echo Unidades de armazenamento conectadas no sistema:
wmic logicaldisk get caption,volumename,description
echo.
echo ATENCAO: NUNCA digite a letra C (Disco do Windows)!
echo.

set "drive="
set /p drive="Digite a letra da unidade para otimizar (Ex: D, E, F) ou 0 para Sair: "

:: BLINDAGEM: Se carregar apenas no Enter, volta ao menu do armazenamento
if not defined drive goto ARMAZENAMENTO

:: Limpeza extrema da entrada do utilizador (Remove espacos, barras e dois pontos)
set "drive=%drive: =%"
set "drive=%drive::=%"
set "drive=%drive:\=%"

if /I "[%drive%]"=="[0]" (
    echo Operacao cancelada.
    goto MENU
)

if /I "[%drive%]"=="[C]" (
    echo [%time%] [ARMAZENAMENTO] [ALERTA] Execucao abortada na unidade C: >> "%log%"
    echo.
    echo ERRO GRAVE: Nao podes executar isto no disco principal do sistema!
    pause
    goto MENU
)

if not exist "%drive%:\" (
    echo [%time%] [ARMAZENAMENTO] ERRO: Unidade [%drive%:] nao encontrada. >> "%log%"
    echo.
    echo ERRO: A unidade "%drive%:" nao existe ou nao esta conectada corretamente.
    pause
    goto MENU
)

echo.
echo [1/3] A verificar e reparar erros no sistema de ficheiros da unidade %drive%:...
echo [%time%] [ARMAZENAMENTO] Iniciando CHKDSK na unidade %drive%:... >> "%log%"
chkdsk %drive%: /f /x >> "%log%" 2>&1

echo [2/3] A remover lixo e atalhos de virus ocultos...
echo [%time%] [ARMAZENAMENTO] Deletando extensoes nocivas... >> "%log%"
del /f /s /q /a "%drive%:\*.lnk" >> "%log%" 2>&1
del /f /s /q /a "%drive%:\autorun.inf" >> "%log%" 2>&1
del /f /s /q /a "%drive%:\Thumbs.db" >> "%log%" 2>&1

echo [3/3] A restaurar ficheiros ocultados pelo sistema ou virus...
echo [%time%] [ARMAZENAMENTO] Restaurando atributos de ficheiros ocultos... >> "%log%"
attrib -h -r -s /s /d %drive%:\*.* >> "%log%" 2>&1

echo [%time%] [ARMAZENAMENTO] Unidade [%drive%:] completamente otimizada. >> "%log%"
echo.
echo UNIDADE [%drive%:] OTIMIZADA COM SUCESSO!
pause
goto FIM_OPERACAO

:INTERNET
cls
echo REPARANDO CONEXAO DE INTERNET...
echo [%time%] [INTERNET] Iniciando redefinicao da rede... >> "%log%"
ipconfig /release >> "%log%" 2>&1
ipconfig /flushdns >> "%log%" 2>&1
ipconfig /renew >> "%log%" 2>&1
netsh winsock reset >> "%log%" 2>&1
echo [%time%] [INTERNET] Adaptador limpo e renovado. >> "%log%"
echo INTERNET REPARADA!
pause
goto FIM_OPERACAO

:DIAGNOSTICO
cls
echo =====================================
echo DIAGNOSTICO DE HARDWARE
echo =====================================
echo [%time%] [DIAGNOSTICO] Abrindo analise fisica... >> "%log%"
echo.
echo [1/2] Verificando saude do(s) Disco(s) Rigido(s):
wmic diskdrive get model,status >> "%log%" 2>&1
wmic diskdrive get model,status
echo.
echo [2/2] Gerando relatorio de Bateria (Apenas para Portateis)...
powercfg /batteryreport /output "%~dp0Relatorio_Bateria_BlankOS.html" >> "%log%" 2>&1
echo.
echo Se usas um Portatil, o relatorio foi gerado! A abrir no navegador...
start "" "%~dp0Relatorio_Bateria_BlankOS.html"
echo.
pause
goto FIM_OPERACAO

:WIFI
cls
echo =====================================
echo EXTRATOR DE SENHAS WI-FI
echo =====================================
echo [%time%] [WIFI] Varredura de interfaces... >> "%log%"
netsh wlan show profiles >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERRO: Nenhuma placa Wi-Fi encontrada ou servico desativado!
    pause
    goto MENU
)

set "wifi_log=%~dp0Senhas_WiFi_BlankOS.txt"
echo =================================== > "%wifi_log%"
echo       SENHAS WI-FI EXTRAIDAS        >> "%wifi_log%"
echo =================================== >> "%wifi_log%"
echo A extrair senhas, aguarda (pode levar alguns segundos)...

for /f "skip=9 tokens=2 delims=:" %%i in ('netsh wlan show profiles') do (
    for /f "tokens=*" %%a in ("%%i") do (
        echo [Rede: "%%a"] >> "%wifi_log%"
        netsh wlan show profile name="%%a" key=clear | findstr /I "Chave Key Clave" >> "%wifi_log%"
        echo. >> "%wifi_log%"
    )
)
echo.
echo Senhas extraidas com sucesso! A abrir o ficheiro para ti...
start notepad "%wifi_log%"
echo.
pause
goto FIM_OPERACAO

:SOBREVIVENCIA
cls
echo KIT DE SOBREVIVENCIA...
echo [%time%] [SOBREVIVENCIA] Executando manutencao de estabilidade... >> "%log%"
taskkill /F /FI "STATUS eq NOT RESPONDING" >> "%log%" 2>&1
sc stop DiagTrack >> "%log%" 2>&1
sc config DiagTrack start= disabled >> "%log%" 2>&1
echo COMANDOS EXECUTADOS!
pause
goto FIM_OPERACAO

:EXTREMO
cls
color 0C
echo ATIVANDO MODO DESEMPENHO EXTREMO...
echo [%time%] [DESEMPENHO] Modificando energia e latencias... >> "%log%"
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >> "%log%" 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >> "%log%" 2>&1
bcdedit /set disabledynamictick yes >> "%log%" 2>&1
bcdedit /set useplatformclock no >> "%log%" 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >> "%log%" 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >> "%log%" 2>&1
echo DESEMPENHO EXTREMO ATIVADO! (Reinicia o PC)
pause
color 09
goto FIM_OPERACAO

:BATATA
cls
echo ALTERNANDO MODO BATATA GRAFICO...
echo [%time%] [TOGGLE BATATA] Alternando efeitos visuais... >> "%log%"
set "FX=NULO"
for /f "tokens=3" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting 2^>nul') do set "FX=%%A"
if "%FX%"=="0x2" (
    echo A ligar Modo Batata (Mais FPS)...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >> "%log%" 2>&1
) else (
    echo A desligar Modo Batata (Visual Normal)...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >> "%log%" 2>&1
)
echo Efeitos aplicados no proximo inicio de sessao.
pause
goto FIM_OPERACAO

:HIBERNACAO
cls
echo ALTERNANDO MODO HIBERNACAO...
echo [%time%] [TOGGLE HIBERNACAO] Lendo estado fisico da Hibernacao... >> "%log%"
set "HIBER=NULO"
for /f "tokens=3" %%H in ('reg query "HKLM\System\CurrentControlSet\Control\Power" /v HibernateEnabled 2^>nul') do set "HIBER=%%H"
if "%HIBER%"=="0x0" (
    echo A ativar Hibernacao...
    powercfg.exe /hibernate on >> "%log%" 2>&1
) else (
    echo A desativar Hibernacao (Libertando espaco em disco)...
    powercfg.exe /hibernate off >> "%log%" 2>&1
)
echo Comando executado.
pause
goto FIM_OPERACAO

:ANTIVIRUS
cls
echo VARREDURA DO DEFENDER...
echo [%time%] [ANTIVIRUS] Varredura ativa iniciada... >> "%log%"
taskkill /F /IM "xmrig.exe" /T >> "%log%" 2>&1
taskkill /F /IM "minerd.exe" /T >> "%log%" 2>&1
taskkill /F /IM "ethminer.exe" /T >> "%log%" 2>&1
if exist "%ProgramFiles%\Windows Defender\MpCmdRun.exe" (
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1 >> "%log%"
    echo VARREDURA CONCLUIDA!
) else (
    echo Defender nao encontrado.
)
pause
goto FIM_OPERACAO

:NORMAL
cls
echo RESTAURANDO NORMAL...
echo [%time%] [RESTAURAR] Retrocesso dos parametros... >> "%log%"
powercfg -setactive SCHEME_BALANCED >> "%log%" 2>&1
bcdedit /deletevalue disabledynamictick >> "%log%" 2>&1
bcdedit /deletevalue useplatformclock >> "%log%" 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >> "%log%" 2>&1
echo TUDO RESTAURADO!
pause
goto FIM_OPERACAO

:: 3. O CORACAO DO SISTEMA DE TELEMETRIA (FIM DA OPERACAO)
:FIM_OPERACAO
echo.
echo =====================================================================================
echo                     SISTEMA DE TELEMETRIA E GERENCIAMENTO DE LOGS
echo =====================================================================================
echo  As operacoes foram concluidas e gravadas em tempo real na memoria do ficheiro.
echo.

:PERGUNTA_LOG
set "manter_log="
set /p manter_log="Desejas MANTER o relatorio de LOG detalhado no teu Ambiente de Trabalho? (S/N): "

:: BLINDAGEM: Se carregar no Enter vazio, devolve à pergunta
if not defined manter_log goto PERGUNTA_LOG

:: Remove espacos vazios
set "manter_log=%manter_log: =%"

if /I "[%manter_log%]"=="[N]" (
    del /f /q "%log%" >nul 2>&1
    echo.
    echo [OK] Relatorio de operacao apagado com sucesso!
    timeout /t 2 >nul
    goto MENU
) else if /I "[%manter_log%]"=="[S]" (
    echo.
    echo [OK] Relatorio detalhado guardado com sucesso em:
    echo "%log%"
    pause
    goto MENU
) else (
    echo.
    echo ERRO: Opcao invalida! Pressiona apenas a letra 'S' para Sim ou 'N' para Nao.
    goto PERGUNTA_LOG
)