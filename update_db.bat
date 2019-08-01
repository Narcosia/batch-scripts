REM Add a shortcut of script to C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup


@ECHO OFF
TITLE Update DB
set ip_address=""
set ip_address_string="IPv4 Address"
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do (
    set ip_address=%%f
	SETLOCAL EnableDelayedExpansion
	SET ip_address=!ip_address: =!
	@echo UPDATE `hdz_settings` SET `value` = 'http://!ip_address!/support' WHERE `hdz_settings`.`field` = 'site_url';>C:\scripts\update_db.sql
	SETLOCAL DisableDelayedExpansion
)
start /b C:\xampp\mysql\bin\mysql.exe --user=root --password=PASSWORD db1 < C:\scripts\update_db.sql > C:\scripts\output.tab
