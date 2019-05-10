{ ============================================
  Software Name : 	ESP32LED
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cyAdvLed, cyDBAdvLed, Vcl.StdCtrls, cyLabel, Rest.client,
  System.Net.httpClient, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls;

const
  URLWiFi = 'http://192.168.2.102/';

type
  TfrmMain = class(TForm)
    btnOK: TButton;
    Led1: TcyAdvLed;
    Led2: TcyAdvLed;
    btnLed2: TButton;
    bvlLeft: TBevel;
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    statbrESP32LED: TStatusBar;
    // Declaration all proceduren
    procedure btnOKClick(Sender: TObject);
    procedure btnLed2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure Initialize;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses IdHTTP, System.IniFiles;

var
  GlobalHttp: TIDHttp;
  linkOnLED1, linkOffLED1: WideString;
  linkOnLED2, linkOffLED2: WideString;

procedure TfrmMain.btnLed2Click(Sender: TObject);
var
  http: TIDHttp;
  jsonToSend: TStringList;
begin

  if not(Led2.Ledvalue) then    // Led2 On
  begin

    http := TIDHttp.Create(nil);
    http.HandleRedirects := True;
    http.ReadTimeout := 5000;
    jsonToSend := TStringList.Create;
    jsonToSend.Add('{ Your JSON-encoded request goes here }');
    Screen.Cursor := crHourGlass;
    try
      http.Get(linkOnLED2);
    except
      jsonToSend.Destroy;
      http.Destroy;
      Screen.Cursor := crDefault;
      exit;
    end;
    Led2.Ledvalue := True;
    jsonToSend.Destroy;
    http.Destroy;
    Screen.Cursor := crDefault;

  end
  else
  begin                     // Led2 Off

    http := TIDHttp.Create(nil);
    http.HandleRedirects := True;
    http.ReadTimeout := 5000;
    jsonToSend := TStringList.Create;
    jsonToSend.Add('{ Your JSON-encoded request goes here }');
      Screen.Cursor := crHourGlass;
    try
      http.Get(linkOffLED2);
    except
      jsonToSend.Destroy;
      http.Destroy;
      Screen.Cursor := crDefault;
      exit;
    end;
    Led2.Ledvalue := false;
    jsonToSend.Destroy;
    http.Destroy;
    Screen.Cursor := crDefault;

  end;

end;

procedure TfrmMain.btnOKClick(Sender: TObject);
var
  http: TIDHttp;
  jsonToSend: TStringList;

begin

  if not(Led1.Ledvalue) then // Led1 On
  begin

    http := TIDHttp.Create(nil);
    http.HandleRedirects := True;
    http.ReadTimeout := 5000;
    jsonToSend := TStringList.Create;
    jsonToSend.Add('{ Your JSON-encoded request goes here }');
    // send the request to ESP32
    Screen.Cursor := crHourGlass;
    try
      http.Get(linkOnLED1);
    except

      jsonToSend.Destroy;
      http.Destroy;
      Screen.Cursor := crDefault;
      exit;
    end;
    Led1.Ledvalue := True;
    jsonToSend.Destroy;
    http.Destroy;
    Screen.Cursor := crDefault;
  end
  else
  begin // Led Off

    http := TIDHttp.Create(nil);
    http.HandleRedirects := True;
    http.ReadTimeout := 5000;
    jsonToSend := TStringList.Create;
    jsonToSend.Add('{ Your JSON-encoded request goes here }');
    // send the request to ESP32
    Screen.Cursor := crHourGlass;
    try
      http.Get(linkOffLED1);
    except
      jsonToSend.Destroy;
      http.Destroy;
      Screen.Cursor := crDefault;
      exit;
    end;
    Led1.Ledvalue := false;
    jsonToSend.Destroy;
    http.Destroy;
    Screen.Cursor := crDefault;

  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  appINI: TIniFile;
  LastMDT: TDatetime;
begin
  LastMDT := now;
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    appINI.WriteString('Application', 'ESP32LED', 'Vr. 1.0.0');
    appINI.WriteDateTime('Last Modification', 'DATETIME', LastMDT);
    with appINI, frmMain do
    begin
      WriteBool('LED1', 'Enabled', Led1.Ledvalue);
      WriteBool('LED2', 'Enabled', Led2.Ledvalue);
    end;
  finally
    appINI.Free;
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  appINI: TIniFile;
  AppVersion: string;
  LastDate: TDatetime;
  boolStatLED: Boolean;

begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try

    AppVersion := appINI.ReadString('Application', 'ESP32LED', '');

    LastDate := appINI.ReadDateTime('Last Modification', 'DATETIME', Date);
    statbrESP32LED.Panels[0].Text := 'Last Modification : ' + DateTimeToStr(LastDate);
    statbrESP32LED.Panels[1].Text := 'App Version :  ' + AppVersion;

    Led1.Ledvalue := appINI.ReadBool('LED1', 'Enabled', boolStatLED);
    Led2.Ledvalue := appINI.ReadBool('LED2', 'Enabled', boolStatLED);
  finally
    appINI.Free;
  end;

end;

procedure TfrmMain.Initialize;
begin
  //

  linkOnLED1 := URLWiFi + '26/on';
  linkOffLED1 := URLWiFi + '26/off';
  // ................................. //
  linkOnLED2 := URLWiFi + '27/on';
  linkOffLED2 := URLWiFi + '27/off';
  // ................................. //

{$REGION 'SET ALL LEDs  (OFF)'}
  if not FileExists(ChangeFileExt(Application.ExeName, '.ini')) then
  begin
    Led1.Ledvalue := false;
    Led2.Ledvalue := false;
    GlobalHttp := TIDHttp.Create(nil);
    GlobalHttp.HandleRedirects := True;
    GlobalHttp.ReadTimeout := 5000;
    try
      GlobalHttp.Get(linkOffLED1);
      GlobalHttp.Get(linkOffLED2);

    finally
      GlobalHttp.Destroy;
    end;
  end;

{$ENDREGION}
  statbrESP32LED.Panels[0].Width := 220;
  statbrESP32LED.Panels[1].Width := 300;
  statbrESP32LED.Panels[1].Alignment := taCenter;
  frmMain.position := poMainFormCenter;
  frmMain.WindowState := wsMaximized;
end;

end.
