unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Base, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, acPNG;

type
  TfrmMain = class(TfrmBase)
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  ControleForm := True;
end;

end.
