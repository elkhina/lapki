unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, Math;

type
  TForm11 = class(TForm)
    StaticText1: TStaticText;
    SGA: TStringGrid;
    StaticText2: TStaticText;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edim: TEdit;
    UpDown1: TUpDown;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdimChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
Form11: TForm11;

implementation

{$R *.dfm}

type Matrix = array of array of real;

var

 a:Matrix;   b:matrix;
 n, nold:integer;

 procedure Per(k:integer; var p:integer);
{процедура перестановки строк, когда главный элемент=0}
var i,j:integer;z:real;
begin
   z:=a[k,k];i:=k;p:=0;
   for j:=k+1 to n do
     begin
       if abs(a[j,k])>z then
{выбираем строку, где в данном столбце максимальный по модулю элемент}
          begin
            z:=abs(a[j,k]);
            i:=j;
            p:=p+1;
          end;
     end;
   if i>k then
   for j:=k to n do
     begin
       z:=a[i,j];
       a[i,j]:=a[k,j];
       a[k,j]:=z;{обмениваем элементы строк}
     end;
end;
function znak(p:integer):integer;{если была перестановка, сменился знак определителя}
begin
if p mod 2=0 then
znak:=1 else znak:=-1;
end;

procedure determ(var det:real);{нахождение определителя}
var k,i,j,p:integer;  
    r:real;
begin
b:=a;
det:=1;
for k:=1 to n do
   begin
     if b[k,k]=0 then per(k, p);{если главный=0 - перестановка}
     det:=znak(p)*det*b[k,k];{меняем знак}
     for j:=k+1 to n do
       begin
         r:=b[j,k]/b[k,k];
         for i:=k to n do
           begin
             b[j,i]:=b[j,i]-r*b[k,i];
           end;
       end;
   end;
end;


{function AlgebDopl(a:Matrix; len, icor, jcor: byte): integer;
var // алгебраическое дополнение
i, j, icount, jcount: byte;
 NewMatrix: a;
 res: integer;
begin
 SetLength(NewMatrix, len - 1, len - 1);
 icount := 0; jcount := 0;
 for i := 0 to len - 1 do
 begin
 if i = icor then
 continue;
 for j := 0 to len - 1 do
 if j <> jcor then
 begin
 NewMatrix[icount, jcount] := matrix[i, j];
 jcount := jcount + 1;
 end;
 jcount := 0;
 icount := icount + 1;
 end;

 res := matrix[icor, jcor] * determ(NewMatrix, len - 1);
 if (icor + jcor) mod 2 <> 0 then
 result := res * (-1)
 else
 result := res;
end;


function determ(a:Matrix; len: byte): integer;
var
 res: integer; // определитель
i: byte;
begin
 if len = 1 then
 res := matrix[0, 0]
 else if len = 2 then
 res := matrix[0, 0] * matrix[1, 1] - matrix[0, 1] * matrix[1, 0]
 else if len = 3 then
 res :=
 matrix[0, 0] * matrix[1, 1] * matrix[2, 2] +
 matrix[0, 1] * matrix[1, 2] * matrix[2, 0] +
 matrix[0, 2] * matrix[1, 0] * matrix[2, 1] -
 matrix[0, 2] * matrix[1, 1] * matrix[2, 0] -
 matrix[1, 2] * matrix[2, 1] * matrix[0, 0] -
 matrix[0, 1] * matrix[1, 0] * matrix[2, 2]
 else 
 begin
 res := 0;
 for i := 0 to len - 1 do
 res := res + AlgebDopl(matrix, len, i, 0); 
 end;

 result := res;

end;}





{procedure determ(var det:real);
var k,i,j:integer;
begin
det:=1;
for k:=1 to n do
begin
det:=det*a[k,k];
for j:=k+1 to n do
begin
for i:=k to n do
begin
a[j,i]:=a[j,i]-(a[j,k]/a[k,k])*a[k,i];
end;
end;
end;
end;}


procedure MtoSG(var z:matrix;  SG:TstringGrid);
var
 c, r, i, j :integer;
begin
 R:=length(z);
 C:=length(z[0]);
 SG.RowCount:=R;
 SG.ColCount:=C;
 for i:= 1 to r-1 do
 SG.Cells[0,i]:=IntToStr(i);
 for j:= 1 to c-1 do
 SG.Cells[j , 0]:=IntToStr(j);
 for i:= 1 to r-1 do
 for j:= 1 to c-1 do
 SG.Cells[j,i]:= FloattoStr(z[i,j]);
 end;


procedure TForm11.Button1Click(Sender: TObject);
begin
//Выход
close;
end;

procedure Mrandom(var z:matrix);
var
 c, r, i, j :integer;

begin
R:=length(z);
C:=length(z[0]);

randomize;
begin
for i:= 1 to r-1 do
 for j:= 1 to c-1 do
 z[i,j]:= random(18)-9;
end;
end;

procedure TForm11.Button2Click(Sender: TObject);
//Рандом
var
    det:real;
begin
Mrandom(a);
MtoSG(a,sgA);
determ(det);
edit1.Text:= floattostr(det);
end;


procedure TForm11.EdimChange(Sender: TObject); // edit dimentions
var i,j :integer;
 begin
 Nold:=Length(a)-1;
 N:=UpDown1.Position;
 Setlength(a, N+1, N+1);
 if N > Nold then
 begin 
 for j := 1 to N do
 //for i := Nold to N do
 a[j,n]:=0;

// for j := Nold to N do
 for i := 1 to N do
 a[n,i]:=0;
 end;
mtosg(a,SGA);
 end;
 end.
