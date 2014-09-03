program BateBola;

uses
  Forms,
  Principal in 'Principal.pas' {Form1},
  Graficos in 'Graficos.pas',
  Constantes in 'Constantes.pas',
  Personagens in 'Personagens.pas',
  Jogo in 'Jogo.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
