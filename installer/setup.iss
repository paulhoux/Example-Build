; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#include "revision.h"

#define MyAppName "Example"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Paul Houx"
#define MyAppURL "http://www.libcinder.org/"
#define MyAppExeName "Example.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{157CD28A-E735-44D6-A73D-657A4963B91E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=.\license.txt
InfoBeforeFile=.\before.txt
InfoAfterFile=.\after.txt
OutputDir=..
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Dirs]
Name: "{app}\config"; Permissions: users-modify;   
Name: "{app}\logs"; Permissions: users-modify;   
Name: "{app}\screenshots"; Permissions: users-modify;

[Files]
Source: "..\application\vc2013\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\assets\*"; DestDir: "{app}\assets"; Flags: skipifsourcedoesntexist recursesubdirs    
; Install dll's.
;Source: "..\application\lib\spout\*.dll"; DestDir: "{app}"; Flags: skipifsourcedoesntexist;
; Install default config file.
Source: ".\settings.cfg"; DestDir: "{app}\config"; DestName: "settings.cfg"; Flags: skipifsourcedoesntexist;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[UninstallDelete]
Type: files; Name: "{app}\config\*.*"    
Type: files; Name: "{app}\logs\*.*"     
Type: files; Name: "{app}\screenshots\*.*"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{#MyAppName} Screenshots"; Filename: "{app}\screenshots"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

