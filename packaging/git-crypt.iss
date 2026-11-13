; Inno Setup script for the Windows installer built by
; .github/workflows/release.yml:
;
;   ISCC.exe /DVersion=0.9.0 /DSourceExe=C:\path\to\git-crypt.exe
;            /OC:\output\dir /Fgit-crypt-0.9.0-x86_64-setup packaging\git-crypt.iss
;
; It installs git-crypt.exe for the current user (no administrator rights
; needed) and adds its directory to the user's PATH: the filters git-crypt
; configures run it by its bare name (docs/adr/0001-filter-commands-use-bare-git-crypt-name.md).
; Uninstalling removes the directory from PATH again.

#ifndef Version
  #error Pass the version with /DVersion=...
#endif
#ifndef SourceExe
  #error Pass the path of git-crypt.exe with /DSourceExe=...
#endif

[Setup]
AppId={{5D3E775E-20AD-4270-AF80-C7DE2CB69E9A}
AppName=git-crypt
AppVersion={#Version}
AppPublisher=modern-swift-dev
AppPublisherURL=https://github.com/modern-swift-dev/git-crypt
DefaultDirName={autopf}\git-crypt
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
ChangesEnvironment=yes
LicenseFile=..\COPYING
UninstallDisplayName=git-crypt {#Version}
WizardStyle=modern
Compression=lzma2
SolidCompression=yes

[Files]
Source: "{#SourceExe}"; DestDir: "{app}"; DestName: "git-crypt.exe"; Flags: ignoreversion

[Registry]
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}"; Check: NeedsAddPath(ExpandConstant('{app}'))

[Code]
// Position of ";Dir;" in ";Path;" (case-insensitive), or 0.
function PathEntryPos(Path, Dir: string): Integer;
begin
  Result := Pos(';' + Uppercase(Dir) + ';', ';' + Uppercase(Path) + ';');
end;

function NeedsAddPath(Dir: string): Boolean;
var
  Path: string;
begin
  if not RegQueryStringValue(HKCU, 'Environment', 'Path', Path) then
    Result := True
  else
    Result := PathEntryPos(Path, Dir) = 0;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Path, Dir, Wrapped: string;
  P: Integer;
begin
  if CurUninstallStep <> usPostUninstall then
    exit;
  Dir := ExpandConstant('{app}');
  if not RegQueryStringValue(HKCU, 'Environment', 'Path', Path) then
    exit;
  P := PathEntryPos(Path, Dir);
  if P = 0 then
    exit;
  // Remove ";Dir" from ";Path;", then the added semicolons.
  Wrapped := ';' + Path + ';';
  Delete(Wrapped, P, Length(Dir) + 1);
  Path := Copy(Wrapped, 2, Length(Wrapped) - 2);
  RegWriteExpandStringValue(HKCU, 'Environment', 'Path', Path);
end;
