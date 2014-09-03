unit Personagens;

interface

uses Windows,Graficos, Constantes, Dialogs, SysUtils, Graphics, Jogo;

type
  TSentido = (cima,baixo,esquerda,direita);

  TNave = object(TAnima)
  public
    procedure Teclado;
  end;
  TComputer = object(TAnima)
  public
    procedure mover;
  end;
  TBall = object(TAnima)
    x,y: Integer;
  public
    procedure mover;
  end;
  TStar = object(TPixel)
    FVelocidade: Integer;
    procedure Movimentar(buffer: tbitmap);
    procedure Init(buffer: tbitmap);
  end;


var
  N   : TNave;
  Ball: TBall;
  Computer: TComputer;
  Estrelas: array[1..N_STAR] of TStar;

implementation

//DETECÇÃO DE COLISÃO
function Colisao(x1,y1,w1,h1,x2,y2,w2,h2:Integer):Boolean;
begin
  if (x1 <= x2 + w2) and
     (x1 + w1 >= x2) and
     (y1 <= y2 + h2) and
     (y1 + h1 >= y2) then
     Result := True
  else
     Result := False;
end;

{ TStar }

procedure TStar.Init;
var i : Integer;
    Cor: TColor;
begin
  for i:= 1 to N_STAR do
      begin
        Estrelas[i].Fposx:= Random(Buffer.Width );
        Estrelas[i].Fposy:= Random(Buffer.Height) * -1;
        Estrelas[i].Fvisivel:= False;
        Estrelas[i].Fvelocidade:= Random(2) + 1;
      end;
end;
procedure TStar.Movimentar;
var i : Integer;
begin
  if FPosY>0 then
     FVisivel:= true;
  if FPosY>=Buffer.Height - 10 then
     begin
       Fposx:= Random(Buffer.Width );
       Fposy:= Random(Buffer.Height) * -1;
       Fvisivel:= False;
     end
  else
     Inc(Fposy,FVelocidade);
end;


{ TComputer }

procedure TComputer.mover;
begin
  if PosX + Largura div 2 < Ball.PosX + Ball.Largura div 2 then
     Inc(PosX)
  else
     if PosX + Largura div 2 > Ball.PosX + Ball.Largura div 2 then
        Dec(PosX);
  if PosX<=0 then
     PosX:= 0;
  if PosX + Largura > LARG_TELA then
     PosX:= LARG_TELA - Largura;
  if Ball.PosX + Ball.Largura + 10 >= LARG_TELA then
     Dec(PosX);
  if Ball.PosY < Largura div 2 then
     Dec(PosX);
end;

{ TNave }

procedure TNave.Teclado;
begin
  if GetKeyState(VK_LEFT)<0 then
     Dec(PosX)
  else
     if GetKeyState(VK_RIGHT)<0 then
        Inc(PosX);
  if PosX<=0 then
     PosX:= 0;
  if PosX + Largura > LARG_TELA then
     PosX:= LARG_TELA - Largura;
end;

{ TBall }

procedure TBall.mover;
begin

  if PosX<=LIMITE then
     x:= 1
  else
    if PosX + Largura>= LARG_TELA - LIMITE then
       x:= -1;

  if PosY<=LIMITE then
     begin
       y:= 2;
       Humano.Pontuar(100);
     end
  else
     if PosY + Altura>=ALTU_TELA - LIMITE then
        begin
          y:= - 2 ;
          Computador.Pontuar(100);
        end;


  if Colisao(PosX,PosY,Largura,Altura,
             N.PosX,N.PosY,N.Largura,N.Altura) then
             begin
               if PosX + (Largura div 2)<= N.PosX + N.Largura div 5 then
                  if x>0 then
                     x:= x * -2
               else
                  x:= x * 1;

               if PosX + (Largura div 2)>= N.PosX + N.Largura - (N.Largura div 5) then
                  if x<0 then
                     x:= x * -2
               else
                  x:= x * 1;

               y:= y * -1;
             end;

  if Colisao(PosX,PosY,Largura,Altura,
             Computer.PosX,Computer.PosY,Computer.Largura,Computer.Altura) then
             begin
               if PosX + (Largura div 2)<= Computer.PosX + Computer.Largura div 5 then
                  if x>0 then
                     x:= x * -2
               else
                  x:= x * 1;

               if PosX + (Largura div 2)>= Computer.PosX + Computer.Largura - (Computer.Largura div 5) then
                  if x<0 then
                     x:= x * -2
               else
                  x:= x * 1;

               y:= y * -1;
             end;

  inc(PosX,x);
  Inc(PosY,y);

  if PosX<(Largura - 2) * -1 then
     PosX:= PosX + 50;
  if PosX>LARG_TELA + Largura - 10 then
     PosX:= PosX - 50;
  if PosY<0 then
     PosY:= 30;
  if PosY > ALTU_TELA - 1 then
     PosY:= PosY - 30;

end;

end.
