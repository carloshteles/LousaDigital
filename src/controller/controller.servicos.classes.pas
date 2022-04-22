unit controller.servicos.classes;


interface

uses
  Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  controller.servicos.interfaces;

type
   TControllerDados = class(TInterfacedObject, iControllerDados)
     private
       FMemTable:TFDMemTable;
     public
       constructor Create;
       destructor Destroy;override;
       class function New:iControllerDados;
       function Gravar(iPagina:integer; sTexto:String):iControllerDados;
       function Recuperar(iPagina:Integer):string;
       function getTotalPaginas:Integer;

   end;

implementation

uses
  System.SysUtils;

{ TControllerDados }

constructor TControllerDados.Create;
begin

  FMemTable := TFDMemTable.Create(nil);
  FMemTable.FieldDefs.Clear;
  FMemTable.FieldDefs.Add('pagina', ftInteger);
  FMemTable.FieldDefs.Add('texto', ftMemo);
  FMemTable.CreateDataSet;

  if FileExists('.\fmemtable.json') then
    FMemTable.LoadFromFile('.\fmemtable.json',sfJSON);

end;

destructor TControllerDados.Destroy;
begin
  FMemTable.DisposeOf;
  inherited;
end;

function TControllerDados.Gravar( iPagina : integer; sTexto : String ) : iControllerDados;
begin
  // Usei o locate aqui por saber que é um ambiente controlado e de poucos dados
  if (FMemTable.Locate( 'pagina', iPagina, [ ] ) ) then
    FMemTable.Edit
  else begin
    FMemTable.Insert;
    FMemTable.FieldByName('pagina').AsInteger := iPagina;
  end;

  FMemTable.FieldByName('texto').AsString := sTexto;
  FMemTable.Post;

  //ja gravo em disco
  FMemTable.SaveToFile('.\fmemtable.json',sfJSON);

end;

class function TControllerDados.New: iControllerDados;
begin
  result := Self.Create;
end;

function TControllerDados.Recuperar(iPagina: Integer): string;
begin

  //Usei o locate aqui por saber que é um ambiente controlado e de poucos dados
  case FMemTable.Locate('pagina',iPagina,[]) of
    True : Result := FMemTable.FieldByName('texto').AsString;
    False: Result := '';
  end;

end;

function TControllerDados.getTotalPaginas: Integer;
begin
  Result := FMemTable.RecordCount;
end;

end.
