program main;
uses crt, GameInit;
var
	key: char;
begin
	randomize();
	clrscr();
	snake.pX := ScreenWidth div 2;
	snake.pY := ScreenHeight div 2;
	WriteChar(snake.pX, snake.pY, snakeChar[1]);
	snake.len := 1;
	speed := startSpeed;
	while true do
	begin
		while not KeyPressed do
		begin
			Movement;
			FoodConsumption;
		end;
		key := readkey;
		case key of
			'q': halt;
			'w': SetDirection(0,-1);
			'a': SetDirection(-1,0);
			's': SetDirection(0,1);
			'd': SetDirection(1,0);
		end;
	end;
	clrscr();
end.




