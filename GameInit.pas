unit GameInit;

interface

uses crt;
const
	startSpeed = 100;
	snakeChar: array[1..2] of char = 
	( '@', '*');
	snakeColor = Green;
	foodColor = Yellow;
	food = '&';
type
	mainbody = record
		pX, pY: array[integer] of integer;
	end;
	mainchar = record
		pX, pY, dX, dY,
		len: integer;
	end;
var 
	snakeBody: mainbody;
	foodConsumed: boolean = true;
	exc: boolean = true;
	snake: mainchar;
	speed, fx, fy, i: integer;
procedure WriteChar(x,y: integer; ch: char);
procedure SetDirection(dX, dY: integer);
procedure Movement;
procedure FoodConsumption;
procedure BodyInit;
procedure CheckBody;
procedure WriteBody;

implementation

procedure WriteChar(x,y: integer; ch: char);
begin
	GotoXY(x,y);
	write(ch);
	GotoXY(1,1);
end;
procedure SetDirection(dX, dY: integer);
begin
	snake.dX := dX;
	snake.dY := dY;
end;
procedure FoodConsumption;
begin
	if foodConsumed then
	begin
		fx := random(ScreenWidth) + 1;
		fy := random(ScreenHeight) + 1;
		TextColor(foodColor);
		WriteChar(fx,fy,food);
		TextColor(White);
		foodConsumed := false;
	end;
	if (snake.pX = fx) and (snake.pY = fy) then
	begin
		snake.len := snake.len + 1;
		writeln(snake.len);
		speed := startSpeed + (snake.len * 3);
		foodConsumed := true;
	end;
end;
procedure BodyInit;
begin
	snakeBody.pX[0] := snake.pX;
	snakeBody.pY[0] := snake.pY;
	for i := snake.len downto 1 do
	begin
		snakeBody.pX[i] := snakeBody.pX[i-1];
		snakeBody.pY[i] := snakeBody.pY[i-1];
	end;
end;
procedure WriteBody;
begin
	TextColor(snakeColor);
	for i:= 1 to snake.len-1 do
	begin
		WriteChar(snakeBody.pX[i], snakeBody.pY[i], snakeChar[2]);
	end;
	WriteChar(snakeBody.pX[snake.len], snakeBody.pY[snake.len], ' ');
end;
procedure CheckBody;
var check: boolean;
begin
	for i := 2 to snake.len do
	begin
		if  (snake.pX = snakeBody.pX[i]) 
		and (snake.pY = snakeBody.pY[i]) then
		begin
			writeln('LOSE');
			delay(500);
			halt;
		end;
	end;
end;
procedure Movement;
begin
	BodyInit;
	snake.pX := snake.pX + snake.dX;
	snake.pY := snake.pY + snake.dY;
	if (snake.pX > ScreenWidth) or (snake.pX < 1) 
	or (snake.pY > ScreenHeight) or (snake.pY < 1) then
		halt;
	WriteBody;
	WriteChar(snake.pX, snake.pY, snakeChar[1]);
	delay(speed);
	CheckBody;
	TextColor(White);
end;
end.
