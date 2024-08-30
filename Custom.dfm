object Form2: TForm2
  Left = 267
  Top = 250
  BorderStyle = bsDialog
  Caption = 'Customize'
  ClientHeight = 146
  ClientWidth = 177
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = OnShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 18
    Width = 36
    Height = 13
    Caption = '  Rows:'
  end
  object Label2: TLabel
    Left = 16
    Top = 42
    Width = 43
    Height = 13
    Caption = 'Columns:'
  end
  object Label3: TLabel
    Left = 16
    Top = 66
    Width = 43
    Height = 13
    Caption = '    Mines:'
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 81
    Height = 21
    TabOrder = 0
    OnKeyPress = OnKeyPress
  end
  object Edit2: TEdit
    Left = 72
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 1
    OnKeyPress = OnKeyPress
  end
  object Edit3: TEdit
    Left = 72
    Top = 64
    Width = 81
    Height = 21
    TabOrder = 2
    OnKeyPress = OnKeyPress
  end
  object Button1: TButton
    Left = 16
    Top = 96
    Width = 137
    Height = 33
    Caption = 'Customize'
    TabOrder = 3
    OnClick = Button1Click
  end
end
