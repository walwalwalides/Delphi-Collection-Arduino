{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit LogUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.AppEvnts, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Vcl.Menus, Vcl.ExtCtrls, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TfrmLogUser = class(TfrmBase)
    DBGridLog: TDBGrid;
    DSLog: TDataSource;
    GrBoxMenu: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtnClose: TBitBtn;
    BitBtn6: TBitBtn;
    bvlbottom: TBevel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmLogUser: TfrmLogUser;

implementation

uses
  MainModule;

{$R *.dfm}

procedure TfrmLogUser.BitBtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmLogUser.FormCreate(Sender: TObject);
begin
  inherited;
  ControleForm := False;

end;

procedure TfrmLogUser.FormShow(Sender: TObject);
begin
  inherited;
    self.Top:=frmBase.top+40;
  self.left:=frmBase.left+5;


  DSLog.DataSet := DMMainModule.GetLogUserList;
end;

end.
