{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit NewUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.AppEvnts, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ExtCtrls, acPNG,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TfrmNewUser = class(TfrmBase)
    edtLastname: TEdit;
    edtFirstName: TEdit;
    bitbtnInsert: TBitBtn;
    GrBoxInsertUser: TGroupBox;
    mskEdtUID: TMaskEdit;
    lblLastname: TLabel;
    lblFirstname: TLabel;
    lblUID: TLabel;
    GrBoxMenu: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtnClose: TBitBtn;
    BitBtn6: TBitBtn;
    bvlbottom: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure mskEdtUIDKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bitbtnInsertClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConditionInsertUser(Sender: TObject);
  private

    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmNewUser: TfrmNewUser;

implementation

uses
  MainModule, uUser;

{$R *.dfm}

procedure TfrmNewUser.BitBtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmNewUser.bitbtnInsertClick(Sender: TObject);
var
  User: TUser;
  ErrBool: Boolean;
begin
  ErrBool := False;
  inherited;
  try
    User := TUser.Create(edtLastname.text, edtFirstName.text, mskEdtUID.text);
    try
      DMMainModule.AddUser(User);
    except
      on e: exception do
      begin
        ErrBool := True;
        ShowMessage('ID already exist !');
        Exit;
      end;

    end;

  finally
    if not(ErrBool) then

      MessageDlg('Registration Successful. ', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
  end;

end;

procedure TfrmNewUser.ConditionInsertUser(Sender: TObject);
begin
  bitbtnInsert.Enabled := (edtLastname.text <> '') and (edtFirstName.text <> '') and (mskEdtUID.text <> '');
end;

procedure TfrmNewUser.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfrmNewUser.FormCreate(Sender: TObject);
begin
  inherited;
  ControleForm := False;

end;

procedure TfrmNewUser.FormShow(Sender: TObject);
begin
  inherited;
  edtLastname.Clear;
  mskEdtUID.Clear;
  edtFirstName.Clear;
  bitbtnInsert.Enabled := False;
  self.Top := frmBase.Top + 40;
  self.left := frmBase.left + 5;

end;

procedure TfrmNewUser.mskEdtUIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', 'a' .. 'f', 'A' .. 'F', #8]) then
    Key := #0;
end;

end.
