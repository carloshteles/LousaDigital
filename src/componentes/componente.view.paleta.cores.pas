unit componente.view.paleta.cores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
   fPaleta = (LBrilho, LFundo, LCor1, LCor2);

type
  TComponenteViewPaletaCores = class(TForm)
    selCorFundo: TCalloutRectangle;
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    Circle5: TCircle;
    selCorCaracter1: TCalloutRectangle;
    Circle6: TCircle;
    Circle7: TCircle;
    Circle8: TCircle;
    Circle9: TCircle;
    Circle10: TCircle;
    Circle11: TCircle;
    Circle12: TCircle;
    Circle13: TCircle;
    selCorCaracter2: TCalloutRectangle;
    Circle14: TCircle;
    Circle15: TCircle;
    Circle16: TCircle;
    Circle17: TCircle;
    Circle18: TCircle;
    Circle19: TCircle;
    Circle20: TCircle;
    selBrilho: TCalloutRectangle;
    TrackBarBrilho: TTrackBar;
    procedure Circle4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarBrilhoChange(Sender: TObject);
    procedure TrackBarBrilhoTracking(Sender: TObject);
  private
    { Private declarations }
    FOnClick  : TProc<TObject>;
    FOnChange : TProc<TObject>;
    FFCor: TAlphaColor;
    FPaletaSelecionada: fPaleta;
    FBrilho: Single;
    procedure SetFCor(const Value: TAlphaColor);
    procedure SetBrilho(const Value: Single);
  public
    { Public declarations }
    property FCor :TAlphaColor read FFCor write SetFCor;
    Property Brilho:Single read FBrilho write SetBrilho;
    function Component : TFMXObject;
    function OnClick( aValue : TProc<TObject> ) : TComponenteViewPaletaCores;
    function onChange( aValue : TProc<TObject> ) : TComponenteViewPaletaCores;
    function Paleta( aValue: fPaleta) : TComponenteViewPaletaCores;
  protected

  end;

var
  ComponenteViewPaletaCores: TComponenteViewPaletaCores;

implementation

{$R *.fmx}

{ TComponenteViewPaletaCores }

procedure TComponenteViewPaletaCores.Circle4Click(Sender: TObject);
begin
  FCor   := TCircle(sender).Fill.Color;
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

function TComponenteViewPaletaCores.Component: TFMXObject;
begin
  case FPaletaSelecionada of
    LFundo :
    begin
      selCorFundo.Align := TAlignLayout.Client;
      Result := selCorFundo;
    end;
    LCor1 :
    begin
      selCorCaracter1.Align := TAlignLayout.Client;
      Result := selCorCaracter1;
    end;
    LCor2 :
    begin
      selCorCaracter2.Align := TAlignLayout.Client;
      Result := selCorCaracter2;
    end;
    LBrilho :
    begin
      selBrilho.Align := TAlignLayout.Client;
      Result := selBrilho;
    end;
  end;
end;

procedure TComponenteViewPaletaCores.FormCreate(Sender: TObject);
begin
  FPaletaSelecionada := LFundo;
  Brilho             := 1;
  FBrilho            := 1;
end;

function TComponenteViewPaletaCores.onChange(aValue: TProc<TObject>): TComponenteViewPaletaCores;
begin
  Result := Self;
  FOnChange := aValue;
end;

function TComponenteViewPaletaCores.OnClick(aValue: TProc<TObject>): TComponenteViewPaletaCores;
begin
  Result := Self;
  FOnClick := aValue;
end;

function TComponenteViewPaletaCores.Paleta(aValue: fPaleta): TComponenteViewPaletaCores;
begin
  Result := Self;
  FPaletaSelecionada := aValue;
end;

procedure TComponenteViewPaletaCores.SetBrilho(const Value: Single);
begin
  FBrilho := Value;
end;

procedure TComponenteViewPaletaCores.SetFCor(const Value: TAlphaColor);
begin
  FFCor := Value;
end;

procedure TComponenteViewPaletaCores.TrackBarBrilhoChange(Sender: TObject);
begin
 // Brilho := (TrackBarBrilho.Value/100);
 // if Assigned(FOnChange) then
//    FOnChange(Self);
end;

procedure TComponenteViewPaletaCores.TrackBarBrilhoTracking(Sender: TObject);
begin
//
end;

end.
