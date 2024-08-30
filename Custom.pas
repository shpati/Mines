unit Custom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Main;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Button1: TButton;
    procedure OnShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.OnShow(Sender: TObject);
begin

  Edit1.Text := Inttostr(Rows);
  Edit2.Text := InttoStr(Cols);
  Edit3.Text := IntToStr(Mines);
  Form2.ClientWidth := Edit1.Left + Edit1.Width + 20;
  Button1.Width := Form2.ClientWidth - 40;
  Button1.Left := Form2.ClientWidth - Button1.Width - 20;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Rows := StrtoInt(Edit1.Text);
  if Rows < 4 then
    Rows := 4;
  Cols := StrtoInt(Edit2.Text);
  if Cols < 4 then
    Cols := 4;
  Mines := StrtoInt(Edit3.Text);
  if Mines > Rows * Cols then
    Mines := Rows * Cols;
  Form1.New(Self);
  Form2.Close;
end;

procedure TForm2.OnKeyPress(Sender: TObject; var Key: Char);
begin
  // Allow digits (0-9) and control characters (e.g., Backspace)
  if not (Key in ['0'..'9', #8]) then
  begin
    // Prevent the character from being entered
    Key := #0;
  end;
end;

end. 
