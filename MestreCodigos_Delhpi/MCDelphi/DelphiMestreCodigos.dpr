program DelphiMestreCodigos;

uses
  Vcl.Forms,
  Uprincipal in 'Uprincipal.pas' {Form1},
  Upessoa in 'Upessoa.pas' {Form_Pessoas},
  Uconfig in 'Uconfig.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_Pessoas, Form_Pessoas);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
