unit Jogo;

interface

uses
  Windows, Graphics, SysUtils, Dialogs;

type
  TScore = object
    Pontos: Integer;
  public
    procedure Pontuar(valor: integer);
    procedure Zerar;
    procedure Desenhar(posx,posy: integer;nome: string; buffer: TBitmap);
  end;

var
  Humano, Computador: TScore;

implementation

procedure TScore.Pontuar;
begin
  Inc(Pontos, valor);
end;

procedure TScore.Zerar;
begin
  Pontos:= 0;
end;

procedure TScore.Desenhar;
begin
  Buffer.Canvas.Font.Color:= clWhite;
  Buffer.Canvas.Font.Name := 'Tahoma' ;
  Buffer.Canvas.TextOut(posx,posy,nome + ' ' + inttostr(Pontos));
end;
end.
