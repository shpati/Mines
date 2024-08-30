object Form1: TForm1
  Left = 1547
  Top = 485
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mines'
  ClientHeight = 270
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = OnKeyDown
  OnKeyUp = OnKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 246
    Width = 270
    Height = 24
    Panels = <
      item
        Width = 50
      end
      item
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    object Game1: TMenuItem
      Caption = '&Game'
      object New1: TMenuItem
        Caption = '&New'
        ShortCut = 113
        OnClick = New
      end
      object Intermediate1: TMenuItem
        Caption = '-'
      end
      object Beginner: TMenuItem
        Caption = '&Beginner'
        OnClick = BeginnerClick
      end
      object Intermediate: TMenuItem
        Caption = '&Intermediate'
        OnClick = IntermediateClick
      end
      object Advanced: TMenuItem
        Caption = '&Advanced'
        OnClick = AdvancedClick
      end
      object N1: TMenuItem
        Caption = '&Customize...'
        OnClick = N1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit2: TMenuItem
        Caption = 'Exit'
        ShortCut = 32883
        OnClick = Exit2Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Increasesize1: TMenuItem
        Caption = 'Increase size'
        ShortCut = 16422
        OnClick = Increasesize1Click
      end
      object Decreasesize1: TMenuItem
        Caption = 'Decrease size'
        ShortCut = 16424
        OnClick = Decreasesize1Click
      end
    end
    object About2: TMenuItem
      Caption = '&About'
      OnClick = About2Click
    end
  end
end
