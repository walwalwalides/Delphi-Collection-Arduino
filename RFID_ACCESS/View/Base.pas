{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, DwmApi, JvComponentBase, JvWndProcHook, acPNG, uStates, Vcl.Menus, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  Winapi.ShellAPI, Vcl.AppEvnts, UStrRes, CPort, Vcl.Buttons;

const
  WM_MaximizeWindow = WM_APP + $03;

type
  TProc = procedure of Object;
  TBorda = (bLeft, bTop, bRight, bBottom, bBottomLeft, bBottomRight);
  TTipoCor = (tcEscura, tcClara);

  TfrmBase = class(TForm)
    pnlActionBar: TPanel;
    pnlClose: TPanel;
    imgClose: TImage;
    pnlMinimize: TPanel;
    imgMinimize: TImage;
    pnlPrincipal: TPanel;
    pnlMaximize: TPanel;
    imgMaximize: TImage;
    lblCaption: TLabel;
    pnlTop: TPanel;
    pnlSubCaption: TPanel;
    lblSubCaption: TLabel;
    imgIcon: TImage;
    pnlTrayIcon: TPanel;
    imgTrayIcon: TImage;
    TrayIconBase: TTrayIcon;
    popMenuTrayIcon: TPopupMenu;
    itemShow: TMenuItem;
    itemClose: TMenuItem;
    ActLstApp: TActionList;
    ShowApplication: TAction;
    CloseApplication: TAction;
    ilApp: TImageList;
    ApplicationEvents1: TApplicationEvents;
    N1: TMenuItem;
    BallHintBase: TBalloonHint;
    GrBoxPrincipal: TGroupBox;
    BitBtnAccess: TBitBtn;
    BitBtnLogUser: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtnNewUser: TBitBtn;
    procedure pnlActionBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgCloseClick(Sender: TObject);
    procedure imgMinimizeClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgMaximizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgTrayIconClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShowApplicationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseApplicationExecute(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure TrayIconBaseDblClick(Sender: TObject);
    procedure BitBtnAccessClick(Sender: TObject);
    procedure BitBtnNewUserClick(Sender: TObject);
    procedure BitBtnLogUserClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FControleForm: Boolean;
    FSubCaption: String;
    FCaption: String;
    FFormColor: TColor;
    FWndFrameSize: Integer;
    function TipoMouse(ABorda: TBorda): TCursor;
    procedure setControleForm(const Value: Boolean);
    procedure setCaption(const Value: String);
    procedure setSubCaption(const Value: String);
    procedure setFormColor(const Value: TColor);
    function CorEscura(ACor: TColor): TColor;
    procedure OnAppChangeState(Sender: TObject);
    procedure Tray(ActInd: Integer);
    procedure AbortApp(Sender: TObject);
    procedure WMMaximizeWindow(var Message: TMessage); message WM_MaximizeWindow;
  public
    CanClose: Boolean;

    constructor Create(AOwner: TComponent; AControlarForm: Boolean = True);
    property ControleForm: Boolean read FControleForm write setControleForm;
    property FormColor: TColor read FFormColor write setFormColor;
  protected
    procedure WmNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    property Caption: String read FCaption write setCaption;
    property SubCaption: String read FSubCaption write setSubCaption;
  end;

  TStatePrepareUI = class(TInterfacedObject, IPAppState)
  private
    FEnumState: TPAppStateEnum;
  public
    constructor Create;
    procedure Execute;
    function EnumState: TPAppStateEnum;
  end;

  TStatePrepareDataBase = class(TInterfacedObject, IPAppState)
  private
    FEnumState: TPAppStateEnum;
  public
    constructor Create;
    procedure Execute;
    function EnumState: TPAppStateEnum;
  end;

  TStateShutDown = class(TInterfacedObject, IPAppState)
  private
    FEnumState: TPAppStateEnum;
  public
    constructor Create;
    procedure Execute;
    function EnumState: TPAppStateEnum;
  end;

  TStateDispacher = class(TInterfacedObject, IStateDispacher)
  private
    FAppState: TPAppState;
  public
    constructor Create;
    procedure Notify(Obj: TObject);
  end;

  TThreadDataQueue = class(TThread)
  public
    procedure Execute; override;
  end;

var
  frmBase: TfrmBase;
  PAppState: TPAppState;
  StateDispacher: TStateDispacher;
  IconIndex: byte;
  IconFull: TIcon;
  ThreadData: TThreadDataQueue;
  ilevel: Integer = 0;

implementation

uses
  AccessUser, NewUser, UScript, LogUser;

{$R *.dfm}

procedure TfrmBase.WMMaximizeWindow(var Message: TMessage);
begin
  Self.WindowState := wsMaximized;
end;

procedure TfrmBase.WmNCCalcSize(var Msg: TWMNCCalcSize);
var
  R: TRect;
begin
  if not Msg.CalcValidRects then
    R := PRect(Msg.CalcSize_Params)^;
  inherited;
  if Msg.CalcValidRects then
    Msg.CalcSize_Params.rgrc0 := Msg.CalcSize_Params.rgrc1
  else
    PRect(Msg.CalcSize_Params)^ := R;

  Msg.Result := 0;
end;

procedure TfrmBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 case ilevel of
      1:exit;
 end;


  CanClose := Self.CanClose;

  if (not CanClose) then
  begin

    Self.Visible := False;
    TrayIconBase.Visible := True;
    TrayIconBase.BalloonTitle := App_Name;
        TrayIconBase.BalloonHint := 'HIDE APPLICATION';
    TrayIconBase.BalloonFlags := bfInfo;
    TrayIconBase.ShowBalloonHint;

  end
  else
  begin
    if Assigned(ThreadData) then
      ThreadData.Free;

    PAppState.Free;
  end;

end;

procedure TfrmBase.OnAppChangeState(Sender: TObject);
begin
  //
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  CanClose := False;
  KeyPreview := true;
   BorderStyle := bsNone;
  lblCaption.Caption := App_Name;
  TrayIconBase.Visible := False;
  lblSubCaption.Caption := '------';
  frmBase.Constraints.MinWidth := 500;
  frmBase.Constraints.MinHeight := 500;

  SetWindowLong(Handle, GWL_STYLE, WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW);

  StateDispacher := TStateDispacher.Create;
  PAppState := TPAppState.Create(StateDispacher);
  PAppState.OnChangeState := OnAppChangeState;
  PAppState.ChangeState(stPrepareUI);

  ThreadData := TThreadDataQueue.Create(False);
  ThreadData.OnTerminate := AbortApp;

  // FormColor := clPurple;
  FormColor := $00DA8221;
end;

procedure TfrmBase.FormDestroy(Sender: TObject);
begin
  IconIndex := 0;
  Tray(2);
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if ((ssAlt in Shift) and (Key = VK_F4)) then
    Key := 0;
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  Width := (Width - 1);
end;

constructor TfrmBase.Create(AOwner: TComponent; AControlarForm: Boolean = True);
begin
  inherited Create(AOwner);
  ControleForm := AControlarForm;
end;

function TfrmBase.TipoMouse(ABorda: TBorda): TCursor;
begin
  case (ABorda) of
    bLeft, bRight:
      Result := crSizeWE;
    bTop, bBottom:
      Result := crSizeNS;
    bBottomLeft:
      Result := crSizeNESW;
    bBottomRight:
      Result := crSizeNWSE;
  end;
end;

procedure TfrmBase.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin



  if ((Button = mbLeft) and (FControleForm)) then
  begin
    ReleaseCapture;

    { Left Bottom }
    if (((X >= 0) and (X <= 8)) and ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight))) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMLEFT, 0);
      Exit;
    end;

    { Right Bottom }
    if (((X >= (Self.ClientWidth - 8)) and (X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight))) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMRIGHT, 0);
      Exit;
    end;

    { Left }
    if ((X >= 0) and (X <= 8)) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_LEFT, 0);
    end;

    { Right }
    if ((X >= (Self.ClientWidth - 8)) and (X <= Self.ClientWidth)) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_RIGHT, 0);
    end;

    { Bottom }
    if ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight)) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOM, 0);
    end;

    { Top }
    if ((Y >= 0) and (Y <= 10)) then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_TOP, 0);
    end;
  end;
