object Form_Pessoas: TForm_Pessoas
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 484
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 271
    Top = 289
    Width = 113
    Height = 25
    Caption = 'Pesquisar'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 320
    Width = 698
    Height = 164
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object MaskEdit1: TMaskEdit
    Left = 2
    Top = 289
    Width = 265
    Height = 21
    TabOrder = 1
    Text = ''
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 698
    Height = 283
    Align = alTop
    TabOrder = 2
    object SpeedButton2: TSpeedButton
      Left = 9
      Top = 10
      Width = 72
      Height = 47
      Caption = 'Novo'
    end
    object SpeedButton3: TSpeedButton
      Left = 165
      Top = 10
      Width = 72
      Height = 47
      Caption = 'Salvar'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 87
      Top = 10
      Width = 72
      Height = 47
      Caption = 'Exlcuir'
    end
    object nome: TLabel
      Left = 44
      Top = 91
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object cpf: TLabel
      Left = 52
      Top = 122
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object opcao: TLabel
      Left = 35
      Top = 185
      Width = 36
      Height = 13
      Caption = 'Op'#231#245'es'
    end
    object email: TLabel
      Left = 43
      Top = 153
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label1: TLabel
      Left = 393
      Top = 213
      Width = 62
      Height = 13
      Caption = 'Data Cria'#231#227'o'
    end
    object Label2: TLabel
      Left = 23
      Top = 213
      Width = 48
      Height = 13
      Caption = 'Sal'#225'rio R$'
    end
    object Label3: TLabel
      Left = 35
      Top = 248
      Width = 420
      Height = 13
    end
    object DBEdit1: TDBEdit
      Left = 80
      Top = 88
      Width = 304
      Height = 21
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 80
      Top = 119
      Width = 304
      Height = 21
      TabOrder = 1
    end
    object DBCheckBox1: TDBCheckBox
      Left = 464
      Top = 90
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 2
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 464
      Top = 113
      Width = 185
      Height = 85
      Caption = 'DBRadioGroup1'
      TabOrder = 3
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 80
      Top = 181
      Width = 304
      Height = 21
      TabOrder = 4
    end
    object DBEdit3: TDBEdit
      Left = 80
      Top = 150
      Width = 304
      Height = 21
      TabOrder = 5
    end
    object CalendarPicker1: TCalendarPicker
      Left = 464
      Top = 208
      Width = 193
      Height = 25
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      TextHint = 'select a date'
    end
    object DBEdit4: TDBEdit
      Left = 80
      Top = 208
      Width = 304
      Height = 21
      TabOrder = 7
    end
    object Edit1: TEdit
      Left = 464
      Top = 48
      Width = 153
      Height = 21
      TabOrder = 8
      Text = 'Edit1'
    end
  end
end
