program OnlineRadio;

uses
  System.StartUpCopy,
  FMX.Forms,
  OnlineRadio.Main in 'OnlineRadio.Main.pas' {FormMain},
  HGMRadio.Api in '..\HGMRadioAPI\HGMRadio.Api.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