end;

procedure TfrmBase.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (FControleForm) then
  begin
    { Left }
    if ((X >= 0) and (X <= 8)) then
    begin
      Self.Cursor := TipoMouse(bLeft);
    end;

    { Right }
    if ((X >= (Self.ClientWidth - 8)) and (X <= Self.ClientWidth)) then
    begin
      Self.Cursor := TipoMouse(bRight);
    end;

    { Bottom }
    if ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight)) then
    begin
      Self.Cursor := TipoMouse(bBottom);
    end;

    { Top }
    if ((Y >= 0) and (Y <= 10)) then
    begin
      Self.Cursor := TipoMouse(bTop);
    end;

    { Left Bottom }
    if (((X >= 0) and (X <= 8)) and ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight))) then
    begin
      Self.Cursor := TipoMouse(bBottomLeft);
    end;

    { Right Bottom }
    if (((X >= (Self.ClientWidth - 8)) and (X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight - 8)) and (Y <= Self.ClientHeight))) then
    begin
      Self.Cursor := TipoMouse(bBottomRight);
    end;
  end;
end;

procedure TfrmBase.imgCloseClick(Sender: TObject);
begin
  Self.CanClose := True;
  PAppState.ChangeState(stShutDown);
end;

procedure TfrmBase.imgMaximizeClick(Sender: TObject);
begin
  if (Self.Parent = Nil) then
  begin
    if (WindowState = wsNormal) then
      WindowState := TWindowState.wsMaximized
    else
      WindowState := TWindowState.wsNormal;
  end
  else
  begin
    Self.Parent := Nil;
    Self.Align := alNone;
    Self.WindowState := wsMaximized;
  end;
