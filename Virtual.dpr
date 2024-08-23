program Virtual;

uses
  Vcl.Forms,
  ufrVirtual in 'ufrVirtual.pas' {shpStatus},
  InscricaoFiscal in 'InscricaoFiscal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TshpStatus, shpStatus);
  Application.Run;
end.
