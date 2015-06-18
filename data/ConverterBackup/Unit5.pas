unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  Vcl.ExtCtrls, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series;

type
  TStatistic = class(TForm)
    Chart1: TChart;
    DataSeries: TPieSeries;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure graph1;
    procedure graph2;
    procedure graph3;
  end;

var
  Statistic: TStatistic;
  TmpSeries: TChartSeries;
  page: integer = 1;

implementation

uses Unit1;

{$R *.dfm}

procedure TStatistic.Button1Click(Sender: TObject);             // след. граф
begin
  if page < 3 then inc(page);
  case page of
    1:graph1;
    2:graph2;
    3:graph3;
  end;
end;

procedure TStatistic.Button2Click(Sender: TObject);
begin
  if page > 1 then dec(page);
  case page of
    1:graph1;
    2:graph2;
    3:graph3;
  end;
end;

procedure TStatistic.FormShow(Sender: TObject);
begin
  graph1;
end;

procedure TStatistic.graph1;                                 // график-1
var i,man,woman: integer;
begin
  man:=0; woman:=0;
  for i := 1 to num do if people[i].pol=0 then inc(man) else inc(woman);
  label1.Caption:='График - 1/3';
  With DataSeries do begin
    Clear;
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Соотношение по полам');
    AddPie(man, 'Мужчин - '+floatToStr(Round(man/num*100))+'%', clBlue);
    AddPie(woman, 'Женщин - '+floatToStr(Round(woman/num*100))+'%', clRed);
  end;
end;

procedure TStatistic.graph2;                                  // график-2
var i,man,woman: integer; kol:array[1..4] of integer;
begin
  kol[1]:=0; kol[2]:=0; kol[3]:=0; kol[4]:=0;
  for i := 1 to num do
    if copy(people[i].date,7,4)='2012' then inc(kol[1])
      else if copy(people[i].date,7,4)='2013' then inc(kol[2])
        else if copy(people[i].date,7,4)='2014' then inc(kol[3])
          else if copy(people[i].date,7,4)='2015' then inc(kol[4]);
  label1.Caption:='График - 2/3';
  With DataSeries do begin
    Clear;
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Количество человек за последние 4 года');
    AddPie(kol[1], '2012г.', clSkyBlue);
    AddPie(kol[2], '2013г.', clOlive);
    AddPie(kol[3], '2014г.', clWebIvory);
    AddPie(kol[4], '2015г.', clLime);
  end;
end;

procedure TStatistic.graph3;                                  // график-3
var i,j,k,temp: integer; flac: boolean; str: string;
    coun:array[1..10] of integer;
    names:array[1..10] of string;
begin
  k:=0;                          // считаем эмигрантов и сортируем
  for i := 1 to num do begin
    flac:=false;
    for j := 1 to 10 do
      if people[i].country=names[j] then flac:=true;
    if not flac then begin
      inc(k);
      names[k]:=people[i].country;
      coun[k]:=0;
    end;
  end;

  for i := 1 to num do
    for j := 1 to k do
      if (people[i].country=names[j]) then inc(coun[j]);

  for i := 1 to k-1 do
    for j := 1 to k-1 do
      if coun[j]<coun[j+1] then begin
        temp:=coun[j];
        coun[j]:=coun[j+1];
        coun[j+1]:=temp;
        str:=names[j];
        names[j]:=names[j+1];
        names[j+1]:=str;
      end;

  label1.Caption:='График - 3/3';
  With DataSeries do begin
    Clear;
    Chart1.Title.Text.Clear;
    Chart1.Title.Text.Add('Большие группы эмигрантов по странам');
    AddPie(coun[1], names[1], clYellow);
    AddPie(coun[2], names[2], clBlue);
    AddPie(coun[3], names[3], clRed);
    AddPie(coun[4], names[4], clGreen);
  end;
end;

end.