end;

procedure TfrmBase.imgMinimizeClick(Sender: TObject);
begin
  WindowState := TWindowState.wsMinimized;
end;

procedure TfrmBase.imgTrayIconClick(Sender: TObject);
var
  BoolTrayicon: Boolean;
begin
  BoolTrayicon := MessageDlg('Do you really want hide application as trayicon?', mtInformation, [mbYes, mbNo], 0) = mrYes;
  if BoolTrayicon then
    close;

end;

procedure TfrmBase.AbortApp(Sender: TObject);
begin
  lblSubCaption.Caption := App_Name + ' started at ' + DateTimeToStr(now);
  // PostMessage(frmBase.Handle, WM_SIZE, 0, 0);
end;

procedure TfrmBase.pnlActionBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $F012;
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, sc_DragMove, 0);
end;

procedure TfrmBase.setCaption(const Value: String);
begin
  FCaption := Value;
  lblCaption.Caption := FCaption;
  lblCaption.Hint := FCaption;
end;

procedure TfrmBase.setSubCaption(const Value: String);
begin
  FSubCaption := Value;
  lblSubCaption.Caption := FSubCaption;
  lblSubCaption.Hint := FSubCaption;
end;

procedure TfrmBase.setControleForm(const Value: Boolean);
begin
  FControleForm := Value;
  pnlActionBar.Visible := FControleForm;
  pnlPrincipal.AlignWithMargins := FControleForm;
end;

procedure TfrmBase.setFormColor(const Value: TColor);
begin
  FFormColor := Value;
  Self.Color := FFormColor;
  pnlActionBar.Color := FFormColor;
  pnlSubCaption.Color := CorEscura(FFormColor);
  lblCaption.Color := FFormColor;
  lblSubCaption.Color := FFormColor;
  pnlMinimize.Color := FFormColor;
  pnlMaximize.Color := FFormColor;
  pnlMaximize.Color := FFormColor;
end;

procedure TfrmBase.Tray(ActInd: Integer);
var
  nim: TNotifyIconData;
begin

  with nim do
  begin
    cbSize := System.SizeOf(nim);
    Wnd := frmBase.Handle;
    uId := 1;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;

    if IconIndex = 0 then
      hIcon := SendMessage(Application.Handle, WM_GETICON, ICON_SMALL2, 0)
    else
      hIcon := IconFull.Handle;

    uCallBackMessage := WM_USER + 1;
    StrCopy(szTip, PChar(Application.Title));
  end;
  case ActInd of
    1:
      Shell_NotifyIcon(NIM_ADD, @nim);
    2:
      Shell_NotifyIcon(NIM_DELETE, @nim);
    3:
      Shell_NotifyIcon(NIM_MODIFY, @nim);
  end;
