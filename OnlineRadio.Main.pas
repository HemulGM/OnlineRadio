unit OnlineRadio.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Objects, FMX.StdCtrls, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, REST.Types, Data.Bind.DBScope, Data.DB, Datasnap.DBClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Response.Adapter, FMX.ListView, FMX.Controls.Presentation;

type
  TFormMain = class(TForm)
    ActionList1: TActionList;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    PathPlay: TPath;
    PathPause: TPath;
    Layout2: TLayout;
    ListViewRadios: TListView;
    BindingsList1: TBindingsList;
    StyleBookMain: TStyleBook;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTClientRadio: TRESTClient;
    RESTRequestRadios: TRESTRequest;
    RESTResponseRadio: TRESTResponse;
    ClientDataSet1: TClientDataSet;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    Layout3: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    SpeedButton1: TSpeedButton;
    ButtonRefresh: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
  private
    FLoadImages: Boolean;
    FLoading: Boolean;
  public
    procedure LoadRadio;
  end;

var
  FormMain: TFormMain;

implementation

uses
  HGMRadio.Api, System.Net.HttpClient;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TFormMain.ButtonRefreshClick(Sender: TObject);
begin
  LoadRadio;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FLoading := False;
  FLoadImages := False;
  LoadRadio;
end;

procedure TFormMain.LoadRadio;
begin
  if FLoading then
    Exit;
  FLoading := True;
  RESTRequestRadios.ExecuteAsync(
    procedure
    var
      i: Integer;
      url: string;
      HTTP: THTTPClient;
      Stream: TMemoryStream;
    begin
      FLoading := False;
      if FLoadImages then
        Exit;
      FLoadImages := True;
      try
        HTTP := THTTPClient.Create;
        Stream := TMemoryStream.Create;
        try
          for i := 0 to ListViewRadios.Items.Count - 1 do
          begin
            url := '';
            TThread.Synchronize(nil,
              procedure
              begin
                if i >= ListViewRadios.Items.Count then
                  Exit;
                url := ListViewRadios.Items[i].Detail;
              end);
            if not url.IsEmpty then
            begin
              Stream.Clear;
              if HTTP.Get(THGMRadioApi.BaseImageUrl + url, Stream).StatusCode = 200 then
              begin
                TThread.Synchronize(nil,
                  procedure
                  var
                    j: Integer;
                  begin
                    for j := 0 to ListViewRadios.Items.Count - 1 do
                      if ListViewRadios.Items[j].Detail = url then
                      begin
                        ListViewRadios.Items[j].Bitmap.LoadFromStream(Stream);
                        ListViewRadios.Items[j].Detail := '';
                        ListViewRadios.Repaint;
                        Break;
                      end;
                  end);
              end;
            end;
          end;
        finally
          Stream.DisposeOf;
          HTTP.DisposeOf;
        end;
      except
      end;
      FLoadImages := False;
      TThread.ForceQueue(nil,
        procedure
        begin
          ListViewRadios.RecalcSize;
          ListViewRadios.Repaint;
        end);
    end, False, True,
    procedure(Sender: TObject)
    begin
      FLoading := False;
    end);
end;

end.

