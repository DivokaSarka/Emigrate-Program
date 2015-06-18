unit Unit1;

{$MODE Delphi}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, ExtCtrls;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StringGrid1: TStringGrid;
    ComboBox1: TComboBox;
    Label1: TLabel;
    StringGrid2: TStringGrid;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
  public
    procedure load;
    procedure save;
    procedure show;
    procedure sort(col: integer);
  end;

  TPeople = record
    name1,name2,name3: string;
    pol: integer;
    b_date: string;
    polozh: integer;
    nation,country: string;
    p_serial,p_number,snils: string;
    obraz: integer;
    prof,notes,photo,date: string
  end;

var
  Main: TMain;
  people: array[1..100] of TPeople;
  num: integer;

implementation

{$R *.lfm}

uses Unit2,Unit3,Unit4,Unit5;

procedure TMain.load;                                    // считывание базы
var base: TextFile;
begin
  AssignFile(base,'Base.txt');
  if FileExistsUTF8('Base.txt') { *Converted from FileExists* } then begin
    Reset(base);
    num:=0;
    while not EOF(base) do begin
      inc(num);
      Readln(base,people[num].name1);
      Readln(base,people[num].name2);
      Readln(base,people[num].name3);
      Readln(base,people[num].pol);
      Readln(base,people[num].b_date);
      Readln(base,people[num].polozh);
      Readln(base,people[num].nation);
      Readln(base,people[num].country);
      Readln(base,people[num].p_serial);
      Readln(base,people[num].p_number);
      Readln(base,people[num].snils);
      Readln(base,people[num].obraz);
      Readln(base,people[num].prof);
      Readln(base,people[num].notes);
      Readln(base,people[num].photo);
      Readln(base,people[num].date);
    end;
    CloseFile(base);
  end;
end;

procedure TMain.save;                                    // сохранение базы
var base: TextFile; i: integer;
begin
  AssignFile(base,'Base.txt');
  Rewrite(base);
  for i:= 1 to num do begin
    Writeln(base,people[i].name1);
    Writeln(base,people[i].name2);
    Writeln(base,people[i].name3);
    Writeln(base,people[i].pol);
    Writeln(base,people[i].b_date);
    Writeln(base,people[i].polozh);
    Writeln(base,people[i].nation);
    Writeln(base,people[i].country);
    Writeln(base,people[i].p_serial);
    Writeln(base,people[i].p_number);
    Writeln(base,people[i].snils);
    Writeln(base,people[i].obraz);
    Writeln(base,people[i].prof);
    Writeln(base,people[i].notes);
    Writeln(base,people[i].photo);
    Writeln(base,people[i].date);
  end;
  CloseFile(base);
end;

procedure TMain.Sort(col: integer);                      // сортировка таблицы
var i,j: integer;
begin
  for j:=1 to num-1 do
    for i:=1 to num-1 do
      if StringGrid1.Cells[col,i]>StringGrid1.Cells[col,i+1] then begin
        StringGrid2.Rows[1]:=StringGrid1.Rows[i];
        StringGrid1.Rows[i]:=StringGrid1.Rows[i+1];
        StringGrid1.Rows[i+1]:= StringGrid2.Rows[1];
      end;
  if col=0 then
    for j:=1 to num-1 do
      for i:=1 to num-1 do
        if StrToInt(StringGrid1.Cells[col,i])>
              StrToInt(StringGrid1.Cells[col,i+1]) then begin
                  StringGrid2.Rows[1]:=StringGrid1.Rows[i];
                  StringGrid1.Rows[i]:=StringGrid1.Rows[i+1];
                  StringGrid1.Rows[i+1]:= StringGrid2.Rows[1];
        end;
end;

procedure TMain.StringGrid1DblClick(Sender: TObject);// двойной щелчек по записи
begin
  Add.Caption:='Изменение';
  Unit2.id:=StringGrid1.Row;
  Add.Show;
end;

procedure TMain.show;                                    // обновление таблицы
var str: string; i:integer;
begin
  StringGrid1.RowCount:=num+1;
  StringGrid1.Cells[0,0]:='№';
  StringGrid1.Cells[1,0]:='ФИО';
  StringGrid1.Cells[2,0]:='Пол';
  StringGrid1.Cells[3,0]:='Дата рождения';
  StringGrid1.Cells[4,0]:='Национальность';
  StringGrid1.Cells[5,0]:='Страна эмиграции';
  for i:= 1 to num do begin
    StringGrid1.Cells[0,i]:=IntToStr(i);
    StringGrid1.Cells[1,i]:= people[i].name1+' '
                            +people[i].name2+' '
                            +people[i].name3;
    if people[i].pol=0 then StringGrid1.Cells[2,i]:='м'
      else StringGrid1.Cells[2,i]:='ж';
    StringGrid1.Cells[3,i]:=people[i].b_date;
    StringGrid1.Cells[4,i]:=people[i].nation;
    StringGrid1.Cells[5,i]:=people[i].country;
  end;
end;



procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var Res : Integer;
begin
  Res := MessageBox(
    Self.Handle
    , PChar('Внести изменения в базу перед выходом?')
    , PChar('Завершение работы')
    , MB_YESNOCANCEL + MB_ICONINFORMATION + MB_APPLMODAL
  );
  case Res of
    mrYes : CanClose:=true;
    mrNo : begin
            CanClose:=false;
            Application.Terminate;
            end;
    mrCancel : CanClose:=false;
  end;
  if CanClose then save;
end;

procedure TMain.FormCreate(Sender: TObject);           // первичная загрузка бд
begin
  load;
end;

procedure TMain.FormActivate(Sender: TObject);        // обновление формы
begin
  show;
  sort(ComboBox1.ItemIndex);
end;

procedure TMain.Button1Click(Sender: TObject);
begin
  Add.Caption:='Добавление';                             // "Добавить"
  Unit2.id:=0;
  Add.Show;
end;

procedure TMain.Button2Click(Sender: TObject);           // "Изменить"
begin
  Add.Caption:='Изменение';
  Unit2.id:=StrToInt(StringGrid1.Cells[0,StringGrid1.Row]);
  Add.Show;
end;

procedure TMain.Button3Click(Sender: TObject);           // "Удалить"
var row,i: integer;
begin
  row:=StrToInt(StringGrid1.Cells[0,StringGrid1.Row]);
  for i:=row to num do people[i]:=people[i+1];
  num:=num-1;
  show;
end;

procedure TMain.ComboBox1Change(Sender: TObject);        // сортировка
begin
  sort(ComboBox1.ItemIndex);
end;

procedure TMain.N2Click(Sender: TObject);                // принудительное сохр.
begin
  save;
end;

procedure TMain.N6Click(Sender: TObject);                // графики
begin
  Statistic.Show;
end;

procedure TMain.N8Click(Sender: TObject);                // помощь
begin
  Help.Show;
  Main.Enabled:=false;
end;

procedure TMain.N9Click(Sender: TObject);                // о программе
begin
  About.Show;
  Main.Enabled:=false;
end;

end.
