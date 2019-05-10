{ ============================================
  Software Name : 	RFID_ACCESS
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit UStates;


interface

uses
  System.Classes, System.SysUtils;

type
  IStateDispacher = interface
    procedure Notify(Obj : TObject);
  end;

  TPAppStateEnum = (
    stUnknow,
    stPrepareUI,
    stVerifyData,
    stRunning,
    stPrepareMode,
    stShutDown
  );

  IPAppState = interface
    procedure Execute;
    function EnumState : TPAppStateEnum;
  end;

  TPAppState = class
  private
    FState : IPAppState;
    FStateDispacher : IStateDispacher;
    FOnChangeState : TNotifyEvent;
    procedure SetState(State : IPAppState);
    function GetState: TPAppStateEnum;
  public
    constructor Create(StateDisp : IStateDispacher);
    destructor Destroy; override;
    procedure ChangeState(const State : TPAppStateEnum);
    procedure Execute;
    property EnumState : TPAppStateEnum read GetState;
    property OnChangeState : TNotifyEvent read FOnChangeState write FOnChangeState;
  end;

implementation

uses
  Base;

{ TPAppState }

procedure TPAppState.ChangeState(const State: TPAppStateEnum);
begin
  case State of
    TPAppStateEnum.stPrepareUI :
      begin
        Self.SetState(TStatePrepareUI.Create);
        Self.Execute;
      end;

    TPAppStateEnum.stVerifyData :
      begin
        if FState is TStatePrepareUI then
        begin
          Self.SetState(TStatePrepareDataBase.Create);
          Self.Execute;
        end;

      end;
    TPAppStateEnum.stShutDown :
      begin
        if not (FState is TStateShutDown) then
        begin
          Self.SetState(TStateShutDown.Create);
          Self.Execute;
        end;
      end;
  end;

  if Assigned (FOnChangeState) then FOnChangeState(Self);
  FStateDispacher.Notify(Self);

end;

constructor TPAppState.Create(StateDisp : IStateDispacher);
begin
  FStateDispacher := StateDisp;
end;

destructor TPAppState.Destroy;
begin
  FState := nil;
  inherited;
end;

procedure TPAppState.Execute;
begin
  FState.Execute;
end;

function TPAppState.GetState: TPAppStateEnum;
begin
  Result := FState.EnumState;
end;

procedure TPAppState.SetState(State: IPAppState);
begin
  FState := State;
end;



end.
