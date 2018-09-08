unit HlpBlake2BConfig;

{$I ..\..\Include\HashLib.inc}

interface

uses
  HlpIBlake2BConfig,
  HlpHashSize,
  HlpHashLibTypes;

resourcestring
  SInvalidHashSize =
    'BLAKE2B HashSize must be restricted to one of the following [20, 32, 48, 64], "%d"';

type

  TBlake2BConfig = class sealed(TInterfacedObject, IBlake2BConfig)

  strict private

  var

    FHashSize: Int32;
    FPersonalisation, FSalt, FKey: THashLibByteArray;

    procedure ValidateHashSize(AHashSize: Int32); inline;

    function GetPersonalisation: THashLibByteArray; inline;
    procedure SetPersonalisation(const value: THashLibByteArray); inline;

    function GetSalt: THashLibByteArray; inline;
    procedure SetSalt(const value: THashLibByteArray); inline;

    function GetKey: THashLibByteArray; inline;
    procedure SetKey(const value: THashLibByteArray); inline;

    function GetHashSize: Int32; inline;
    procedure SetHashSize(value: Int32); inline;

  public
    constructor Create(AHashSize: THashSize = THashSize.hsHashSize512);
    property Personalisation: THashLibByteArray read GetPersonalisation
      write SetPersonalisation;
    property Salt: THashLibByteArray read GetSalt write SetSalt;
    property Key: THashLibByteArray read GetKey write SetKey;
    property HashSize: Int32 read GetHashSize write SetHashSize;

  end;

implementation

{ TBlake2BConfig }

procedure TBlake2BConfig.ValidateHashSize(AHashSize: Int32);
begin
  if not((AHashSize) in [20, 32, 48, 64]) then
  begin
    raise EArgumentHashLibException.CreateResFmt(@SInvalidHashSize,
      [Int32(AHashSize)]);
  end;
end;

function TBlake2BConfig.GetHashSize: Int32;
begin
  result := FHashSize;
end;

function TBlake2BConfig.GetKey: THashLibByteArray;
begin
  result := FKey;
end;

function TBlake2BConfig.GetPersonalisation: THashLibByteArray;
begin
  result := FPersonalisation;
end;

function TBlake2BConfig.GetSalt: THashLibByteArray;
begin
  result := FSalt;
end;

procedure TBlake2BConfig.SetHashSize(value: Int32);
begin
  ValidateHashSize(value);
  FHashSize := value;
end;

procedure TBlake2BConfig.SetKey(const value: THashLibByteArray);
begin
  FKey := value;
end;

procedure TBlake2BConfig.SetPersonalisation(const value: THashLibByteArray);
begin
  FPersonalisation := value;
end;

procedure TBlake2BConfig.SetSalt(const value: THashLibByteArray);
begin
  FSalt := value;
end;

constructor TBlake2BConfig.Create(AHashSize: THashSize);
var
  LHashSize: Int32;
begin
  Inherited Create();
  LHashSize := Int32(AHashSize);
  ValidateHashSize(LHashSize);
  FHashSize := LHashSize;
end;

end.
