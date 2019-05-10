inherited frmNewUser: TfrmNewUser
  Caption = 'frmNewUser'
  ClientHeight = 421
  ClientWidth = 520
  Position = poDesigned
  ExplicitWidth = 526
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    Width = 510
    Height = 346
    ExplicitTop = 67
    inherited GrBoxPrincipal: TGroupBox
      Visible = False
    end
    object GrBoxInsertUser: TGroupBox
      Left = 0
      Top = 0
      Width = 510
      Height = 346
      Align = alClient
      Caption = 'New User'
      TabOrder = 1
      ExplicitTop = 3
      ExplicitWidth = 519
      ExplicitHeight = 396
      object lblLastname: TLabel
        Left = 155
        Top = 32
        Width = 56
        Height = 13
        Caption = 'Lastname'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblFirstname: TLabel
        Left = 155
        Top = 61
        Width = 57
        Height = 13
        Caption = 'Firstname'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblUID: TLabel
        Left = 155
        Top = 88
        Width = 42
        Height = 13
        Caption = 'User ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvlbottom: TBevel
        AlignWithMargins = True
        Left = 6
        Top = 121
        Width = 498
        Height = 3
      end
      object edtLastname: TEdit
        Left = 223
        Top = 29
        Width = 140
        Height = 21
        TabOrder = 0
        Text = 'edtLastname'
        OnChange = ConditionInsertUser
      end
      object bitbtnInsert: TBitBtn
        Left = 209
        Top = 133
        Width = 100
        Height = 25
        Caption = 'Insert'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF000000007E4C
          69B7AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FF000000000000000000000000000000000000000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000B8824DFFEAD9
          C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000251A0F33B882
          4DFFEAD9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FF000000000000000000000000B8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000251A0F33B882
          4DFFEAD9C9FFFFFFFFFF848484FF848484FF848484FF848484FF00000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF00000000B8824DFF3827
          174D00000000000000000000000000000000000000000000000000000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF00000000000000000000
          00007A4A67B2AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000000000000000000000000000000000000000
          00000000000000000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000824F
          6DBDAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FFAF6A93FF824F6DBD00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentDoubleBuffered = True
        TabOrder = 1
        OnClick = bitbtnInsertClick
      end
      object edtFirstName: TEdit
        Left = 223
        Top = 58
        Width = 140
        Height = 21
        TabOrder = 2
        Text = 'edtFirstName'
        OnChange = ConditionInsertUser
      end
      object mskEdtUID: TMaskEdit
        Left = 223
        Top = 85
        Width = 140
        Height = 18
        EditMask = '>cc-cc-cc-cc;1;_'
        MaxLength = 11
        TabOrder = 3
        Text = '  -  -  -  '
        OnChange = ConditionInsertUser
        OnKeyPress = mskEdtUIDKeyPress
      end
      object GrBoxMenu: TGroupBox
        Left = 264
        Top = 236
        Width = 240
        Height = 100
        Caption = '&Menu'
        TabOrder = 4
        object BitBtn3: TBitBtn
          Left = 18
          Top = 22
          Width = 100
          Height = 25
          Cursor = crHandPoint
          Caption = '---------'
          Constraints.MaxHeight = 25
          Constraints.MaxWidth = 100
          Constraints.MinHeight = 25
          Constraints.MinWidth = 100
          ParentDoubleBuffered = True
          TabOrder = 0
        end
        object BitBtn4: TBitBtn
          Left = 124
          Top = 22
          Width = 100
          Height = 25
          Cursor = crHandPoint
          Caption = '---------'
          Constraints.MaxHeight = 25
          Constraints.MaxWidth = 100
          Constraints.MinHeight = 25
          Constraints.MinWidth = 100
          ParentDoubleBuffered = True
          TabOrder = 1
        end
        object BitBtnClose: TBitBtn
          Left = 124
          Top = 53
          Width = 100
          Height = 25
          Cursor = crHandPoint
          Caption = 'Close'
          Constraints.MaxHeight = 25
          Constraints.MaxWidth = 100
          Constraints.MinHeight = 25
          Constraints.MinWidth = 100
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            200000000000000400000000000000000000000000000000000000000000131C
            3C471E2B5F700000000000000000000000000000000000000000000000000000
            00000000000000000000000000001F2D6375131C3C4700000000131C3C474260
            D0F64463D8FF1F2D617300000000000000000000000000000000000000000000
            00000000000000000000202E65774463D8FF4260D1F7131C3C472130687B4463
            D8FF4463D8FF4463D8FF1F2D6173000000000000000000000000000000000000
            000000000000202E65774463D8FF4463D8FF4463D8FF212F677A000000002231
            6C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000000000000000
            0000202E65774463D8FF4463D8FF4463D8FF22316B7E00000000000000000000
            000022316C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000202E
            65774463D8FF4463D8FF4463D8FF22316B7E0000000000000000000000000000
            00000000000022316C7F4463D8FF4463D8FF4463D8FF1F2D6173202E65774463
            D8FF4463D8FF4463D8FF22316B7E000000000000000000000000000000000000
            0000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463D8FF4463
            D8FF4463D8FF22316B7E00000000000000000000000000000000000000000000
            000000000000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463
            D8FF22316B7E0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000202E65774463D8FF4463D8FF4463D8FF4463
            D8FF1F2D62740000000000000000000000000000000000000000000000000000
            00000000000000000000202E65774463D8FF4463D8FF4463D8FF4463D8FF4463
            D8FF4463D8FF1F2D627400000000000000000000000000000000000000000000
            000000000000202E65774463D8FF4463D8FF4463D8FF22316B7E22316C7F4463
            D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000000000000000
            0000202E65774463D8FF4463D8FF4463D8FF21316A7D00000000000000002231
            6C7F4463D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000202E
            65774463D8FF4463D8FF4463D8FF21316A7D0000000000000000000000000000
            000022316C7F4463D8FF4463D8FF4463D8FF1F2D6274000000001F2D63754463
            D8FF4463D8FF4463D8FF21316A7D000000000000000000000000000000000000
            00000000000022316C7F4463D8FF4463D8FF4463D8FF1E2C6172151E414D4261
            D3F94463D8FF21316A7D00000000000000000000000000000000000000000000
            0000000000000000000022316C7F4463D8FF4261D3F9151E424E00000000151E
            414D212F677A0000000000000000000000000000000000000000000000000000
            00000000000000000000000000002130687B151E414D00000000}
          ParentDoubleBuffered = True
          TabOrder = 2
          OnClick = BitBtnCloseClick
        end
        object BitBtn6: TBitBtn
          Left = 18
          Top = 53
          Width = 100
          Height = 25
          Cursor = crHandPoint
          Caption = '---------'
          Constraints.MaxHeight = 25
          Constraints.MaxWidth = 100
          Constraints.MinHeight = 25
          Constraints.MinWidth = 100
          ParentDoubleBuffered = True
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlTop: TPanel
    Width = 510
    ExplicitWidth = 519
    inherited pnlActionBar: TPanel
      Width = 504
      ExplicitWidth = 513
      inherited pnlClose: TPanel
        Left = 473
        ExplicitLeft = 482
      end
      inherited pnlMinimize: TPanel
        Left = 411
        ExplicitLeft = 420
      end
      inherited pnlMaximize: TPanel
        Left = 442
        ExplicitLeft = 451
      end
      inherited pnlTrayIcon: TPanel
        Left = 380
        ExplicitLeft = 389
      end
    end
    inherited pnlSubCaption: TPanel
      Width = 510
      ExplicitWidth = 519
      inherited lblSubCaption: TLabel
        Width = 497
      end
    end
  end
end
