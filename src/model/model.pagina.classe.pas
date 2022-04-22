unit model.pagina.classe;

interface

uses
  model.pagina.interfaces;

type
  TModelPagina = class( TInterfacedObject, iModelPagina )
    private
     FPagina:integer;
     FTexto:String;
     function setPagina( aValue:Integer ):iModelPagina;
     function setTexto( aValue:String ):iModelPagina;
     function getTexto:string;
    public
      constructor Create;
      destructor Destroy; override;
      class function New:iModelPagina;
  end;

implementation

{ TModelPagina }

constructor TModelPagina.Create;
begin

end;

destructor TModelPagina.Destroy;
begin

  inherited;
end;

function TModelPagina.getTexto: string;
begin
  Result := FTexto;
end;


class function TModelPagina.New: iModelPagina;
begin
  Result := Self.Create;
end;

function TModelPagina.setPagina(aValue: Integer): iModelPagina;
begin
  Result := self;
  FPagina := aValue;
end;

function TModelPagina.setTexto(aValue: String): iModelPagina;
begin
  Result := self;
  FTexto := aValue;
end;

end.
