rem 限制迅雷权限

rem 中间会弹出一个窗口,是用来卸载迅雷WFP驱动的,请点击uninstall以完成卸载


@echo off
::通过注册表找到迅雷的安装目录
for /f "tokens=1,2 delims=:" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\thunder_is1" /v "InstallLocation"') do (
    set "FilePathL=%%a"
    set "FilePathR=%%b"
)
set "FilePath=%FilePathL:~-1%:%FilePathR%"

::对目录下的所有进程都进行全员拒绝
@For /r "%FilePath%" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::对目录下的所有进程都进行全员拒绝
@For /r "%FilePath%..\XMP" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::依次对Thundexe.exe(迅雷主进程)进行禁用SYSTEM权限、移除管理员组权限以及移除刚刚批量操作增加的全员拒绝权限
Cacls  "%FilePath%Program\Thunder.exe" /E /R Everyone 
Cacls  "%FilePath%Program\Thunder.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\Thunder.exe" /E /R Administrators   

::同上一进程
Cacls  "%FilePath%Program\ThunderNewTask.exe" /E /R Everyone 
Cacls  "%FilePath%Program\ThunderNewTask.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\ThunderNewTask.exe" /E /R Administrators

::同上一进程
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /R Everyone 
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\ThunderUninstall.exe" /E /R Administrators
 
::同上一进程
Cacls  "%FilePath%Program\LiveUDInstaller.exe" /E /R Everyone 
Cacls  "%FilePath%Program\LiveUDInstaller.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\LiveUDInstaller.exe" /E /R Administrators
 

::同上一进程
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /R Everyone  
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /D SYSTEM
Cacls  "%FilePath%Program\XLLiveUD.exe" /E /R Administrators

::同上一进程
Cacls  "%FilePath%Program\XLBugReport.exe" /E /R Everyone  
Cacls  "%FilePath%Program\XLBugReport.exe" /E /d SYSTEM
Cacls  "%FilePath%Program\XLBugReport.exe" /E /R Administrators 

::同上一进程
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /R Everyone  
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /d SYSTEM
Cacls  "%FilePath%Program\SDK\DownloadSDKServer.exe" /E /R Administrators 




::对迅雷的其他文件夹进行全员拒绝
@For /r "C:\Program Files (x86)\Common Files\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 
@For /r "%USERPROFILE%\AppData\Roaming\XLGameBox" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 
@For /r "C:\Users\Public\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::停止XLServicePlatform、XLNXService、XMPService服务以及XLGuard、XPWFP这2个隐藏的服务
net stop XLServicePlatform
net stop XLNXService
net stop XLGuard
net stop XLWFP
net stop XMPService

 ::解除迅雷自带的卸载WFP驱动进程的权限,并调用
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /d SYSTEM
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /R Administrators
Cacls  "C:\Program Files (x86)\Thunder Network\Thunder9\UninstallXLWFP.exe" /E /R Everyone 
"%FilePath%UninstallXLWFP.exe"

::删除5个迅雷服务相关的注册表项
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLWFP /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLGuard /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLNXService /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLServicePlatform /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XMPService /f

::删除2个隐藏服务相关的文件并用空文件替代并禁用权限
del /f C:\Windows\System32\drivers\XLGuard.sys
del /f C:\Windows\System32\drivers\XLWFP.sys
cd C:\Windows\System32\drivers
type nul > XLGuard.sys
type nul > XLWFP.sys
cacls "C:\Windows\System32\drivers\XLGuard.sys" /E /D Everyone
cacls "C:\Windows\System32\drivers\XLWFP.sys" /E /D Everyone 
pause


 