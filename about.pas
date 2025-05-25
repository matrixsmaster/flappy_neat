unit about;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    function GetVer(vstring: string): string;
  end;
  
const
  vspath = 'StringFileInfo\040904E4\';

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

function TAboutBox.GetVer(vstring: string): string;
var
  S: string;
  n, Len: DWORD;
  Buf: PChar;
  Value: PChar;
begin
  Result := '';
  { From Delphi help example }
  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    if VerQueryValue(Buf, PChar(vspath+vstring), Pointer(Value), Len) then
      Result := Value;
    FreeMem(Buf, n);
  end;
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
  Version.Caption := 'Ver. ' + GetVer('FileVersion');
  Copyright.Caption := GetVer('LegalCopyright');
  Comments.Caption := GetVer('Comments');
end;

end.

