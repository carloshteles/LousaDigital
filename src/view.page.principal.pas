unit view.page.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts,
  FMX.Edit, FMX.ComboEdit, FMX.Ani, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  dataset.Serialize;

type
  TViewPagePrincipal = class(TForm)
    LayoutLousa: TLayout;
    PaginaEsquerda: TLayout;
    PaginaDireita: TLayout;
    mmoDireita: TMemo;
    RectangleDivideLousa: TRectangle;
    LayoutPrincipal: TLayout;
    RectangleFundo: TRectangle;
    imbBrilho: TImage;
    imgCorCaracter: TImage;
    imgCorLousa: TImage;
    imgLogotip: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    edtPaginaImpar: TComboEdit;
    edtPaginaPar: TComboEdit;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    SpeedButton3: TSpeedButton;
    LayoutBotoesInferior: TLayout;
    e: TLabel;
    de: TLabel;
    Layout2: TLayout;
    StyleBook1: TStyleBook;
    mmoEsquerda: TMemo;
    RectangleFundoLousa: TRectangle;
    LayoutCorFundo: TLayout;
    LayoutCorCaracter: TLayout;
    LayoutBilho: TLayout;
    Edit1: TEdit;
    FloatAnimation1: TFloatAnimation;
    mtb_LousaDigita: TFDMemTable;
    mtb_LousaDigitapagina: TIntegerField;
    mtb_LousaDigitatexto: TMemoField;
    selBrilho: TCalloutRectangle;
    TrackBarBrilho: TTrackBar;
    procedure FormResize(Sender: TObject);
    procedure mmoEsquerdaApplyStyleLookup(Sender: TObject);
    procedure imgCorLousaClick(Sender: TObject);
    procedure imgCorCaracterClick(Sender: TObject);
    procedure LayoutBotoesInferiorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutBotoesInferiorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imbBrilhoClick(Sender: TObject);
    procedure TrackBarBrilhoChange(Sender: TObject);
    procedure TrackBarBrilhoExit(Sender: TObject);
    procedure edtPaginaImparChangeTracking(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPagePrincipal: TViewPagePrincipal;
  FPosX:Single;

implementation

uses FMX.Styles.Objects, componente.view.paleta.cores,
  controller.servicos.factory;
{$R *.fmx}

procedure TViewPagePrincipal.edtPaginaImparChangeTracking(Sender: TObject);
begin
 //Edit1.Text := edtPaginaPar.Text;
  TControllerFactory
    .New
    .JSON
    .Gravar(1,'');


end;

procedure TViewPagePrincipal.FormCreate(Sender: TObject);
begin
  mtb_LousaDigita.Open;
  selBrilho.Visible := False;
end;

procedure TViewPagePrincipal.FormResize(Sender: TObject);
begin
  try
    PaginaEsquerda.Width := (LayoutLousa.Width-10)/2;
  except

  end;

end;

procedure TViewPagePrincipal.imbBrilhoClick(Sender: TObject);
begin
  selBrilho.Visible := (not selBrilho.Visible);
end;

procedure TViewPagePrincipal.imgCorCaracterClick(Sender: TObject);
  var
     fCores: TComponenteViewPaletaCores;
begin
  fCores :=  TComponenteViewPaletaCores.Create(self);
  LayoutCorCaracter.AddObject(
       fCores
       .Paleta(LCor1)
       .Onclick( procedure(Sender:TObject)
                  begin
                    mmoDireita.FontColor  := fCores.FCor;
                    mmoEsquerda.FontColor  := fCores.FCor;
                    LayoutCorCaracter.Controls.Clear;
                  end)
    .Component
  );
end;

procedure TViewPagePrincipal.imgCorLousaClick(Sender: TObject);
  var
     fCores: TComponenteViewPaletaCores;
begin
  fCores :=  TComponenteViewPaletaCores.Create(self);
  LayoutCorFundo.AddObject(
       fCores
       .Paleta(LFundo)
       .Onclick( procedure(Sender:TObject)
                  begin
                    RectangleFundoLousa.Fill.Color  := fCores.FCor;
                    LayoutCorFundo.Controls.Clear;
                  end)
    .Component
  );

end;

procedure TViewPagePrincipal.LayoutBotoesInferiorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FPosX := X;
end;

procedure TViewPagePrincipal.LayoutBotoesInferiorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if X < FPosX then
    Edit1.Text := 'Esquerda'
  else
    Edit1.Text := 'Direita';

  FPosX := 0;
end;

procedure TViewPagePrincipal.mmoEsquerdaApplyStyleLookup(Sender: TObject);
  Var
  Obj: TFmxObject;
begin

  Obj := TMemo(sender).FindStyleResource('background');

  if Assigned(Obj) And ( Obj is TActiveStyleObject ) Then
     TActiveStyleObject(Obj).Source := Nil;

end;

procedure TViewPagePrincipal.SpeedButton1Click(Sender: TObject);
begin
  FloatAnimation1.Start;
  edtPaginaImpar.Text := (edtPaginaImpar.Text.ToInteger + 2).ToString;
  edtPaginaPar.Text := (edtPaginaPar.Text.ToInteger + 2).ToString;

  // mtb_LousaDigita.ToJSONObject().Format()

end;

procedure TViewPagePrincipal.TrackBarBrilhoChange(Sender: TObject);
begin
  mmoDireita.Opacity  := ( TrackBarBrilho.Value / 100 );
  mmoEsquerda.Opacity := ( TrackBarBrilho.Value / 100 );

end;

procedure TViewPagePrincipal.TrackBarBrilhoExit(Sender: TObject);
begin
  selBrilho.Visible := False;
end;

end.
