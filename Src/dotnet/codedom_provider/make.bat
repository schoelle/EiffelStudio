@echo off

REM Setup Eiffel CodeDom Provider Eiffel ENViSioN! projects

if exist build rd /q /s build

mkdir build
mkdir build\ISE.Base
mkdir build\ISE.Base\obj
mkdir build\ISE.Base\obj\Debug
mkdir build\ISE.Base\obj\Release
mkdir build\ISE.EiffelVision2
mkdir build\ISE.EiffelVision2\obj
mkdir build\ISE.EiffelVision2\obj\Debug
mkdir build\ISE.EiffelVision2\obj\Release
mkdir build\ISE.CacheBrowser
mkdir build\ISE.CacheBrowser\obj
mkdir build\ISE.CacheBrowser\obj\Debug
mkdir build\ISE.CacheBrowser\obj\Release
mkdir build\ISE.EiffelCodeDomProvider
mkdir build\ISE.EiffelCodeDomProvider\obj
mkdir build\ISE.EiffelCodeDomProvider\obj\Debug
mkdir build\ISE.EiffelCodeDomProvider\obj\Release

copy configuration\base.eifp build\ISE.Base\ISE.Base.eifp
copy configuration\vision2.eifp build\ISE.EiffelVision2\ISE.EiffelVision2.eifp
copy configuration\cache_browser.eifp build\ISE.CacheBrowser\ISE.CacheBrowser.eifp
copy configuration\codedom_provider.eifp build\ISE.EiffelCodeDomProvider\ISE.EiffelCodeDomProvider.eifp

copy configuration\codedom_provider.sln build\