program OLEDDisplay;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  ToolLib in 'Unit\ToolLib.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Digi7Segment';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
