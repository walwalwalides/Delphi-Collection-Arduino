{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit MainModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.SQLite, System.iOUtils,
  System.Generics.Collections, uUser, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, VCL.graphics, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMMainModule = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDScript1: TFDScript;
    qrLogUser: TFDQuery;

  private

    procedure InsertLogUser(AID: string);


    { Private declarations }

  public
    { Public declarations }
    function SqlitConnection(): TFDConnection;
    procedure AddUser(User: TUser);
    procedure DeleteUser(UserUId: string);
    procedure SetUserPresent(AID: Integer; APresent: Boolean);
    function GetLogUserList(): TFDQuery;
    function checkUIDexist(const AID: string): Boolean;
    function GetUserDaten(const AUID :string): TUser;
  end;

var
  DMMainModule: TDMMainModule;

implementation

uses Uscript, LogUser, VCL.Dialogs;

{ %CLASSGROUP 'VCL.Controls.TControl' }

{$R *.dfm}

function TDMMainModule.checkUIDexist(const AID: string): Boolean;
var
  FDQuery1: TFDQuery;
begin
  Result := False;
  TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();
    FDQuery1.SQL.Text := 'Select * from AccessInfo where UID=:UID';
    FDQuery1.ParamByName('UID').AsString := AID;
    FDQuery1.Open;
    Result := (FDQuery1.RecordCount >= 1)
  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;
end;

procedure TDMMainModule.AddUser(User: TUser);
var
  FDQuery1: TFDQuery;
begin
  TRY
    if checkUIDexist(User.Uid) = true then
    begin

      raise Exception.Create('ID alredy exist !');
      exit;
    end;
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();

    FDQuery1.SQL.Text := 'INSERT INTO AccessInfo (FirstName, LastName,UID) VALUES (:FirstName,:LastName,:UID)';

    FDQuery1.ParamByName('FirstName').AsString := User.FirstName;
    FDQuery1.ParamByName('LastName').AsString := User.LastName;
    FDQuery1.ParamByName('UID').AsString := User.Uid;

    FDQuery1.ExecSQL;
  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;
end;

procedure TDMMainModule.SetUserPresent(AID: Integer; APresent: Boolean);
var
  FDQuery1: TFDQuery;
begin
  TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();
    FDQuery1.SQL.Text := 'Update AccessInfo set Present=:Pre where ID=:ID';
    FDQuery1.ParamByName('ID').AsInteger := AID;
    FDQuery1.ParamByName('Pre').AsBoolean := APresent;

    FDQuery1.ExecSQL;
  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;
end;

procedure TDMMainModule.DeleteUser(UserUId: string);
var
  FDQuery1: TFDQuery;
begin
  TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();
    FDQuery1.SQL.Text := Format('DELETE FROM AccessInfo WHERE UId=%d', [UserUId]);
    FDQuery1.ExecSQL;
  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;
end;

function TDMMainModule.SqlitConnection(): TFDConnection;
var
  dbPath: string;
const
  DBFILE = 'DBACCESS.db';
begin
{$IFDEF MSWINDOWS}
  dbPath := TPath.Combine(ExpandFileName(GetCurrentDir), DBFILE);
{$ELSE}
  dbPath := TPath.GetDocumentsPath + PathDelim + DBFILE;
{$ENDIF}
  Result := TFDConnection.Create(Self);
  Result.Params.Add('Database=' + dbPath);
  Result.DriverName := 'SQLite';
  Result.LoginPrompt := False;
  Result.Open();
end;

function ConvertBytetoBitmap(ABlob: TField): Tbitmap;
var
  bmp: Tbitmap;
  BlobStream: TStream;
  FDQuery1: TFDQuery;
begin
  FDQuery1 := TFDQuery.Create(nil);
  bmp := Tbitmap.Create;
  try
    // access a stream from a blob like this
    BlobStream := FDQuery1.CreateBlobStream(ABlob, TBlobStreamMode.bmRead);
    bmp.LoadFromStream(BlobStream);
    Result := bmp;
  finally
    BlobStream.Free;
    FDQuery1.Free;

  end;

end;

function TDMMainModule.GetUserDaten(const AUID :string): TUser;
var
  mUser: TUser;
  FDQuery1: TFDQuery;
begin

  TRY
    Result := nil;

    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();
//    FDQuery1.SQL.Text := Format('SELECT * FROM AccessInfo WHERE UId=%d', [AUID]);
    FDQuery1.SQL.Text := 'SELECT * FROM AccessInfo WHERE UID=:UID';
    FDQuery1.ParamByName('UID').AsString:=AUID;
    FDQuery1.Open;

    if (FDQuery1.RecordCount=1)then
    begin
      Result:= TUser.Create(FDQuery1.FieldByName('LastName').AsString, FDQuery1.FieldByName('FirstName').AsString, FDQuery1.FieldByName('UID').AsString);
      InsertLogUser(AUID);
    end;

  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;

end;


procedure TDMMainModule.InsertLogUser(AID:string);
var
  FDQuery1: TFDQuery;
begin
  TRY
    FDQuery1 := TFDQuery.Create(Self);
    FDQuery1.Connection := SqlitConnection();

    FDQuery1.SQL.Text := 'INSERT INTO AccessLog (UID,Enter) VALUES (:UID,:Ent)';
    FDQuery1.ParamByName('Ent').AsDateTime := Now;
    FDQuery1.ParamByName('UID').AsString := AID;

    FDQuery1.ExecSQL;
  FINALLY
    FDQuery1.Connection.Close;
    FDQuery1.Connection.Free;
    FDQuery1.Close;
    FDQuery1.Free;
  END;
end;


function TDMMainModule.GetLogUserList(): TFDQuery;
begin

  TRY
    qrLogUser.Connection := SqlitConnection();
    qrLogUser.SQL.Text := 'SELECT  AccessLog.UID,Lastname,Firstname,Enter FROM AccessInfo INNER JOIN AccessLog ON AccessLog.UID = AccessInfo.UID';
    try
      qrLogUser.Open;
      qrLogUser.Active := true;

    except

    end;

  FINALLY
    Result := qrLogUser;
  END;

end;

end.
