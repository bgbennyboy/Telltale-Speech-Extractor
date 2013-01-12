program Demo_ID3v2_Level3;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UNewFrame in 'UNewFrame.pas' {FormNewFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormNewFrame, FormNewFrame);
  Application.Run;
end.
