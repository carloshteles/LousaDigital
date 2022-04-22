unit componente.view.bilho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TComponenteViewBrilho = class(TForm)
    selBrilho: TCalloutRectangle;
    TrackBarBrilho: TTrackBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ComponenteViewBrilho: TComponenteViewBrilho;

implementation

{$R *.fmx}

end.
