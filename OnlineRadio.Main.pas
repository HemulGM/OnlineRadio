unit OnlineRadio.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Controls, FMX.Graphics,
  FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList, FMX.Objects, FMX.StdCtrls, FMX.Layouts;

type
  TFormMain = class(TForm)
    ActionList1: TActionList;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Path1: TPath;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

end.