end;

procedure TfrmBase.TrayIconBaseDblClick(Sender: TObject);
begin
  TrayIconBase.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmBase.ShowApplicationExecute(Sender: TObject);
begin
  //
  TrayIconBase.Visible := False;
  if not(frmBase.Visible) then
    frmBase.Visible := True;

end;

procedure TfrmBase.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  if Msg.Message = WM_USER + 32 then
  begin
    lblSubCaption.Caption := DateTimeToStr(now);
    Handled := True;
  end;

end;

procedure TfrmBase.BitBtn1Click(Sender: TObject);
begin
//
end;

procedure TfrmBase.BitBtnAccessClick(Sender: TObject);
begin
  BitBtnAccess.Enabled := False;
 ilevel := 1;
  try
    frmAccessUser.showmodal;
  finally
   BitBtnAccess.Enabled := true;
  ilevel := 0;
  end;
end;

procedure TfrmBase.BitBtnLogUserClick(Sender: TObject);
begin
     BitBtnLogUser.Enabled := False;
 ilevel := 1;
  try
    frmLogUser.showmodal;
  finally
   BitBtnLogUser.Enabled := true;
  ilevel := 0;
  end;

end;

procedure TfrmBase.BitBtnNewUserClick(Sender: TObject);
begin

  BitBtnNewUser.Enabled := False;
 ilevel := 1;
  try
    frmNewUser.showmodal;
  finally
   BitBtnNewUser.Enabled := true;
   ilevel := 0;
  end;

end;

procedure TfrmBase.CloseApplicationExecute(Sender: TObject);
begin
  Self.CanClose := True;
  PAppState.ChangeState(stShutDown);

end;

function TfrmBase.CorEscura(ACor: TColor): TColor;
var
  sNewColor: String;
begin
  sNewColor := ('$' + IntToHex(GetBValue(ACor) + 15, 2) + IntToHex(GetGValue(ACor) + 15, 2) + IntToHex(GetRValue(ACor) + 15, 2));

  Result := StringToColor(sNewColor);
end;

{ TStatePrepareUI }

constructor TStatePrepareUI.Create;
begin
  FEnumState := stPrepareUI;
end;

function TStatePrepareUI.EnumState: TPAppStateEnum;
begin
  Result := FEnumState;
end;

procedure TStatePrepareUI.Execute;
begin
  //
end;

{ TStatePrepareDataBase }

constructor TStatePrepareDataBase.Create;
begin
  FEnumState := stVerifyData;
end;

function TStatePrepareDataBase.EnumState: TPAppStateEnum;
begin
  Result := FEnumState;
end;

procedure TStatePrepareDataBase.Execute;
begin
  //
end;

{ TStateShutDown }

constructor TStateShutDown.Create;
begin
  FEnumState := stShutDown;
end;

function TStateShutDown.EnumState: TPAppStateEnum;
begin
  Result := FEnumState;
end;

procedure TStateShutDown.Execute;
begin
  //
end;

{ TStateDispacher }

constructor TStateDispacher.Create;
begin
  Inherited;
  FAppState := nil;
end;

procedure TStateDispacher.Notify(Obj: TObject);
var
  APAppState: TPAppState;
begin

  if Obj is TPAppState then
  begin
    APAppState := TPAppState(Obj);
    if not Assigned(FAppState) then
      FAppState := APAppState;

    case APAppState.EnumState of
      stUnknow:
        begin
          //
        end;

      stPrepareUI:
        begin
          //
          UScript.BuildTable;
        end;

      stVerifyData:
        begin
          //
        end;

      stRunning:
        begin
          //
        end;

      stPrepareMode:
        begin
          //
        end;

      stShutDown:
        begin

          frmBase.close;
          frmBase.Tray(2);

          //
        end;
    end;
  end;

end;

{ TThreadDataQueue }

procedure TThreadDataQueue.Execute;
begin
  inherited;
//  if (ilevel=0) then
//  ShowMessage('Welcome to ' + App_Name);
//  PostMessage(frmBase.Handle, WM_MaximizeWindow, 0, 0);     //if you wanna open MaximizeWindow
  //
end;

end.
