object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 403
  Width = 509
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=mc_delphi'
      'User_Name=root'
      'Password=senha'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 78
    Top = 40
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 78
    Top = 103
  end
end
