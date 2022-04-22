unit view.page.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.Layouts,
  FMX.Edit, FMX.ComboEdit, FMX.Ani;
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
    btnVoltarPaginas: TSpeedButton;
    btnAdiantarPagina: TSpeedButton;
    edtPaginaImpar: TComboEdit;
    edtPaginaPar: TComboEdit;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    LayoutBotoesInferior: TLayout;
    e: TLabel;
    de: TLabel;
    Layout2: TLayout;
    RectangleFundoLousa: TRectangle;
    LayoutCorFundo: TLayout;
    LayoutCorCaracter: TLayout;
    LayoutBilho: TLayout;
    FloatAnimation1: TFloatAnimation;
    selBrilho: TCalloutRectangle;
    TrackBarBrilho: TTrackBar;
    lblTotalPaginas: TLabel;
    PresentedScrollBoxDireita: TPresentedScrollBox;
    PresentedScrollBoxEsquerda: TPresentedScrollBox;
    mmoEsquerda: TMemo;
    procedure FormResize(Sender: TObject);
    procedure mmoEsquerdaApplyStyleLookup(Sender: TObject);
    procedure imgCorLousaClick(Sender: TObject);
    procedure imgCorCaracterClick(Sender: TObject);
    procedure LayoutBotoesInferiorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutBotoesInferiorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure btnVoltarPaginasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imbBrilhoClick(Sender: TObject);
    procedure TrackBarBrilhoChange(Sender: TObject);
    procedure TrackBarBrilhoExit(Sender: TObject);
    procedure btnAdiantarPaginaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure imgLogotipDblClick(Sender: TObject);
    procedure RectangleDivideLousaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure RectangleDivideLousaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    procedure RecuperarPaginas;
    procedure GravarPaginas;
    procedure TrocarPaginas(aValue:Integer);
    procedure MovePainelParaDireita;
    procedure MovePainelParaEsquerda;
    procedure PaginaProxima;
    Procedure PaginaAnterior;
  public
    { Public declarations }
  end;

var
  ViewPagePrincipal: TViewPagePrincipal;
  FPosX, FPosY:Single;

implementation

uses FMX.Styles.Objects, componente.view.paleta.cores,
  controller.servicos.factory;
{$R *.fmx}

procedure TViewPagePrincipal.FloatAnimation1Finish(Sender: TObject);
begin
 RecuperarPaginas;
end;

procedure TViewPagePrincipal.FormCreate(Sender: TObject);
begin
  ViewPagePrincipal.FullScreen  := True;
  selBrilho.Visible := False;
end;

procedure TViewPagePrincipal.FormResize(Sender: TObject);
begin
  try
    PaginaEsquerda.Width := (LayoutLousa.Width-10)/2;

    //mmoDireita.Align := TAlignLayout.None;
   // mmoEsquerda.Align := TAlignLayout.None;


  except

  end;

end;

procedure TViewPagePrincipal.FormShow(Sender: TObject);
begin

  MovePainelParaDireita;

  mmoDireita.Lines.Clear;
  mmoEsquerda.Lines.Clear;
  RecuperarPaginas;
end;

procedure TViewPagePrincipal.imbBrilhoClick(Sender: TObject);
begin
  selBrilho.Visible := (not selBrilho.Visible);
end;

procedure TViewPagePrincipal.imgCorCaracterClick(Sender: TObject);
  var
     ViewCores: TComponenteViewPaletaCores;
begin
  ViewCores :=  TComponenteViewPaletaCores.Create(self);
  LayoutCorCaracter.AddObject(
       ViewCores
       .Paleta(LCor1)
       .Onclick( procedure(Sender:TObject)
                  begin
                    mmoDireita.FontColor  := ViewCores.FCor;
                    mmoEsquerda.FontColor  := ViewCores.FCor;
                    LayoutCorCaracter.Controls.Clear;
                  end)
    .Component
  );
end;

procedure TViewPagePrincipal.imgCorLousaClick(Sender: TObject);
  var
     ViewCores: TComponenteViewPaletaCores;
begin
  ViewCores :=  TComponenteViewPaletaCores.Create(self);
  LayoutCorFundo.AddObject(
       ViewCores
       .Paleta(LFundo)
       .Onclick( procedure(Sender:TObject)
                  begin
                    RectangleFundoLousa.Fill.Color  := ViewCores.FCor;
                    LayoutCorFundo.Controls.Clear;
                  end)
    .Component
  );

