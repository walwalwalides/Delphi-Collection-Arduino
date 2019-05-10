{ ============================================
  Software Name : 	Digi7Segment
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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CPort, CPortCtl, Vcl.Samples.Spin, Vcl.Buttons, Vcl.ComCtrls;

const
  iniSetting = 'ConnectionSetting.ini';

type
  TModeControle = (MdNormal, MdTimer);

type
  TfrmMain = class(TForm)
    ComPort: TComPort;
    Memo: TMemo;
    chkPoint: TCheckBox;
    spedtSeg: TSpinEdit;
    Button_Open: TBitBtn;
    Button_Settings: TBitBtn;
    Bt_Store: TBitBtn;
    Bt_Load: TBitBtn;
    GrBoxIniFile: TGroupBox;
    GrBoxControle: TGroupBox;
    bvlbottom: TBevel;
    tmr7Seg: TTimer;
    BitBtnTimer: TBitBtn;
    TrackBarTimer: TTrackBar;
    procedure Button_OpenClick(Sender: TObject);
    procedure Button_SettingsClick(Sender: TObject);
    procedure ComPortOpen(Sender: TObject);
    procedure ComPortClose(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure Bt_LoadClick(Sender: TObject);
    procedure Bt_StoreClick(Sender: TObject);
    procedure spedtSegChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkPointClick(Sender: TObject);
    procedure tmr7SegTimer(Sender: TObject);
    procedure BitBtnTimerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBarTimerChange(Sender: TObject);
  private
    procedure SendValueto7Segment;
    procedure SerialConnection;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

var
  ModeCon: TModeControle;
  MainPath: string;

  arr: array [0 .. 9] of string = (
    '0#',
    '1#',
    '2#',
    '3#',
    '4#',
    '5#',
    '6#',
    '7#',
    '8#',
    '9#'
  );
  kpos: Byte = 0;

procedure TfrmMain.Button_OpenClick(Sender: TObject);
begin
  if (tmr7Seg.Enabled) then
    tmr7Seg.Enabled := False;
  if ComPort.Connected then
    ComPort.Close
  else
    ComPort.Open;
end;

procedure TfrmMain.Button_SettingsClick(Sender: TObject);
begin
  ComPort.ShowSetupDialog;
  ComPort.StoreSettings(stIniFile, MainPath);
end;

procedure TfrmMain.chkPointClick(Sender: TObject);
begin
  SendValueto7Segment;
end;

procedure TfrmMain.SendValueto7Segment;
var
  Str: string;
begin
  Str := IntToStr(spedtSeg.Value);
  if (chkPoint.Checked) then
  begin
    Str := Str + '.';
  end;
  Str := Str + '#';
  ComPort.WriteStr(Str);
end;

procedure TfrmMain.SerialConnection;
begin
  if ComPort.Connected then
    ComPort.Close
  else
    ComPort.Open;
end;

procedure TfrmMain.ComPortOpen(Sender: TObject);
begin
  Button_Open.Caption := 'Not Connect';

end;

procedure TfrmMain.ComPortClose(Sender: TObject);
begin
  if Button_Open <> nil then
    Button_Open.Caption := 'Connect';
end;

procedure TfrmMain.ComPortRxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  ComPort.ReadStr(Str, Count);

  if (ModeCon = MdTimer) then
  begin
    Memo.Text := Memo.Text + Str;
    Memo.Lines.Delete(Memo.Lines.Count - 2);
  end;

  if (ModeCon = MdNormal) then
  begin
    Memo.Text := Memo.Text + Str;
  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (tmr7Seg.Enabled) then
  begin
    tmr7Seg.Enabled := False;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // initial spinedit
  spedtSeg.MinValue := 0;
  spedtSeg.maxValue := 9;
  spedtSeg.EditorEnabled := False;

  // ------------------------------------- //
  TrackBarTimer.Position:=10;

  MainPath := ExtractFilePath(Application.exename) + iniSetting;
  ModeCon := MdNormal;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  // Check iniFile Exist
  if FileExists(MainPath) then
  begin
    ComPort.LoadSettings(stIniFile, MainPath);
    SerialConnection;
  end
  else
  begin
    ComPort.ShowSetupDialog;
    ComPort.StoreSettings(stIniFile, MainPath);
    SerialConnection;
  end;

end;

procedure TfrmMain.spedtSegChange(Sender: TObject);
begin
  SendValueto7Segment;
end;

procedure TfrmMain.tmr7SegTimer(Sender: TObject);
begin
  ComPort.WriteStr(arr[kpos]);
  if (kpos = 9) then
    kpos := 0
  else
    inc(kpos, 1);
end;

procedure TfrmMain.TrackBarTimerChange(Sender: TObject);
begin
  tmr7Seg.interval := TrackBarTimer.Position * 100;    // position 10 = 1s
end;

procedure TfrmMain.BitBtnTimerClick(Sender: TObject);
begin
  if not(tmr7Seg.Enabled) then
  begin
    Memo.Clear;
    Memo.Lines[0] := 'Timer active -> ';
    Memo.Lines[1] := sLineBreak;
    spedtSeg.Enabled := False;
    chkPoint.Checked := False;
    chkPoint.Enabled := False;
    BitBtnTimer.Caption := 'Stop';
    tmr7Seg.Enabled := True;
    ModeCon := MdTimer;
  end
  else
  begin
    Memo.Lines[1] := 'Timer deactive <- ' + Memo.Lines[0];
    Memo.Lines.Delete(Memo.Lines.Count - 2);

    spedtSeg.Enabled := True;
    chkPoint.Enabled := True;

    BitBtnTimer.Caption := 'Start';
    tmr7Seg.Enabled := False;
    ModeCon := MdNormal;
  end;

end;

procedure TfrmMain.Bt_LoadClick(Sender: TObject);
begin
  ComPort.LoadSettings(stIniFile, MainPath);
end;

procedure TfrmMain.Bt_StoreClick(Sender: TObject);
begin
  ComPort.StoreSettings(stIniFile, MainPath);
end;

end.
