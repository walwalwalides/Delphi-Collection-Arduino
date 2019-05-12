unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Mixer, Vcl.StdCtrls, MixerCtl, Vcl.ExtCtrls;

type
  TForm11 = class(TForm)
    ComLedmixer1: TComLedmixer;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

procedure TForm11.FormCreate(Sender: TObject);
begin
 ComLedmixer1.Align:=alClient;
 Panel1.Color:=clWhite;
 Panel1.ParentColor:=False;
 Self.Position:=poMainFormCenter;


end;

end.
