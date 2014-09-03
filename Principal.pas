{
  PROGRAMANDO JOGOS - PROJETO BATE-BOLA
  OPEN SOURCE - DISTRIBUA LIVREMENTE. MANTENHA OS CRÉDITOS
  DO AUTOR E DOS COLABORADORES.
  AUTOR: ANTONIO SÉRGIO DE SOUSA VIEIRA 2002
  BRASIL - FORTALEZA - CE
}

unit Principal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Graficos, Personagens, StdCtrls, Jogo;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Iniciar1: TMenuItem;
    Timer1: TTimer;
    Crditos1: TMenuItem;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Iniciar1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Crditos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Buffer: TBitmap;
  FPS: Integer;

implementation

uses Constantes;


{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Buffer:= TBitmap.Create;
  Buffer.LoadFromFile('Plataforma.bmp');
  Buffer.Width:= LARG_TELA;
  Buffer.Height:= ALTU_TELA;
  Buffer.Canvas.Brush.Color:= clBlack;
  Buffer.Canvas.FillRect(Rect(0,0,LARG_TELA,ALTU_TELA));
  Buffer.PixelFormat:= PF;

  FPS:= 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Buffer.Destroy;
end;

procedure TForm1.Iniciar1Click(Sender: TObject);
var
  x,y,i: integer;
begin
  Humano.Zerar;
  Computador.Zerar;

  x:=1;y:=1;
  N.Carregar('Plataforma.bmp');
  N.Largura:= 42;
  N.SetarFrames(1,0);
  N.PosY:= 220;
  N.PosX:= 100;

  Computer.Carregar('Plataforma8.bmp');
  Computer.Largura:= 51;
  Computer.SetarFrames(1,0);
  Computer.PosY:= 5;
  Computer.PosX:= 100;

  Ball.Carregar('bola.bmp');
  Ball.Largura:= 21;
  Ball.SetarFrames(2,0);
  Ball.PosX:= 50;
  Ball.PosY:= 50;
  Ball.x:= 1;
  Ball.y:= 1;

  for i:= 1 to N_STAR do
      Estrelas[i].Init(buffer);
  while not application.Terminated do
  begin
    Inc(FPS);
    Buffer.Canvas.FillRect(Rect(0,0,LARG_TELA,ALTU_TELA));

    for i:= 1 to N_STAR do
    with Estrelas[i] do
         begin
           desenhar(Fposx,Fposy,60,0,buffer);
           movimentar(buffer);
         end;


    N.Animar(N.PosX,N.PosY,42,0,1,buffer);
    N.Teclado;

    with computer do
         begin
           Animar(PosX,PosY,Largura,0,2,buffer);
           mover;
         end;

    Ball.Animar(Ball.PosX,Ball.PosY,21,0,1,buffer);
    Ball.mover;

    Humano.Desenhar(10,10,'Jogador:',buffer);
    Computador.Desenhar(10,30,'Computador:',buffer);
    Canvas.Draw(0,0,Buffer);
    Application.ProcessMessages;
  end;
  N.Destruir;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Caption:= 'FPS: ' + inttostr(FPS);
  FPS:= 0;
end;

procedure TForm1.Crditos1Click(Sender: TObject);
begin
  ShowMessage('Projeto Bate-Bola - OPEN SOURCE' + #13 +
              'Programador Antonio Sérgio - Toda a ajuda será bem vinda!' + #13 +
              'Email: sergiosvieira@hotmail.com' + #13 +
              'Controle : SETAS - Movimentar a Nave' + #13 +
              '           F1    - Iniciar');
end;

end.
