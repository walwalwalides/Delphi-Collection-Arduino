object Form11: TForm11
  Left = 0
  Top = 0
  Caption = 'RGB_LED_MIXER'
  ClientHeight = 205
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 35
    Width = 137
    Height = 153
    Caption = 'Panel1'
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object ComLedmixer1: TComLedmixer
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 120
      Height = 140
      CodeColor = '0,0,0'#13#10
      MixGreen = 0
      MixRed = 0
      MixBlue = 0
      Boucle = BNone
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 4
    Width = 137
    Height = 25
    Caption = 'RGB LED MIXER'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
