@ECHO OFF

CD /D %~dp0
powershell -ExecutionPolicy Bypass -Command ".\listLinks.ps1"