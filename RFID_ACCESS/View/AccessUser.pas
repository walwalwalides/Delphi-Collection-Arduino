{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit AccessUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, CPort, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.AppEvnts, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.Menus, acPNG;

const
  iniSetting = 'ConnectionSetting.ini';

type
  TfrmAccessUser = class(TfrmBase)
    bvlbottom: TBevel;
    GrBoxConnection: TGroupBox;
    Bt_Load: TBitBtn;
    Bt_Store: TBitBtn;
    Button_Settings: TBitBtn;
    bitbtnConnec: TBitBtn;
    Memo: TMemo;
    ComPort: TComPort;
    GrBoxMenu: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtnClose: TBitBtn;
    BitBtn6: TBitBtn;
    procedure bitbtnConnecClick(Sender: TObject);
    procedure Button_SettingsClick(Sender: TObject);
    procedure Bt_LoadClick(Sender: TObject);
    procedure Bt_StoreClick(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure MemoChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

  TModeControle = (MdNormal, MdTimer);

var
  frmAccessUser: TfrmAccessUser;

implementation

uses
  MainModule, uUser, UStrRes;

{$R *.dfm}

var
  listUser: TUser;
  ModeCon: TModeControle;
  PathMainIni: string; // ini path for serial connection parametre

procedure TfrmAccessUser.BitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmAccessUser.BitBtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmAccessUser.Bt_LoadClick(Sender: TObject);
begin
  inherited;
  ComPort.LoadSettings(stIniFile, PathMainIni);
end;

procedure TfrmAccessUser.Bt_StoreClick(Sender: TObject);
begin
  inherited;
  try
    ComPort.StoreSettings(stIniFile, PathMainIni);
  finally
    Bt_Store.Enabled := False;
  end;
end;

procedure TfrmAccessUser.bitbtnConnecClick(Sender: TObject);
begin
  inherited;
  if ComPort.Connected then
  begin
    ComPort.close;
    bitbtnConnec.Caption := 'Connect';
    lblSubCaption.Caption := ConecRFID_Name + ' disconnected at ' + DateTimeToStr(now);
  end
  else
  begin
    ComPort.Open;
    bitbtnConnec.Caption := 'DecConnect';
    lblSubCaption.Caption := ConecRFID_Name + ' connected at ' + DateTimeToStr(now);
  end;

end;

procedure TfrmAccessUser.Button_SettingsClick(Sender: TObject);
begin
  inherited;
  ComPort.ShowSetupDialog;
  ComPort.StoreSettings(stIniFile, PathMainIni);
  Bt_Store.Enabled := True;
end;

procedure TfrmAccessUser.ComPortRxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  inherited;

  ComPort.ReadStr(Str, Count);

  // if (ModeCon = MdTimer) then
  // begin
  // Memo.Text := Memo.Text + Str;
  // Memo.Lines.Delete(Memo.Lines.Count - 2);
  // end;

  if (ModeCon = MdNormal) then
  begin
    // Memo.Lines.Add( Str );
    Memo.Text := Memo.Text + Str;

  end;

end;

procedure TfrmAccessUser.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfrmAccessUser.FormCreate(Sender: TObject);
begin
  inherited;
  ControleForm := False;
  PathMainIni := ExtractFilePath(Application.exename) + iniSetting;
  ModeCon := MdNormal;

end;

procedure TfrmAccessUser.FormShow(Sender: TObject);
begin
  inherited;
  self.Top:=frmBase.top+40;
  self.left:=frmBase.left+5;

  if FileExists(PathMainIni) then
    ComPort.LoadSettings(stIniFile, PathMainIni);
end;

procedure TfrmAccessUser.imgCloseClick(Sender: TObject);
begin
  inherited;

  frmAccessUser.CloseModal;

end;

procedure TfrmAccessUser.MemoChange(Sender: TObject);
var
  sMem: string;
begin
  inherited;
  sMem := Memo.Lines[Memo.Lines.Count - 1];
  if Length(sMem) = 11 then
  begin
    if (DMMainModule.checkUIDexist(sMem) = True) then
    begin

      listUser := DMMainModule.GetUserDaten(sMem);
      sMem := listUser.lastName + ',' + listUser.firstName + ' | ' + DateTimeToStr(now) + ' | ' + ' (ACCESS SUCCESS) ' + '.';

    end
    else
      sMem := '(NO ACCESS) ' + '.';
    ShowMessage(sMem);
  end;
end;

end.
