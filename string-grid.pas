unit Unit11;

interface

uses

Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

Dialogs, ComCtrls, StdCtrls, Grids, Math;

type

TForm11 = class(TForm)

StaticText1: TStaticText;

StringGrid1: TStringGrid;

StaticText2: TStaticText;

Edit1: TEdit;

Button1: TButton;

Button2: TButton;

Edim: TEdit;

UpDown1: TUpDown;

procedure Button2Click(Sender: TObject);

procedure Button1Click(Sender: TObject);

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

a:Matrix;

n, nold:integer;
{
procedure determ(var det:real);

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

end;
}

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
det:=1;
for k:=1 to n do
   begin
     if a[k,k]=0 then per(k, p);{если главный=0 - перестановка}
     det:=znak(p)*det*a[k,k];{меняем знак}
     for j:=k+1 to n do
       begin
         r:=a[j,k]/a[k,k];
         for i:=k to n do
           begin
             a[j,i]:=a[j,i]-r*a[k,i];
           end;
       end;
   end;
end;

procedure MtoSG(var z:matrix; SG:TstringGrid);

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

procedure Mrandom(var z:matrix; SG:TstringGrid);

var

c, r, i, j :integer;

begin

R:=length(z);

C:=length(z[0]);

SG.RowCount:=R;

SG.ColCount:=C;

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

c, r, i, j :integer;

begin

Mrandom(a);

MtoSG(a);

determ(a);

end;

procedure Edim.OnChange; // edit dimentions

var i,j :integer;

begin

Nold:=Length(a)-1;

N:=Udim.Position;

Setlength(a, N+1, N+1);

if N > Nold then

begin 

for j := 1 to N do

//for i := Nold to N do

a[j,n]:=0;

end;

begin

// for j := Nold to N do

for i := 1 to N do

a[n,i]:=0;

end;

end;

end.
{i love igor}
