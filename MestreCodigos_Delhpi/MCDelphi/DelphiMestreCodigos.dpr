program DelphiMestreCodigos;

uses
  Vcl.Forms,
  Uprincipal in 'Uprincipal.pas' {Form1},
  Upessoa in 'Upessoa.pas' {Form_Pessoas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_Pessoas, Form_Pessoas);
  Application.Run;
end.
