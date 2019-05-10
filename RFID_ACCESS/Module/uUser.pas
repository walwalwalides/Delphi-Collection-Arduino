{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uUser;

interface

uses
  System.SysUtils, System.Generics.Collections, VCL.Graphics,
  System.iOUtils, System.UITypes, VCL.Dialogs;

type
{$METHODINFO ON}
  TUser = class
  private

    _Id: integer;
    _FirstName: string;
    _LastName: string;
    _UID: string;

    procedure SetFirstName(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetLastName(const Value: string);
    procedure SetUID(const Value: string);


    { Private declarations }
  public
    { Public declarations }

    // Constructor Create; overload;
    Constructor Create(Const lastName: string;Const firstName: string;Const UID: string);
    Property id: integer read _Id write SetId;
    Property firstName: string read _FirstName write SetFirstName;
    Property lastName: string read _LastName write SetLastName;
    property UID: string read _UID write SetUID ;

  end;
{$METHODINFO OFF}

implementation


Constructor TUser.Create(Const lastName: string;Const firstName: string;Const UID: string);
begin
  Self._FirstName := firstName;
  Self._LastName := lastName;
  Self._UID := UID
end;


procedure TUser.SetFirstName(const Value: string);
begin
  _FirstName := Value;
end;

procedure TUser.SetId(const Value: integer);
begin
  _Id := Value;
end;

procedure TUser.SetLastName(const Value: string);
begin
  _LastName := Value;
end;



procedure TUser.SetUID(const Value: string);
begin
_UID := Value;
end;

end.
