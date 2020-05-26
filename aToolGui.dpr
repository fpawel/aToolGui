program aToolGui;

uses
  Vcl.Forms,
  UnitAToolMainForm in 'UnitAToolMainForm.pas' {AToolMainForm},
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
  UnitFormCurrentParty in 'UnitFormCurrentParty.pas' {FormCurrentParty},
  stringgridutils in 'utils\stringgridutils.pas',
  stringutils in 'utils\stringutils.pas',
  vclutils in 'utils\vclutils.pas',
  UnitFormPopup2 in 'UnitFormPopup2.pas' {FormPopup2},
  myutils in 'utils\myutils.pas',
  api in 'gen-delphi\api.pas',
  apitypes in 'gen-delphi\apitypes.pas',
  logfile in 'logfile.pas',
  UnitFormVar in 'UnitFormVar.pas' {FormVar},
  UnitFormSelectCurrentParty in 'UnitFormSelectCurrentParty.pas' {FormSelectCurrentParty},
  UnitFormChart in 'UnitFormChart.pas' {FormChart},
  UnitFormJournal in 'UnitFormJournal.pas' {FormJournal},
  Grijjy.Bson.IO in 'grijjy\Grijjy.Bson.IO.pas',
  Grijjy.Bson in 'grijjy\Grijjy.Bson.pas',
  Grijjy.Bson.Serialization in 'grijjy\Grijjy.Bson.Serialization.pas',
  Grijjy.Collections in 'grijjy\Grijjy.Collections.pas',
  Grijjy.SysUtils in 'grijjy\Grijjy.SysUtils.pas',
  Grijjy.DateUtils in 'grijjy\Grijjy.DateUtils.pas',
  Grijjy.BinaryCoding in 'grijjy\Grijjy.BinaryCoding.pas',
  UnitMeasurement in 'UnitMeasurement.pas',
  UnitFormPopup in 'UnitFormPopup.pas' {FormPopup},
  UnitAppIni in 'UnitAppIni.pas',
  UnitFormRawModbus in 'UnitFormRawModbus.pas' {FormRawModbus},
  UnitFormTemperatureHardware in 'UnitFormTemperatureHardware.pas' {FormTemperatureHardware},
  UnitFormGas in 'UnitFormGas.pas' {FormGas},
  UnitFormCoefficients in 'UnitFormCoefficients.pas' {FormCoefficients},
  UnitFormInterrogate in 'UnitFormInterrogate.pas' {FormInterrogate},
  UnitFormProgress in 'UnitFormProgress.pas' {FormProgress},
  UnitFormAppConfig in 'UnitFormAppConfig.pas' {FormAppConfig},
  UnitFormExpander in 'UnitFormExpander.pas' {FormExpander},
  UnitFormProductsData in 'UnitFormProductsData.pas' {FormProductsData},
  UnitFormProductsCalcTable in 'UnitFormProductsCalcTable.pas' {FormProductsCalcTable},
  teechartutils in 'utils\teechartutils.pas',
  luahelp in 'luahelp.pas',
  UnitFormSelectWorksDialog in 'UnitFormSelectWorksDialog.pas' {FormSelectWorksDialog},
  UnitFormNewPartyDialog in 'UnitFormNewPartyDialog.pas' {FormNewPartyDialog},
  UnitFormParties in 'UnitFormParties.pas' {FormParties},
  UnitFormProductsDataTable in 'UnitFormProductsDataTable.pas' {FormProductsDataTable},
  UnitFormStringGridCopyClipboard in 'UnitFormStringGridCopyClipboard.pas' {FormStringGridCopyClipboard},
  UnitFormSearchProductsNetDialog in 'UnitFormSearchProductsNetDialog.pas' {FormSearchProductsNetDialog},
  UnitFormDelay in 'UnitFormDelay.pas' {FormDelay};

{$R *.res}

begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TAToolMainForm, AToolMainForm);
  Application.CreateForm(TFormCurrentParty, FormCurrentParty);
  Application.CreateForm(TFormPopup2, FormPopup2);
  Application.CreateForm(TFormVar, FormVar);
  Application.CreateForm(TFormSelectCurrentParty, FormSelectCurrentParty);
  Application.CreateForm(TFormJournal, FormJournal);
  Application.CreateForm(TFormPopup, FormPopup);
  Application.CreateForm(TFormRawModbus, FormRawModbus);
  Application.CreateForm(TFormTemperatureHardware, FormTemperatureHardware);
  Application.CreateForm(TFormGas, FormGas);
  Application.CreateForm(TFormCoefficients, FormCoefficients);
  Application.CreateForm(TFormInterrogate, FormInterrogate);
  Application.CreateForm(TFormProgress, FormProgress);
  Application.CreateForm(TFormSelectWorksDialog, FormSelectWorksDialog);
  Application.CreateForm(TFormParties, FormParties);
  Application.CreateForm(TFormStringGridCopyClipboard, FormStringGridCopyClipboard);
  Application.CreateForm(TFormDelay, FormDelay);
  Application.Run;

end.
