unit Unit2;

{$MODE Delphi}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, inifiles,
  Vcl.Imaging.jpeg, Vcl.ImgList, Vcl.ExtDlgs, Vcl.Mask, StdCtrls;

type
  TAdd = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    Label2: TLabel;
    LabeledEdit10: TLabeledEdit;
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    LabeledEdit11: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    LabeledEdit6: TLabeledEdit;
    ComboBox2: TComboBox;
    Label3: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    MaskEdit1: TMaskEdit;
    Label4: TLabel;
    MaskEdit2: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    MaskEdit3: TMaskEdit;
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Clear;
    procedure Update(id: integer);
  end;

var
  Add: TAdd;
  id: integer;

implementation

uses Unit1;

{$R *.lfm}

procedure TAdd.Clear;                                // очистка формы
  begin
    LabeledEdit1.Text:=''; LabeledEdit2.Text:=''; LabeledEdit3.Text:='';
    MaskEdit1.Text:=''; LabeledEdit5.Text:=''; LabeledEdit6.Text:='';
    LabeledEdit7.Text:=''; LabeledEdit8.Text:=''; MaskEdit2.Text:='';
    LabeledEdit10.Text:=''; LabeledEdit11.Text:=''; MaskEdit3.Text:='';
    RadioGroup1.ItemIndex:=-1; ComboBox1.ItemIndex:=-1;
    ComboBox2.ItemIndex:=-1; Image1.Picture:=nil;
  end;

procedure TAdd.Update(id: integer);
begin
  people[id].name1:=LabeledEdit1.Text;
  people[id].name2:=LabeledEdit2.Text;
  people[id].name3:=LabeledEdit3.Text;
  people[id].pol:=RadioGroup1.ItemIndex;
  people[id].b_date:=MaskEdit1.Text;
  people[id].polozh:=ComboBox2.ItemIndex;
  people[id].nation:=LabeledEdit5.Text;
  people[id].country:=LabeledEdit6.Text;
  people[id].p_serial:=LabeledEdit7.Text;
  people[id].p_number:=LabeledEdit8.Text;
  people[id].snils:=MaskEdit2.Text;
  people[id].obraz:=ComboBox1.ItemIndex;
  people[id].prof:=LabeledEdit10.Text;
  people[id].notes:=LabeledEdit11.Text;
  people[id].photo:=extractfilename(OpenPictureDialog1.FileName);
  people[id].date:=MaskEdit3.Text;
end;

procedure TAdd.Button1Click(Sender: TObject);       // сохранение
begin
  Update(id);
  Add.Hide;
end;

procedure TAdd.Button2Click(Sender: TObject);
begin
  If OpenPictureDialog1.Execute then begin
    CopyFile(PChar(OpenPictureDialog1.FileName),
      (PChar('pictures\'+extractfilename(OpenPictureDialog1.FileName))),true);
    Image1.Picture.LoadFromFile('pictures\'+extractfilename(OpenPictureDialog1.FileName));
  end;
end;

procedure TAdd.FormHide(Sender: TObject);
begin
  Clear;
end;

procedure TAdd.FormShow(Sender: TObject);
begin
  if id=0 then begin
    inc(num);
    id:=num;
  end else begin
    LabeledEdit1.Text:=people[id].name1;
    LabeledEdit2.Text:=people[id].name2;
    LabeledEdit3.Text:=people[id].name3;
    RadioGroup1.ItemIndex:=people[id].pol;
    MaskEdit1.Text:=people[id].b_date;
    ComboBox2.ItemIndex:=people[id].polozh;
    LabeledEdit5.Text:=people[id].nation;
    LabeledEdit6.Text:=people[id].country;
    LabeledEdit7.Text:=people[id].p_serial;
    LabeledEdit8.Text:=people[id].p_number;
    MaskEdit2.Text:=people[id].snils;
    ComboBox1.ItemIndex:=people[id].obraz;
    LabeledEdit10.Text:=people[id].prof;
    LabeledEdit11.Text:=people[id].notes;
    if people[id].photo<>'' then Image1.Picture.LoadFromFile('pictures\'+extractfilename(people[id].photo));
    MaskEdit3.Text:=people[id].date;
  end;
end;

procedure TAdd.RadioGroup1Click(Sender: TObject);
begin
  Image1.Picture.Bitmap:=nil;
  Imagelist1.GetBitmap(RadioGroup1.ItemIndex,Image1.Picture.Bitmap);
end;

end.
