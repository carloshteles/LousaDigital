program LousaDigtal;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.page.principal in 'src\view\view.page.principal.pas' {ViewPagePrincipal},
  componente.view.paleta.cores in 'src\componentes\componente.view.paleta.cores.pas' {ComponenteViewPaletaCores},
  controller.servicos.classes in 'src\controller\controller.servicos.classes.pas',
  controller.servicos.interfaces in 'src\controller\controller.servicos.interfaces.pas',
  controller.servicos.factory in 'src\controller\controller.servicos.factory.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TViewPagePrincipal, ViewPagePrincipal);
  Application.Run;
end.
