unit model.pagina.interfaces;

interface

type
   iModelPagina = interface
     ['{1F8AFAC7-EDF3-4283-A81F-7A51BACE4785}']
     function setPagina( aValue:Integer ):iModelPagina;
     function setTexto( aValue:String ):iModelPagina;
     function getTexto:string;

   end;

implementation

end.
