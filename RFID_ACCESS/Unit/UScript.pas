{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit UScript;

interface

uses FireDAC.Comp.Script;

procedure CreateTableAccessInfo;
procedure BuildTable;
procedure CreateTableAccessLog;

implementation

uses
  MainModule;



procedure CreateData_Table;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := DMMainModule.SqlitConnection();
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'Data_Table';
      SQL.Add('DROP TABLE IF EXISTS Data_Table ;');
      SQL.Add('create table Data_Table(');
      SQL.Add('Id INT NOT NULL AUTO_INCREMENT,');
      SQL.Add('VTYPE INT,');
      SQL.Add('KIND_ID INT,');
      SQL.Add('PRIMARY KEY ( Id )');
      SQL.Add(');');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    tmpScript.free;

  end;

end;

procedure CreateTableAccessLog;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := DMMainModule.SqlitConnection();
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'Accesslog';
      SQL.Add('CREATE TABLE IF NOT EXISTS Accesslog(');
      SQL.Add('Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,');
      SQL.Add('UID VARCHAR(10) NOT NULL,');
      SQL.Add('Enter DATETIME');
      SQL.Add(');');
      end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    tmpScript.free;

  end;

end;


procedure CreateTableAccessInfo;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := DMMainModule.SqlitConnection();
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'Access';
      SQL.Add('CREATE TABLE IF NOT EXISTS AccessInfo(');
      SQL.Add('Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,');
      SQL.Add('FirstName VARCHAR(255) NOT NULL,');
      SQL.Add('LastName VARCHAR(255) NOT NULL,');
      SQL.Add('UID VARCHAR(10) NOT NULL');
      SQL.Add(');');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    tmpScript.free;

  end;

end;

procedure InsertTableAccess;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := DMMainModule.SqlitConnection();
  with tmpScript.SQLScripts do
  begin
    Clear;
    with Add do
    begin
      SQL.Add('INSERT INTO Access (Id,LastName,FirstName,Age,Present,ProfileImage)');
      SQL.Add('VALUES');
      SQL.Add('(1,"ALex","Alex",30,true,'');');
    end;
  end;
  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    tmpScript.free;

  end;

end;




procedure BuildTable;
begin
  CreateTableAccessInfo;
  CreateTableAccessLog;
//  InsertTable;
//  CreateData_Table;
end;

end.
