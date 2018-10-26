unit Uprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Upessoa, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, Data.DBXMySQL, Data.SqlExpr, Uconfig;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Pessoas1: TMenuItem;
    procedure Pessoas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Pessoas1Click(Sender: TObject);
begin
  Form_Pessoas := TForm_Pessoas.Create(nil);
  Form_Pessoas.ShowModal;
  Form_Pessoas.Close;
end;

end.
