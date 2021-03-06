unit Unit2;

{$mode objfpc}{$H+}

interface
 uses
  Classes, SysUtils, Forms, Controls,  Dialogs, ExtCtrls, StdCtrls,
   Buttons, EditBtn,  Crt;

type

  { TForm2 }

  TForm2 = class(TForm)
    SourceNames: TMemo;
    SBSourceMemoClose: TButton;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure SBSourceMemoCloseClick(Sender: TObject);

  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}
uses Unit1;

//***************************************************************//
 procedure TForm2.SBSourceMemoCloseClick(Sender: TObject);

 var
   Index:Integer;

 begin

  for Index:= 0 to 3 do

  begin
  Form1.PMenuSources.Items[Index].Caption:= Form2.SourceNames.Lines[Index];

    Form1.LazSerial1.WriteData ('SET SOURCENAME '+SourceLetter[Index]+' '+Form2.SourceNames.Lines[Index]+#13);

    end;

  Delay (20);
 try
   SourceNames.Lines.SaveToFile('sourcenames.txt');//  Save sourcenames to disc.
 except
   ShowMessageFmt('Text file %s not found', [FName]);
 end;
  Form1.LazSerial1.WriteData('GET SELECT '+#13); Read back reuirted to updat caption
  Form2.Close;
 end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Index:Integer;

begin
 SourceNames.Lines.LoadFromFile('sourcenames.txt');   //Read sourcenames from disc
 for Index:= 0 to 3 do
   begin
     Form1.PMenuSources.Items[Index].Caption:= Form2.SourceNames.Lines[Index];
   end;

end;

end.

