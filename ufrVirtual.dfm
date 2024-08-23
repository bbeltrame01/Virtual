object shpStatus: TshpStatus
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Validar CPF/CNPJ'
  ClientHeight = 102
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object labInscricao: TLabel
    Left = 16
    Top = 24
    Width = 53
    Height = 15
    Caption = 'CPF/CNPJ'
  end
  object labResultado: TLabel
    Left = 16
    Top = 80
    Width = 3
    Height = 15
  end
  object shpStatus: TShape
    Left = 14
    Top = 43
    Width = 165
    Height = 26
    Pen.Width = 2
  end
  object edtInscricao: TEdit
    Left = 16
    Top = 45
    Width = 161
    Height = 23
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 0
  end
  object btnValidar: TButton
    Left = 192
    Top = 44
    Width = 89
    Height = 25
    Caption = 'Validar'
    TabOrder = 1
    OnClick = btnValidarClick
  end
end
