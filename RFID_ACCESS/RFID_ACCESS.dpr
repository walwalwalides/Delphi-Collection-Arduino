program RFID_ACCESS;

uses
  Vcl.Forms,
  Base in 'View\Base.pas' {frmBase},
  UStates in 'Unit\UStates.pas',
  UStrRes in 'Unit\UStrRes.pas',
  AccessUser in 'View\AccessUser.pas' {frmAccessUser},
  UScript in 'Unit\UScript.pas',
  NewUser in 'View\NewUser.pas' {frmNewUser},
  MainModule in 'Module\MainModule.pas' {DMMainModule: TDataModule},
  uUser in 'Module\uUser.pas',
  LogUser in 'View\LogUser.pas' {frmLogUser};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBase, frmBase);
  Application.CreateForm(TfrmAccessUser, frmAccessUser);
  Application.CreateForm(TfrmNewUser, frmNewUser);
  Application.CreateForm(TDMMainModule, DMMainModule);
  Application.CreateForm(TfrmLogUser, frmLogUser);
  Application.Run;
end.
