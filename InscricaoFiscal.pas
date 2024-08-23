unit InscricaoFiscal;

interface

type
  TInscricaoFiscal = class abstract(TObject)
  public
    function DocumentoValido(const ADocumento: string): Boolean; virtual; abstract;
  end;

  TCNPJ = class(TInscricaoFiscal)
  public
    function DocumentoValido(const xCNPJ: string): Boolean; override;
  end;

  TCPF = class(TInscricaoFiscal)
  public
    function DocumentoValido(const xCPF: string): Boolean; override;
  end;

implementation

uses
  System.SysUtils;

{ TCNPJ }

function TCNPJ.DocumentoValido(const xCNPJ: string): Boolean;
var
  d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
  Check : String;
  LocalResult : Boolean;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length( xCNPJ )-2 do
  begin
    if Pos( Copy( xCNPJ, nCount, 1 ), '/-.' ) = 0 then
    begin
      if xx < 5 then
      begin
          fator := 6 - xx;
      end
      else
      begin
          fator := 14 - xx;
      end;
      d1 := d1 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
      if xx < 6 then
      begin
          fator := 7 - xx;
      end
      else
      begin
          fator := 15 - xx;
      end;
      d4 := d4 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
      xx := xx+1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(Digito1) + IntToStr(Digito2);
  if Check <> copy(xCNPJ,succ(length(xCNPJ)-2),2) then
  begin
    LocalResult := False;
  end
  else
  begin
    LocalResult := True;
  end;

  if localResult then
   localResult := not ((Length(Trim(xCNPJ)) <> 14) or
                       (Trim(xCNPJ) = '11111111111111') or
                       (Trim(xCNPJ) = '22222222222222') or
                       (Trim(xCNPJ) = '33333333333333') or
                       (Trim(xCNPJ) = '44444444444444') or
                       (Trim(xCNPJ) = '55555555555555') or
                       (Trim(xCNPJ) = '66666666666666') or
                       (Trim(xCNPJ) = '77777777777777') or
                       (Trim(xCNPJ) = '88888888888888') or
                       (Trim(xCNPJ) = '99999999999999') or
                       (Trim(xCNPJ) = '00000000000000'));

  Result := LocalResult;
end;

{ TCPF }

function TCPF.DocumentoValido(const xCPF: string): Boolean;
var
  localCPF       : string;
  localResult    : boolean;
  digit1, digit2 : integer;
  ii,soma        : integer;
begin
  localCPF := '';
  localResult := False;

  {analisa CPF no formato 999.999.999-00}
  if Length(xCPF) = 14 then
  begin
    if (Copy(xCPF,4,1)+Copy(xCPF,8,1)+Copy(xCPF,12,1) = '..-') then
    begin
      localCPF := Copy(xCPF,1,3) + Copy(xCPF,5,3) + Copy(xCPF,9,3) +
                  Copy(xCPF,13,2);
      localResult := True;
    end;
  end;

  {analisa CPF no formato 99999999900}
  if Length(xCPF) = 11 then
  begin
    localCPF := xCPF;
    localResult := True;
  end;

  {comeca a verificacao do digito}
  if localResult then
  try
    {1° digito}
    soma := 0;
    for ii := 1 to 9 do Inc(soma, StrToInt(Copy(localCPF, 10-ii, 1))*(ii+1));
    digit1 := 11 - (soma mod 11);
    if digit1 > 9 then digit1 := 0;

    {2° digito}
    soma := 0;
    for ii := 1 to 10 do Inc(soma, StrToInt(Copy(localCPF, 11-ii, 1))*(ii+1));
    digit2 := 11 - (soma mod 11);
    if digit2 > 9 then digit2 := 0;

    {Checa os dois dígitos}
    if (Digit1 = StrToInt(Copy(localCPF, 10, 1))) and
       (Digit2 = StrToInt(Copy(localCPF, 11, 1))) then
       localResult := True
    else
       localResult := False;
  except
    localResult := False;
  end;

  if localResult then
     localResult := not ((Length(Trim(xCPF)) <> 11) or
                         (Trim(xCPF) = '11111111111') or
                         (Trim(xCPF) = '22222222222') or
                         (Trim(xCPF) = '33333333333') or
                         (Trim(xCPF) = '44444444444') or
                         (Trim(xCPF) = '55555555555') or
                         (Trim(xCPF) = '66666666666') or
                         (Trim(xCPF) = '77777777777') or
                         (Trim(xCPF) = '88888888888') or
                         (Trim(xCPF) = '99999999999') or
                         (Trim(xCPF) = '00000000000'));

  Result := localResult;
end;

end.
