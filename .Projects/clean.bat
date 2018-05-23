if not [%1] == [] goto nope
cd ..
rd /s /q EXEs
md EXEs
rd /s /q LOVEs
md LOVEs
rd /s /q ZIPs
md ZIPs
rd /s /q APPs
md APPs
:nope