end;

procedure TViewPagePrincipal.imgLogotipDblClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TViewPagePrincipal.LayoutBotoesInferiorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FPosX := X;
end;

procedure TViewPagePrincipal.LayoutBotoesInferiorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if X < FPosX then
    PaginaAnterior
  else
    PaginaProxima;

  FPosX := 0;
end;

procedure TViewPagePrincipal.RectangleDivideLousaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FPosY := Y;
end;

procedure TViewPagePrincipal.RectangleDivideLousaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Y < FPosY then
  begin
    mmoDireita.Align := TAlignLayout.None;
    mmoEsquerda.Align := TAlignLayout.None;



    mmoEsquerda.Height := PresentedScrollBoxEsquerda.Height + 150;
    mmoEsquerda.Width  := PresentedScrollBoxEsquerda.Width + 150;

    mmoDireita.Height := PresentedScrollBoxDireita.Height + 150;
    mmoDireita.Width  := PresentedScrollBoxDireita.Width + 150;

  end
  else
  begin
    mmoDireita.Align := TAlignLayout.Client;
    mmoEsquerda.Align := TAlignLayout.Client;
  end;


  FPosY := 0;
end;



procedure TViewPagePrincipal.mmoEsquerdaApplyStyleLookup(Sender: TObject);
  Var
  Obj: TFmxObject;
begin

  Obj := TMemo(sender).FindStyleResource('background');

  if Assigned(Obj) And ( Obj is TActiveStyleObject ) Then
     TActiveStyleObject(Obj).Source := Nil;

end;

procedure TViewPagePrincipal.MovePainelParaDireita;
begin
  FloatAnimation1.StartValue := (LayoutLousa.Width*-1);
  FloatAnimation1.StopValue  := LayoutLousa.Position.X;
end;

procedure TViewPagePrincipal.MovePainelParaEsquerda;
begin
  FloatAnimation1.StartValue := LayoutLousa.Position.X + LayoutLousa.Width;
  FloatAnimation1.StopValue  := LayoutLousa.Position.X;
end;

procedure TViewPagePrincipal.PaginaAnterior;
begin

  if edtPaginaPar.Text.ToInteger = 0 then
    Exit;

  MovePainelParaEsquerda;
  FloatAnimation1.Start;
  TrocarPaginas( - 2 );
end;

procedure TViewPagePrincipal.PaginaProxima;
begin

  GravarPaginas;

  MovePainelParaDireita;
  FloatAnimation1.Start;
  TrocarPaginas( 2 );
end;

procedure TViewPagePrincipal.btnAdiantarPaginaClick(Sender: TObject);
begin
 PaginaProxima
end;

procedure TViewPagePrincipal.btnVoltarPaginasClick(Sender: TObject);
begin
  PaginaAnterior;
end;



procedure TViewPagePrincipal.RecuperarPaginas;
begin
  mmoEsquerda.Text := TControllerFactory.New.JSON.Recuperar(edtPaginaImPar.Text.ToInteger);
  mmoDireita.Text  := TControllerFactory.New.JSON.Recuperar(edtPaginaPar.Text.ToInteger);
  lblTotalPaginas.Text :=   TControllerFactory.New.JSON.getTotalPaginas().ToString;
end;

procedure TViewPagePrincipal.GravarPaginas;
begin
  try
    TControllerFactory
      .New.JSON
        .Gravar( edtPaginaImpar.Text.ToInteger, mmoEsquerda.Text );

    TControllerFactory
      .New.JSON
        .Gravar( edtPaginaPar.Text.ToInteger, mmoDireita.Text );

    lblTotalPaginas.Text :=   TControllerFactory.New.JSON.getTotalPaginas().ToString;

  except
    on e:exception do
      ShowMessage('Erro ao gravar paginas : ' + e.Message);
  end;

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

procedure TViewPagePrincipal.TrocarPaginas(aValue: Integer);
begin
  if (aValue=-2) and (edtPaginaImpar.Text.ToInteger = 1) then
    Exit;

  edtPaginaImpar.Text := (edtPaginaImpar.Text.ToInteger + aValue ).ToString;
  edtPaginaPar.Text := (edtPaginaPar.Text.ToInteger + aValue ).ToString;
end;

end.
