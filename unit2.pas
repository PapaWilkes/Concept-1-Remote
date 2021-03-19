unit Unit2;

{$mode objfpc}{$H+}

interface
 uses
  Classes, SysUtils, Forms, Controls,  Dialogs, ExtCtrls, StdCtrls,
   Buttons, EditBtn,  Crt;

type

  { TForm2 }

  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RBCom2: TRadioButton;
    RBCom3: TRadioButton;
    RBCom4: TRadioButton;
    RBCom1: TRadioButton;
    SBSetupClose: TButton;
    StaticText2: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure RBCom1Click(Sender: TObject);
    procedure SBSetupCloseClick(Sender: TObject);

  private

  public

  end;

var
  Form2: TForm2;
  SetupData:TStringList;

implementation

{$R *.lfm}
uses Unit1;

//***************************************************************//
 procedure TForm2.SBSetupCloseClick(Sender: TObject);  //no longer a memo

 var
   Index:Integer=0;
  begin

 SetupData.Strings[0]:=Edit1.Text;
 SetupData.Strings[1]:=Edit2.Text;
 SetupData.Strings[2]:=Edit3.Text;
 SetupData.Strings[3]:=Edit4.Text;
 SetupData.Strings[4]:=Form1.LazSerial1.Device;

 for Index:= 0 to 3 do

  begin  //Captions for the pop up menu
    Form1.PMenuSources.Items[Index].Caption:= SetupData.Strings[Index];
    Form1.LazSerial1.WriteData ('SET SOURCENAME '+SourceLetter[Index]+' '+SetupData.Strings[Index]+#13);

  end;

  Delay (15);

 try
     SetupData.SaveToFile('sourcenames.txt');//  Save sourcenames to disc.
 except
     ShowMessageFmt('Text file %s not found', [FName]);
 end;
  Form1.LazSerial1.WriteData('GET SELECT '+#13);//Read back required to update caption
  Form2.Close;
 end;


procedure TForm2.FormCreate(Sender: TObject);
var
  Index:Integer=0;

begin


 SetupData.LoadFromFile('sourcenames.txt');   //Read sourcenames from disc
 Edit1.Text:=SetupData.Strings[0];
 Edit2.Text:=SetupData.Strings[1];
 Edit3.Text:=SetupData.Strings[2];
 Edit4.Text:=SetupData.Strings[3];

  for Index:= 0 to 3 do
   begin
     Form1.PMenuSources.Items[Index].Caption:= SetupData.Strings[Index];
   end;
  Form1.LazSerial1.Device:= SetupData.Strings[4];

 Case    SetupData.Strings[4] of
   'COM1':RBCom1.Checked:=True;
   'COM2':RBCom2.Checked:=True;
   'COM3':RBCom3.Checked:=True;
   'COM4':RBCom4.Checked:=True;
 end;

end;

procedure TForm2.RBCom1Click(Sender: TObject);  // Change COM Port by radio buttons
begin
Form1.LazSerial1.Active:=False;
Delay (10);
 with Sender as TRadioButton do
  begin
     Form1.LazSerial1.Device:=Caption;
  end;
  Delay (20);
   Form1.LazSerial1.Active:=True;

end;





end.

