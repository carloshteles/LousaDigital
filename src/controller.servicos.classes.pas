unit controller.servicos.classes;


interface

uses
  controller.servicos.interfaces;

type
   TControllerDados = class(TInterfacedObject, iControllerDados)
     private
     public
       constructor Create;
       destructor Destroy;override;
       class function New:iControllerDados;
       function Gravar(iPagina:integer; sTexto:String):iControllerDados;
       function Recuperar(iPagina:Integer):string;
   end;

implementation

{ TControllerDados }

constructor TControllerDados.Create;
begin

end;

destructor TControllerDados.Destroy;
begin

  inherited;
end;

function TControllerDados.Gravar(iPagina: integer; sTexto: String): iControllerDados;
begin
//
end;

class function TControllerDados.New: iControllerDados;
begin
  result := Self.Create;
end;

function TControllerDados.Recuperar(iPagina: Integer): string;
begin
//
end;

end.
