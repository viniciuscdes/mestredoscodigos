object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form_Principal'
  ClientHeight = 452
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 192
    Top = 208
    object Menu1: TMenuItem
      Caption = 'Cadastros'
      object Pessoas1: TMenuItem
        Caption = 'Pessoas'
        OnClick = Pessoas1Click
      end
    end
  end
end
