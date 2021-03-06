unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls, Menus, ECSlider, LazSerial,Crt, Graphics;
 const

    TooLoud = -20;
     SafeVol='-68';
type

  { TForm1 }

  TForm1 = class(TForm)
    ECVolSlider1: TECSlider;
    LazSerial1: TLazSerial;
    PMenuSources: TPopupMenu;
    MenuItem1: TMenuItem;       MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;       MenuItem4: TMenuItem;
    SBSetup: TSpeedButton;
    STSerialData: TStaticText;
    procedure ECVolSlider1Change(Sender: TObject);
    procedure ECVolSlider1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ECVolSlider1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure LazSerial1RxData(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure SBSetupClick(Sender: TObject);

  private

  public

  end;

var
  Form1:TForm1;
  Volume:Single;
  FName:String;
  SourceChar:Char;
  SourceLetter:array   [0..3] of char=('A','B','C','D');
  SourceName:String[8]='Source';

implementation

{$R *.lfm}
uses Unit2;

{ TForm1 }

procedure TForm1.ECVolSlider1Change(Sender: TObject);

begin
    If  ECVolSlider1.Position >= TooLoud   then
    ECVolSlider1.Position :=  TooLoud;         // Set a limit
    Volume:=  ECVolSlider1.Position;
    LazSerial1.WriteData('SET MSCLVL '+(FloatToStr(Volume))+#13); // Tell the amp
end;

procedure TForm1.ECVolSlider1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.ECVolSlider1.GrooveColor:=clMaroon;   // bit of feedback
end;

procedure TForm1.ECVolSlider1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.ECVolSlider1.GrooveColor:=clSilver;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   LazSerial1.Active := True;
   Delay (20);
   LazSerial1.WriteData('GET SELECT '+#13); // read the channel in use on amp
   Delay (50);
   Form1.ECVolSlider1.Caption:=SourceName;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    LazSerial1.Active := False;
end;

procedure TForm1.LazSerial1RxData(Sender: TObject);
  var
  InputString:string[25];
 begin
 InputString:= LazSerial1.ReadData; // Read string from amp

if LeftStr(InputString,8)='MSCLVL -' then   //- it's a volume/ music level number
     begin
        Volume:=StrToFloat(copy(InputString, 8, 3));
        ECVolSlider1.Position:= Volume;
     end
else
    if LeftStr(InputString,6)='SELECT' then     // it's a source/channel letter
     begin
       SourceChar:= InputString[8];
       SourceName:= Form2.SourceNames.Lines[Ord(SourceChar)-65];
       ECVolSlider1.Caption:=SourceName;
     end
else
 if   LeftStr(InputString,7)='Command' then     // it's an acknowledgement (of new source names)
    begin
      Delay(10);
      LazSerial1.WriteData('GET SELECT '+SourceChar+ #13);
    end
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
Var
Choice : char;
begin
with Sender as TMenuItem do
  begin
  Case Name of
    'MenuItem1':Choice:='A';
    'MenuItem2':Choice:='B';
    'MenuItem3':Choice:='C';
    'MenuItem4':Choice:='D';
  end;
   Form1.LazSerial1.WriteData('SET SELECT '+Choice+#13); //Tell amp want different source
   Delay(25);
   LazSerial1.WriteData('GET SELECT '+#13); //Read it back to update sourcename
   Delay (10);
  end;
end;


procedure TForm1.SBSetupClick(Sender: TObject);
  begin
   Form2.Show;
  end;

end.

