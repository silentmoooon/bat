rem ����Ѹ��Ȩ��

rem �м�ᵯ��һ������,������ж��Ѹ��WFP������,����uninstall�����ж��


@echo off
::ͨ��ע����ҵ�Ѹ�׵İ�װĿ¼
for /f "tokens=1,2 delims=:" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\thunder_is1" /v "InstallLocation"') do (
    set "FilePathL=%%a"
    set "FilePathR=%%b"
)
set "FilePath=%FilePathL:~-1%:%FilePathR%"

::��Ŀ¼�µ����н��̶�����ȫԱ�ܾ�
@For /r "%FilePath%" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::��Ŀ¼�µ����н��̶�����ȫԱ�ܾ�
@For /r "%FilePath%..\XMP" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::���ζ�Thundexe.exe(Ѹ��������)���н���SYSTEMȨ�ޡ��Ƴ�����Ա��Ȩ���Լ��Ƴ��ո������������ӵ�ȫԱ�ܾ�Ȩ��
Cacls  "%FilePath%Program\Thunder.exe" /E /R Everyone 
Cacls  "%FilePath%Program\Thunder.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\Thunder.exe" /E /R Administrators


::ͬ��һ����
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /R Everyone 
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /R Administrators
 

::ͬ��һ����
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /R Everyone  
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /R Administrators


::ͬ��һ����
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /R Everyone  
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /d SYSTEM
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /R Administrators 


::��Ѹ�׵������ļ��н���ȫԱ�ܾ�
@For /r "C:\Program Files (x86)\Common Files\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 
@For /r "%USERPROFILE%\AppData\Roaming\XLGameBox" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 
@For /r "C:\Users\Public\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::ֹͣXLServicePlatform��XLNXService��XMPService�����Լ�XLGuard��XPWFP��2�����صķ���
net stop XLServicePlatform
net stop XLNXService
net stop XLGuard
net stop XLWFP
net stop XMPService

 ::���Ѹ���Դ���ж��WFP�������̵�Ȩ��,������
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /d SYSTEM
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /R Administrators
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /R Everyone 
"%FilePath%UninstallXLWFP.exe"

::ɾ��5��Ѹ�׷�����ص�ע�����
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLWFP /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLGuard /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLNXService /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLServicePlatform /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XMPService /f

::ɾ��2�����ط�����ص��ļ����ÿ��ļ����������Ȩ��
del /f C:\Windows\System32\drivers\XLGuard.sys
del /f C:\Windows\System32\drivers\XLWFP.sys
cd C:\Windows\System32\drivers
type nul > XLGuard.sys
type nul > XLWFP.sys
cacls "C:\Windows\System32\drivers\XLGuard.sys" /E /D Everyone
cacls "C:\Windows\System32\drivers\XLWFP.sys" /E /D Everyone 
pause


 