::限制迅雷权限
::中间会弹出一个窗口,是用来卸载迅雷WFP驱动的,请点击uninstall以完成卸载
@echo off
::通过注册表找到迅雷的安装目录
for /f "tokens=1,2 delims=:" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\thunder_is1" /v "InstallLocation"') do (
    set "FilePathL=%%a"
    set "FilePathR=%%b"
)
set "FilePath=%FilePathL:~-1%:%FilePathR%"  

"C:\Program Files (x86)\Common Files\Thunder Network\ServicePlatform\UnInstall.exe"
"%FilePath%\UninstallXLWFP.exe"
::对BHO目录下的所有进程都进行全员拒绝
@For /r "%FilePath%\BHO" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

 




::对迅雷的其他文件夹进行全员拒绝
@For /r "C:\Program Files (x86)\Common Files\Thunder Network" %%i In (*.exe) Do  Cacls  "%%i" /E /D Everyone 

::停止XLServicePlatform、XLNXService、XMPService服务以及XLGuard、XPWFP这2个隐藏的服务
net stop XLServicePlatform
net stop XLGuard
net stop XLWFP


::删除5个迅雷服务相关的注册表项
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLWFP /f
REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLGuard /f
::由于要申请磁盘空间,放它一马
::REG DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XLServicePlatform /f
reg DELETE  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{9FB5F2D4-203E-41D2-932F-6DE145F9756C} /f


::删除2个隐藏服务相关的文件并用空文件替代并禁用权限
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


 