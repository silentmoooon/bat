::����Ѹ��Ȩ��
::�м�ᵯ��һ������,������ж��Ѹ��WFP������,����uninstall�����ж��
@echo off
::ͨ��ע����ҵ�Ѹ�׵İ�װĿ¼
for /f "tokens=1,2 delims=:" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\thunder_is1" /v "InstallLocation"') do (
    set "FilePathL=%%a"
    set "FilePathR=%%b"
)
set "FilePath=%FilePathL:~-1%:%FilePathR%"  

"C:\Program Files (x86)\Common Files\Thunder Network\ServicePlatform\UnInstall.exe"
"%FilePath%\UninstallXLWFP.exe"
::��BHOĿ¼�µ����н��̶�����ȫԱ�ܾ�
@For /r "%FilePath%\BHO" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

 




::��Ѹ�׵������ļ��н���ȫԱ�ܾ�
@For /r "C:\Program Files (x86)\Common Files\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::ֹͣXLServicePlatform��XLNXService��XMPService�����Լ�XLGuard��XPWFP��2�����صķ���
net stop XLServicePlatform
net stop XLGuard
net stop XLWFP


::ɾ��5��Ѹ�׷�����ص�ע�����
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLWFP /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLGuard /f
::����Ҫ������̿ռ�,����һ��
::REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLServicePlatform /f
reg DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{9FB5F2D4-203E-41D2-932F-6DE145F9756C} /f


::ɾ��2�����ط�����ص��ļ����ÿ��ļ����������Ȩ��
Cacls  C:\Windows\System32\drivers\XLGuard.sys /E /R Everyone 
Cacls  C:\Windows\System32\drivers\XLWFP.sys /E /R Everyone 
del /f C:\Windows\System32\drivers\XLGuard.sys
del /f C:\Windows\System32\drivers\XLWFP.sys
cd C:\Windows\System32\drivers
type nul > XLGuard.sys
type nul > XLWFP.sys
cacls "C:\Windows\System32\drivers\XLGuard.sys" /E /D Everyone
cacls "C:\Windows\System32\drivers\XLWFP.sys" /E /D Everyone 
pause


 