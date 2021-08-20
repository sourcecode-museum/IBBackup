unit uFuncVB;

interface
uses
    SysUtils;
    function Replace(Expressao,Find,Replace : string): string;
implementation

function Replace(Expressao, Find, Replace : string) : string;
{HPM: Substitui um caractere dentro da string}
var
  n : integer;
begin
  for n := 1 to length(Expressao) do begin
    if Copy(Expressao, n, 1) = Find then begin
      Delete(Expressao, n, 1);
      Insert(Replace, Expressao,n);
    end;
  end;
  Result := Expressao;
end;
end.
