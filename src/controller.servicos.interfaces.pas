unit controller.servicos.interfaces;

interface

type
  iControllerDados = interface
    ['{F70A3E7B-9FDE-49DD-A537-15DA54EAD466}']
    function Gravar(iPagina:integer; sTexto:String):iControllerDados;
    function Recuperar(iPagina:Integer):string;
  end;

  iControllerDadosFactory = interface
    ['{A6680543-F12E-4786-A51D-8B3809ACA7EE}']
     function JSON:iControllerDados;
  end;

implementation

end.
