program SDT;

uses
  Forms,
  Main in 'View\Main.pas' {frmMain},
  ToolLib in 'Unit\ToolLib.pas',
  About in 'View\About.pas' {frmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Digi7Segment';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
