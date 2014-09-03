unit Graficos;

interface

uses
  Windows, Graphics, SysUtils, Dialogs;

type
  TSprite = object
    PosX,PosY: Integer;
    Largura, Altura: Integer;
    Imagem: TBitmap;
  public
    procedure Carregar(Nome: String);
    procedure Desenhar(ox,oy,dx,dy: Integer; Destino: TBitmap);
    procedure Destruir;
  end;
  TPixel = object
    FP: PByteArray;
    FPosX,FPosY: Integer;
    FCor: TColor;
    FVisivel: Boolean;
  public
    procedure Desenhar(x,y,cor,tamanho: Integer; buffer: TBitmap);
  end;

  TAnima = object(TSprite)
    Numero_Frames, Frame_Atual: Integer;
  public
    procedure SetarFrames(Num_Fra,Fra_Atu: Integer);
    procedure Animar(x,y,l,a,r: Integer; buffer: TBitmap);
  end;

implementation

uses Constantes;



{ TSprite }

procedure TSprite.Carregar(Nome: String);
begin
  Imagem:= TBitmap.Create;
  Imagem.LoadFromFile(Nome);
  Imagem.PixelFormat:= PF;
  Largura:= Imagem.Width;
  Altura := Imagem.Height;
end;

procedure TSprite.Desenhar(ox, oy, dx, dy: Integer; Destino: TBitmap);
var
  i,ii: Integer;
  O,D: PByteArray;
  Cor: Byte;
begin
  for i:= oy to oy + Altura - 1 do
      begin
        O:= PByteArray(Imagem.Scanline[i]);
        D:= PByteArray(Destino.Scanline[i + dy]);

        for ii:= ox to ox + Largura - 1 do
            begin
              Cor:= O[ii];
              if Cor=253 then
              else
                 D[(ii + dx - ox)]:= O[ii];
            end;
      end;
end;

procedure TSprite.Destruir;
begin
  Imagem.Free;
end;

{ TPixel }

procedure TPixel.Desenhar;
var
  i,ii: Integer;
begin
  if FVisivel then
    for i:= y to y + tamanho do
        begin
          FP:= Buffer.ScanLine[i];
          for ii:= x to x + tamanho do
              FP[ii]:= cor;
        end;
end;

{ TAnima }

procedure TAnima.Animar(x,y,l,a,r: Integer; Buffer: TBitmap);
begin
  if Frame_Atual = Numero_Frames then
     Frame_Atual:= 0
  else
     Inc(Frame_Atual);
  Largura:= l;
  Desenhar( Frame_Atual * l,0,x,y,Buffer);
end;

procedure TAnima.SetarFrames;
begin
  Numero_Frames:= Num_Fra;
  Frame_Atual  := Fra_Atu;
end;

end.
