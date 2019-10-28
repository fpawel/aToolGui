program aToolGui;

uses
  Vcl.Forms,
  UnitAToolMainForm in 'UnitAToolMainForm.pas' {AToolMainForm},
  UnitFormWorkCtrl in 'UnitFormWorkCtrl.pas' {FormWorkCtrl},
  Thrift.Collections in 'thrift\Thrift.Collections.pas',
  Thrift.Exception in 'thrift\Thrift.Exception.pas',
  Thrift in 'thrift\Thrift.pas',
  Thrift.Processor.Multiplex in 'thrift\Thrift.Processor.Multiplex.pas',
  Thrift.Protocol.Compact in 'thrift\Thrift.Protocol.Compact.pas',
  Thrift.Protocol.JSON in 'thrift\Thrift.Protocol.JSON.pas',
  Thrift.Protocol.Multiplex in 'thrift\Thrift.Protocol.Multiplex.pas',
  Thrift.Protocol in 'thrift\Thrift.Protocol.pas',
  Thrift.Serializer in 'thrift\Thrift.Serializer.pas',
  Thrift.Server in 'thrift\Thrift.Server.pas',
  Thrift.Socket in 'thrift\Thrift.Socket.pas',
  Thrift.Stream in 'thrift\Thrift.Stream.pas',
  Thrift.Transport.MsxmlHTTP in 'thrift\Thrift.Transport.MsxmlHTTP.pas',
  Thrift.Transport in 'thrift\Thrift.Transport.pas',
  Thrift.Transport.Pipes in 'thrift\Thrift.Transport.Pipes.pas',
  Thrift.Transport.WinHTTP in 'thrift\Thrift.Transport.WinHTTP.pas',
  Thrift.TypeRegistry in 'thrift\Thrift.TypeRegistry.pas',
  Thrift.Utils in 'thrift\Thrift.Utils.pas',
  Thrift.WinHTTP in 'thrift\Thrift.WinHTTP.pas',
  UnitApiClient in 'UnitApiClient.pas',
  UnitFormLastParty in 'UnitFormLastParty.pas' {FormLastParty},
  stringgridutils in 'utils\stringgridutils.pas',
  stringutils in 'utils\stringutils.pas',
  vclutils in 'utils\vclutils.pas',
  UnitFormPopup in 'UnitFormPopup.pas' {FormPopup},
  myutils in 'utils\myutils.pas',
  api in 'gen-delphi\api.pas',
  apitypes in 'gen-delphi\apitypes.pas',
  logfile in 'logfile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAToolMainForm, AToolMainForm);
  Application.CreateForm(TFormWorkCtrl, FormWorkCtrl);
  Application.CreateForm(TFormWorkCtrl, FormWorkCtrl);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormPopup, FormPopup);
  Application.Run;
end.
