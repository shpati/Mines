unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ComCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    New1: TMenuItem;
    Intermediate1: TMenuItem;
    Beginner: TMenuItem;
    Intermediate: TMenuItem;
    Advanced: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Exit2: TMenuItem;
    About2: TMenuItem;
    View1: TMenuItem;
    Increasesize1: TMenuItem;
    Decreasesize1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonClick(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure Draw(Sender: TObject);
    procedure RemoveButtons;
    procedure FormCreate(Sender: TObject);
    procedure Increasesize1Click(Sender: TObject);
    procedure Decreasesize1Click(Sender: TObject);
    procedure Changesize(Sender: TObject; BtnSize: Integer);
    procedure BeginnerClick(Sender: TObject);
    procedure IntermediateClick(Sender: TObject);
    procedure AdvancedClick(Sender: TObject);
    procedure New(Sender: TObject);
    procedure showall(Sender: TObject);
    procedure safeclick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure OnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public
    // Public declarations
  end;

procedure marksafe(I: Integer; J: Integer);
procedure num;

var
  Form1: TForm1;
  Rows, Cols, BtnSize, Mines, Safe, count: Integer;
  ButtonArray: array of array of TPanel;
  FieldArray: array of array of string;

implementation

uses Custom;

{$R *.dfm}

procedure num;
var
  I, J: Integer;
begin
  count := 0;
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      if ButtonArray[I, J].Color = clBtnFace then
        count := count + 1;
    end;
  end;
  Form1.StatusBar1.Panels[1].Text := 'Safe ones left: ' + inttostr(rows * cols -
    count - mines)+'  ';
  if count + mines = rows * cols then
    begin
    Form1.StatusBar1.Panels[1].Text := 'You won!  ';
    Showmessage('Well done!');
    end;
end;

procedure TForm1.Draw(Sender: TObject);
var
  I, J: Integer;
begin
  LockWindowUpdate(Handle);
  RemoveButtons;
  SetLength(ButtonArray, 0, 0);
  SetLength(ButtonArray, Rows, Cols);
  // Create buttons dynamically and add them to the form
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      ButtonArray[I, J] := TPanel.Create(Self);
      ButtonArray[I, J].Parent := Self;
      ButtonArray[I, J].Left := 10 + J * BtnSize;
      ButtonArray[I, J].Top := 10 + I * BtnSize;
      ButtonArray[I, J].Width := BtnSize;
      ButtonArray[I, J].Height := BtnSize;
      ButtonArray[I, J].Color := clSkyBlue;

      ButtonArray[I, J].Caption := '';
      //ButtonArray[I, J].Caption := FieldArray[I, J];

      ButtonArray[I, J].Font.Size := BtnSize div 2;
      ButtonArray[I, J].Font.Style := [fsBold];

      // Assign an event handler for the button click
      ButtonArray[I, J].OnClick := ButtonClick;
      ButtonArray[I, J].OnMouseDown := MouseDown;
    end;
  end;
  Form1.ClientWidth := Cols * BtnSize + 20;
  Form1.ClientHeight := StatusBar1.Height + Rows * BtnSize + 20;
  StatusBar1.Panels[0].Text := '  Size: ' + inttostr(Rows) + ' x ' +
    inttostr(Cols) + ', Mines: ' + inttostr(Mines);
  StatusBar1.Panels[0].Width := StatusBar1.Width div 2;
  LockWindowUpdate(0);
end;

procedure TForm1.RemoveButtons;
var
  I, J: Integer;
begin
  // Free the resources of all buttons and adjust the array
  for I := 0 to High(ButtonArray) do
  begin
    for J := 0 to High(ButtonArray[I]) do
    begin
      if Assigned(ButtonArray[I, J]) then
      begin
        ButtonArray[I, J].Free;
        ButtonArray[I, J] := nil;
      end;
    end;
  end;
  SetLength(ButtonArray, 0, 0);
end;

procedure TForm1.ButtonClick(Sender: TObject);
var
  I, J, lastsafe: Integer;
begin
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      if ButtonArray[I, J] = Sender then
        if FieldArray[I, J] = 'X' then
        begin
          // Clicked on a Mine!
          showall(Self);
          ButtonArray[I, J].Color := clRed;
          Form1.StatusBar1.Panels[1].Text := 'Game Over!  ';
          exit;
        end
        else if FieldArray[I, J] = '' then
        begin
          // Clicked on an empty field!
          marksafe(I, J);
          repeat
            lastsafe := safe;
            safeclick(ButtonArray[I, J]);
          until safe = lastsafe;
        end
        else
        begin
          ButtonArray[I, J].Color := clBtnFace;
          ButtonArray[I, J].Caption := FieldArray[I, J];
          if FieldArray[I, J] = '1' then
            ButtonArray[I, J].Font.Color := clBlue;
          if FieldArray[I, J] = '2' then
            ButtonArray[I, J].Font.Color := clGreen;
          if FieldArray[I, J] = '3' then
            ButtonArray[I, J].Font.Color := clRed;
          if FieldArray[I, J] = '4' then
            ButtonArray[I, J].Font.Color := clNavy;
          if FieldArray[I, J] = '5' then
            ButtonArray[I, J].Font.Color := clMaroon;
          if FieldArray[I, J] = '6' then
            ButtonArray[I, J].Font.Color := clPurple;
          if FieldArray[I, J] = '7' then
            ButtonArray[I, J].Font.Color := clFuchsia;
          if FieldArray[I, J] = '8' then
            ButtonArray[I, J].Font.Color := clRed;
          safe := safe + 1;
        end;
    end;
  end;
  num;
end;

procedure TForm1.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I, J: Integer;
begin
  // Check if the right mouse button is pressed
  if Button = mbRight then
  begin
    for I := 0 to Rows - 1 do
    begin
      for J := 0 to Cols - 1 do
      begin
        if ButtonArray[I, J] = Sender then
        begin
          if ButtonArray[I, J].Color = clSkyBlue then
            ButtonArray[I, J].Color := clBlack
          else if ButtonArray[I, J].Color = clBlack then
            ButtonArray[I, J].Color := clSkyBlue;
        end;
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BtnSize := 30;
  IntermediateClick(Self);
  Form1.StatusBar1.Panels[1].Text := 'Safe ones left: ' +
    inttostr(rows * cols - count - mines)+'  ';
end;

procedure TForm1.Increasesize1Click(Sender: TObject);
var
  I, J: Integer;
begin
  if Btnsize > 72 then
    exit;
  BtnSize := BtnSize + 2;
  Changesize(Self, BtnSize);
end;

procedure TForm1.Decreasesize1Click(Sender: TObject);
var
  I, J: Integer;
begin
  if Btnsize < 12 then
    exit;
  BtnSize := BtnSize - 2;
  Changesize(Self, BtnSize);
end;

procedure TForm1.Changesize(Sender: TObject; BtnSize: Integer);
var
  I, J: Integer;
begin
  LockWindowUpdate(Handle);
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      ButtonArray[I, J].Left := 10 + J * BtnSize;
      ButtonArray[I, J].Top := 10 + I * BtnSize;
      ButtonArray[I, J].Width := BtnSize;
      ButtonArray[I, J].Height := BtnSize;
      ButtonArray[I, J].Font.Size := BtnSize div 2;
    end;
  end;
  // Set the size of the program window
  Form1.ClientWidth := Cols * BtnSize + 20;
  Form1.ClientHeight := Rows * BtnSize + StatusBar1.Height + 20;
  LockWindowUpdate(0);
end;

procedure TForm1.BeginnerClick(Sender: TObject);
begin
  Rows := 9;
  Cols := 9;
  Mines := 10;
  New(Self);
end;

procedure TForm1.IntermediateClick(Sender: TObject);
begin
  Rows := 16;
  Cols := 16;
  Mines := 40;
  New(Self);
end;

procedure TForm1.AdvancedClick(Sender: TObject);
begin
  Rows := 16;
  Cols := 30;
  Mines := 99;
  New(Self);
end;

procedure TForm1.Exit2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.New(Sender: TObject);
var
  I, J, k, l: Integer;
begin
  SetLength(FieldArray, 0, 0);
  SetLength(FieldArray, Rows, Cols);
  safe := 0;
  Randomize;
  k := 0;
  repeat
    begin
      I := Random(Rows);
      J := Random(Cols);
      if FieldArray[I, J] = 'X' then
        k := k - 1
      else
        FieldArray[I, J] := 'X';
      k := k + 1;
    end;
  until k = Mines;

  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      l := 0;
      if I > 0 then
      begin
        if J > 0 then
          if FieldArray[I - 1, J - 1] = 'X' then
            l := l + 1;
        if FieldArray[I - 1, J] = 'X' then
          l := l + 1;
        if J < Cols - 1 then
          if FieldArray[I - 1, J + 1] = 'X' then
            l := l + 1;
      end;
      if J > 0 then
        if FieldArray[I, J - 1] = 'X' then
          l := l + 1;
      if J < Cols - 1 then
        if FieldArray[I, J + 1] = 'X' then
          l := l + 1;
      if I < Rows - 1 then
      begin
        if J > 0 then
          if FieldArray[I + 1, J - 1] = 'X' then
            l := l + 1;
        if FieldArray[I + 1, J] = 'X' then
          l := l + 1;
        if J < Cols - 1 then
          if FieldArray[I + 1, J + 1] = 'X' then
            l := l + 1;
      end;
      if FieldArray[I, J] <> 'X' then
        if l = 0 then
          FieldArray[I, J] := ''
        else
          FieldArray[I, J] := inttostr(l);
    end;
  end;
  Draw(Self);
end;

procedure marksafe(I: Integer; J: Integer);
begin
  if not (FieldArray[I, J] = 'X') then
  begin
    if not (ButtonArray[I, J].Color = clBtnFace) then
    begin
      if FieldArray[I, J] = '' then
        ButtonArray[I, J].Color := clBtnFace
      else
        Form1.ButtonClick(ButtonArray[I, J]);
      safe := safe + 1;
    end;
  end;
end;

procedure TForm1.showall(Sender: TObject);
var
  I, J: Integer;
begin
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      ButtonArray[I, J].Color := clBtnFace;
      if FieldArray[I, J] = 'X' then
      begin
        ButtonArray[I, J].Font.Style := [fsBold];
        ButtonArray[I, J].Caption := 'X';
      end;
    end;
  end;
end;

procedure TForm1.safeclick(Sender: TObject);
var
  I, J: Integer;
begin
  for I := 0 to Rows - 1 do
  begin
    for J := 0 to Cols - 1 do
    begin
      if I > 0 then
      begin
        if J > 0 then
          if (ButtonArray[I - 1, J - 1].Color = clBtnFace) and
            (FieldArray[I - 1, J - 1] = '') then
          begin
            marksafe(I, J);
            Continue;
          end;
        if (ButtonArray[I - 1, J].Color = clBtnFace) and
          (FieldArray[I - 1, J] = '') then
        begin
          marksafe(I, J);
          Continue;
        end;
        if J < Cols - 1 then
          if (ButtonArray[I - 1, J + 1].Color = clBtnFace) and
            (FieldArray[I - 1, J + 1] = '') then
          begin
            marksafe(I, J);
            Continue;
          end;
      end;
      if J > 0 then
        if (ButtonArray[I, J - 1].Color = clBtnFace) and
          (FieldArray[I, J - 1] = '') then
        begin
          marksafe(I, J);
          Continue;
        end;
      if J < Cols - 1 then
        if (ButtonArray[I, J + 1].Color = clBtnFace) and
          (FieldArray[I, J + 1] = '') then
        begin
          marksafe(I, J);
          Continue;
        end;
      if I < Rows - 1 then
      begin
        if J > 0 then
          if (ButtonArray[I + 1, J - 1].Color = clBtnFace) and
            (FieldArray[I + 1, J - 1] = '') then
          begin
            marksafe(I, J);
            Continue;
          end;
        if (ButtonArray[I + 1, J].Color = clBtnFace) and
          (FieldArray[I + 1, J] = '') then
        begin
          marksafe(I, J);
          Continue;
        end;
        if J < Cols - 1 then
          if (ButtonArray[I + 1, J + 1].Color = clBtnFace) and
            (FieldArray[I + 1, J + 1] = '') then
          begin
            marksafe(I, J);
            Continue;
          end;
      end;
    end;
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.About2Click(Sender: TObject);
begin
  ShowMessage('Mines v0.1 by Shpati Koleka, MIT License');
end;

procedure TForm1.OnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I, J: Integer;
begin
  if Key = Ord('X') then
  begin
    // Find the index of the clicked button in the array
    for I := 0 to Rows - 1 do
    begin
      for J := 0 to Cols - 1 do
      begin
        if FieldArray[I, J] = 'X' then
          ButtonArray[I, J].Caption := 'X';
      end;
    end;
  end;
end;

procedure TForm1.OnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I, J: Integer;
begin
  if Key = Ord('X') then
  begin
    for I := 0 to Rows - 1 do
    begin
      for J := 0 to Cols - 1 do
      begin
        if FieldArray[I, J] = 'X' then
          ButtonArray[I, J].Caption := '';
      end;
    end;
  end;
end;

end.
