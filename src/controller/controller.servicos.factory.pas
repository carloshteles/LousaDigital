unit controller.servicos.factory;


interface

uses
  controller.servicos.interfaces;

type
   TControllerFactory = class(TInterfacedObject, iControllerDadosFactory)
     private
     public
       constructor Create;
       destructor Destroy; override;
       class function New : iControllerDadosFactory;
       function JSON:iControllerDados;
   end;

implementation

uses
  controller.servicos.classes;

{ TNomeDaClasse }

function TControllerFactory.JSON: iControllerDados;
begin
  Result :=   TControllerDados.New;
end;

constructor TControllerFactory.Create;
begin

end;

destructor TControllerFactory.Destroy;
begin

  inherited;
end;

class function TControllerFactory.New: iControllerDadosFactory;
begin
  Result := Self.Create;
end;

end.
