object DmSvnPassWD: TDmSvnPassWD
  OldCreateOrder = False
  Height = 150
  Width = 215
  object CldUser: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = 'SVNUser.cds'
    Params = <>
    Left = 56
    Top = 24
    Data = {
      520000009619E0BD010000001800000002000000000003000000520008557365
      726E616D65010049000000010005574944544802000200140006706173737764
      01004900000001000557494454480200020014000000}
    object CldUserUsername: TStringField
      FieldName = 'Username'
    end
    object CldUserpasswd: TStringField
      FieldName = 'passwd'
    end
  end
end
