{
        Disciplina de IA
        Prof. Jomi Fred Hubner

        Algoritmo de busca em largura para
        encontrar rotas.

        Obs.: somente indica se ha solucao ou nao, nao
        motra o caminho final, para isso deveria ser
        contruida um lista de pais.
}

uses crt;

Type
    pr = ^nodo;
    nodo = record
             dsc   : String[10];
             prox  : pr;
           end;


    descritor = record
                   inicio,
                   fim       :pr;
                end;

Const
    {coluna 1=origem, coluna 2=destino }
    maxCam = 18;
    caminhos : array [1..maxCam,1..2] of String[10] =
             (('a','b'),
              ('a','c'),
              ('b','j'),
              ('j','k'),
              ('k','n'),
              ('n','m'),
              ('b','h'),
              ('h','k'),
              ('h','i'),
              ('h','g'),
              ('c','g'),
              ('c','p'),
              ('c','o'),
              ('c','d'),
              ('g','f'),
              ('f','d'),
              ('f','e'),
              ('d','e')
             );

{ rotinas de listas }

procedure inclui( var fila: descritor; valor:String);
         { inclui um registro no final da fila e atualiza o descritor
           desta fila }
Var
   paux: pr;
begin
   new(paux);
   paux^.dsc  := valor;
   paux^.prox := nil;

   {atualiza a fila}
   if fila.fim <> nil then
      fila.fim^.prox := paux;
   fila.fim       := paux;
   if fila.inicio = nil then {primeira inclusao na fila }
      fila.inicio := paux;
end;

function exclui( var fila: descritor) : string;
         { exclui o elemento do inicio da fila e
           atualiza do descritor da fila }
var p1:pr;
begin
   exclui := fila.inicio^.dsc;
   p1 := fila.inicio;
   fila.inicio := fila.inicio^.prox;
   if fila.inicio = nil then { foi exclusao do ultimo elemento }
      fila.fim := nil;
   dispose(p1);
end;


procedure mostra(var fila: descritor);
          { mostra a fila }
var p1: pr;
begin
   p1 := fila.inicio;
   while p1 <> nil do begin
         writeln(p1^.dsc);
         p1 := p1^.prox;
   end;
end;


function procura(var fila: descritor; valor:string): pr;
         { procura uma string na lista, retorna o reg. encontrado
           retorna nil se nao encontrar }
var p1:pr;
begin
     p1 := fila.inicio;
     while p1 <> nil do begin
           if p1^.dsc = valor then begin
              procura := p1;
              exit;
           end;
           p1 := p1^.prox;
     end;
     procura := nil;
end;


procedure rota(ori, dest:String);
Var
   posCam : byte;
   x,filho : string;
   p: pr;
   abertos, fechados : descritor;

begin
     abertos.inicio := nil;
     abertos.fim := nil;

     fechados.inicio := nil;
     fechados.fim := nil;

     inclui(abertos, Ori);

     while abertos.inicio <> nil do begin { eqto tem algum nodo para ser explorado }
           x := exclui(abertos);
           writeln('abrindo ',x);
           if (x = Dest) then begin { se x eh a meta }
              writeln('Ok');
              exit;
           end;

           { percorre todos os filhos de x }
           for posCam := 1 to maxCam do begin
               filho := '';
               if caminhos[posCam,1] = x then {se eh origem}
                  filho := caminhos[posCam,2];
               if caminhos[posCam,2] = x then {se eh destino}
                  filho := caminhos[posCam,1];

               if (filho <> '') then begin

                  {incluir pai de filho eh x}

                  writeln('indo para filho ',filho);
                  if (filho = dest) then begin { se x eh a meta }
                     writeln('Ok');
                     exit;
                  end;

                  if ((procura(abertos,filho) = nil) and { se o filho nao esta em abertos ou fechados }
                      (procura(fechados,filho) = nil)) then begin
                      inclui(abertos,filho);
                  end;
               end;
           end; {for}
           inclui(fechados,x);
     end;
     writeln('sem solucao');
end;

var
   Ori,
   Dest:string;

begin
     clrscr;

     write('Digite origem:'); readln(Ori);
     write('Digite destino:'); readln(Dest);

     rota(Ori, Dest);
end.
