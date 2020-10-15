program OnlineRadio;

uses
  System.StartUpCopy,
  FMX.Forms,
  OnlineRadio.Main in 'OnlineRadio.Main.pas' {FormMain},
  HGMRadio in '..\HGMRadioAPI\HGMRadio.Api';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
