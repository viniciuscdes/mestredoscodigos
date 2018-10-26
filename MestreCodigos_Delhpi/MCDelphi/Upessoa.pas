unit Upessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCalendars,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Uconfig, Vcl.Menus;

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
    D_Pessoa: TDataSource;
    Q_Pessoa: TFDQuery;
    DBComboBox1: TDBComboBox;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure D_PessoaDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  Form_Pessoas: TForm_Pessoas;
  function MailURLMayBeInvalid(const s: string): Boolean;
  function IsValidCPF(numCPF : string) : Boolean;

implementation

{$R *.dfm}

procedure TForm_Pessoas.D_PessoaDataChange(Sender: TObject; Field: TField);
begin
  Q_Pessoa.Edit;
end;

procedure TForm_Pessoas.SpeedButton1Click(Sender: TObject);
begin
  Q_Pessoa.Close;
  Q_Pessoa.Open();
end;

procedure TForm_Pessoas.SpeedButton2Click(Sender: TObject);
begin
  Q_Pessoa.Close;
  Q_Pessoa.Open();
  Q_Pessoa.Append;
end;

procedure TForm_Pessoas.SpeedButton3Click(Sender: TObject);
var
  podeSalvar: Integer;
begin

  podeSalvar := 0;

  if MailURLMayBeInvalid(DBEdit3.Text) then begin

    ShowMessage('O e-mail é inválido.');
    podeSalvar := 1;

  end
  else begin
    podeSalvar := 0;
  end;

  if IsValidCPF(DBEdit2.Text) then begin
    podeSalvar := 1;
  end
  else begin
    ShowMessage('O CPF é inválido.');
    podeSalvar := 0;
  end;

  if (DBEdit5.Text > '1000') and (DBEdit6.Text < '5001') then begin
     podeSalvar := 1;
  end
  else begin
     ShowMessage('A faixa salárial deve estar entre 10001 e 5000 ');
     podeSalvar := 0;
  end;

  if podeSalvar = 1 then
     Q_Pessoa.Post;

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


function IsValidCPF(numCPF : string) : Boolean;
var
   cpf: string;
   x, i, total, dg1, dg2: Integer;
   ret: boolean;
   invalidos: array [0..9] of string;
begin
 ret := True;
  for x := 1 to Length(numCPF) do
     if not (numCPF[x] in ['0'..'9', '-', '.', ' ']) then
        ret := False;
  if ret then
   begin
     ret := True;
     cpf := '';
     for x := 1 to Length(numCPF) do
        if numCPF[x] in ['0'..'9'] then
           cpf := cpf + numCPF[x];
     if Length(cpf) <> 11 then
        ret := False;
     if ret then
      begin
        //1° dígito
        total := 0;
        for x := 1 to 9 do
         total := total + (StrToInt(cpf[x]) * x);
        dg1 := total mod 11;
        if dg1 = 10 then
           dg1 := 0;
        //2° dígito
        total := 0;
        for x := 1 to 8 do
           total := total + (StrToInt(cpf[x + 1]) * (x));
        total := total + (dg1 * 9);
        dg2 := total mod 11;
        if dg2 = 10 then
           dg2 := 0;
        //Validação final
      if (dg1 = StrToInt(cpf[10])) and (dg2 = StrToInt(cpf[11])) then
        ret := True
      else
        ret := False;

        //Inválidos
        for x := 0 to 9 do
          for i := 0 to 10 do
            invalidos[x] := invalidos[x] + IntToStr(x);

        for x := 0 to 9 do
          if cpf = invalidos[x] then
            ret := False;
      end
     else
    begin
        //Se não informado deixa passar
        if cpf = '' then
           ret := True;
    end;
   end;
  result := ret;
end;


end.
