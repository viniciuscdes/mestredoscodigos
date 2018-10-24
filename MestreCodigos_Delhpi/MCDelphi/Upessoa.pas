unit Upessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCalendars;

type
  TForm_Pessoas = class(TForm)
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    MaskEdit1: TMaskEdit;
    Panel1: TPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    DBLookupComboBox1: TDBLookupComboBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    nome: TLabel;
    cpf: TLabel;
    opcao: TLabel;
    email: TLabel;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    CalendarPicker1: TCalendarPicker;
    Label2: TLabel;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    Edit1: TEdit;
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  Form_Pessoas: TForm_Pessoas;
  function MailURLMayBeInvalid(const s: string): Boolean;
  function IsValidCPF(pCPF : string) : Boolean;

implementation

{$R *.dfm}

procedure TForm_Pessoas.SpeedButton3Click(Sender: TObject);
begin

  if MailURLMayBeInvalid(Edit1.Text) then
  begin

    Label3.Caption :='Caracter inválido informado no E-mail!!';

  end;

  if IsValidCPF(Edit1.Text) then
  begin

    ShowMessage('O CPF é válido.');

  end;

end;

function MailURLMayBeInvalid(const s: string): Boolean;
var
  i: Integer;
  c: string;
begin // ' ', ä, ö, ü, ß, [, ], (, ), : in EMail-Address
  Result := (Trim(s) = '') or (Pos(' ', AnsiLowerCase(s)) > 0) or
    (Pos('ä', AnsiLowerCase(s)) > 0) or (Pos('ö', AnsiLowerCase(s)) > 0) or
    (Pos('ü', AnsiLowerCase(s)) > 0) or (Pos('ß', AnsiLowerCase(s)) > 0) or
    (Pos('[', AnsiLowerCase(s)) > 0) or (Pos(']', AnsiLowerCase(s)) > 0) or
    (Pos('(', AnsiLowerCase(s)) > 0) or (Pos(')', AnsiLowerCase(s)) > 0) or
    (Pos(':', AnsiLowerCase(s)) > 0);
  if Result then Exit; // @ not in EMail-Address;
  i      := Pos('@', s);
  Result := (i = 0) or (i = 1) or (i = Length(s));
  if Result then Exit;
  Result := (Pos('@', Copy(s, i + 1, Length(s) - 1)) > 0);
  if Result then Exit; // Domain <= 1
  c      := Copy(s, i + 1, Length(s));
  Result := Length(c) <= 1;
  if Result then Exit;
  i      := Pos('.', c);
  Result := (i = 0) or (i = 1) or (i = Length(c));
end;


function IsValidCPF(pCPF : string) : Boolean;
var
  v: array[0..1] of Word;
  cpf: array[0..10] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 11 do
      cpf[i-1] := StrToInt(pCPF[i]);
    //Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10*cpf[0] + 9*cpf[1] + 8*cpf[2];
    v[0] := v[0] + 7*cpf[3] + 6*cpf[4] + 5*cpf[5];
    v[0] := v[0] + 4*cpf[6] + 3*cpf[7] + 2*cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] &gt;= 10, 0, v[0]);
    //Nota: Calcula o segundo dígito de verificação.
    v[1] := 11*cpf[0] + 10*cpf[1] + 9*cpf[2];
    v[1] := v[1] + 8*cpf[3] +  7*cpf[4] + 6*cpf[5];
    v[1] := v[1] + 5*cpf[6] +  4*cpf[7] + 3*cpf[8];
    v[1] := v[1] + 2*v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] &gt;= 10, 0, v[1]);
    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result :=  ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except on E: Exception do
    Result := False;
  end;
end;


end.
