program RGB_LED_MIXER;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form11};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm11, Form11);
  Application.Run;
end.
