unit ufrVirtual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, InscricaoFiscal;

type
  TshpStatus = class(TForm)
    labInscricao: TLabel;
    edtInscricao: TEdit;
    btnValidar: TButton;
    labResultado: TLabel;
    shpStatus: TShape;
    procedure btnValidarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  shpStatus: TshpStatus;

implementation

{$R *.dfm}

procedure TshpStatus.btnValidarClick(Sender: TObject);
var
  LInscricao: String;
  LInscricaoFiscal: TInscricaoFiscal;
begin
  LInscricao := Trim(edtInscricao.Text);
  if (LInscricao <> '') and (Length(LInscricao) in [11,14]) then
    begin
      case Length(LInscricao) of
        11: LInscricaoFiscal := TCPF.Create;
        14: LInscricaoFiscal := TCNPJ.Create;
      end;

      try
        if not LInscricaoFiscal.DocumentoValido(LInscricao) then
          begin
            labResultado.Caption := 'Documento Inválido!';
            shpStatus.Pen.Color  := clRed;
          end
        else
          begin
            labResultado.Caption := 'Documento Válido!';
            shpStatus.Pen.Color  := clGreen;
          end;
      finally
        LInscricaoFiscal.Destroy;
      end;
    end
  else
    begin
      labResultado.Caption := '';
      shpStatus.Pen.Color  := clBlack;
    end;
end;

end.
