%Flappy Bird
%Sharif Natheir
%May 27, 2014
setscreen ("offscreenonly")
View.Set ("Graphics:287,500")
var score : int := 0 %User's score.
var highScore : array 1 .. 3 of int := init (0, 0, 0) %Hard, easy, and medium high scores.
var font := Font.New ("Helvetica:15") %To draw the instructions.
var font2 := Font.New ("Broadway:32:bold") %To draw the title and the score.
var width := Font.Width ("Play Game", font) %To center "Instructions" on the Instructions Page.
var width2 := Font.Width ("Ready!", font) %To center "Ready!" on the Instructions Page.
var width3 := Font.Width ("Instructions", font) %To center "Play Game" on the Instructions Page.
var width4 := Font.Width ("Flappy Bird", font2) %To center "Ready!" on the Instructions Page.
var width5 := Font.Width (intstr (score), font2) %To center the users score on the Game Page.
var width6 := Font.Width ("Exit", font) %To centre the exit button.
var width7 := Font.Width ("Hard", font) %To centre the hard game type button.
var width8 := Font.Width ("Medium", font) %To centre the medium game type button.
var width9 := Font.Width ("Easy", font) %To centre the easy game type button.
var width10 := Font.Width ("High Score!", font2) %To centre the high score congratulations.
var instructions : boolean := false %Opens the instructions if user clicks the button.
var xGrass : int := 50 %X coordinate of the grass.
var grass : int := Pic.FileNew ("grass.jpg") %Picture of grass.
var backgroundDay : int := Pic.FileNew ("day.jpg") %Background picture of day.
var backgroundNight : int := Pic.FileNew ("Night.jpg") %Background picture of night.
var dayOrNight : int := Rand.Int (1, 2) %Decides whether it is day or night.
var yAltitude := 250 %The y coordinate of the bird.
var xmouse, ymouse, button : int %Finds the location of the mouse and whether it is clicked or not.
var xPipe : int := maxx %The x location of the pipes (start at maxx).
var difficulty : int := 100 %How many pixels are in between the two pipes.
var yPipe : int := Rand.Int (75, maxy - difficulty) %The height of the bottom pipe.
var xPipe2 : int := maxx + 150 %The x location of the pipes (start at maxx).
var yPipe2 : int := Rand.Int (75, maxy - difficulty) %The height of the bottom pipe.
var exitBtn : boolean := false %Exits the game if the exit button is pressed.
var death : boolean := false %Is true when the bird dies.
var birdColour : int := Rand.Int (36, 62) %Randomises the bird's colour.
var gameModes : boolean := false %The Game Mode screen.
var gameType : int := 0 %Game modes - Easy, Medium, or Hard.
var powerUp : boolean := false %Power Up doubles the user's score for a limited time.
var powerUpx : int := 1 %The x coordinate of the red powerup bar.
var scoresInt : int %a var that is an int is needed to open a file
open : scoresInt, "scores.txt", get
for z : 1 .. 3
    get : scoresInt, highScore (z)
end for
close : scoresInt
procedure background %Draws the background.
    if dayOrNight = 1 then %Decides whether the game is day or night.
	Pic.Draw (backgroundDay, 0, 0, picCopy)
    else
	Pic.Draw (backgroundNight, 0, 0, picCopy)
    end if
    Draw.FillBox (0, 0, maxx, 60, 68) %Ground.
    Draw.FillOval (30, yAltitude, 17, 17, blue) %Bird outline.
    Draw.FillOval (30, yAltitude, 15, 15, birdColour) %Bird body.
    Draw.FillOval (37, yAltitude + 3, 3, 6, white) %Bird eyes.
    Draw.FillOval (37, yAltitude + 3, 2, 2, black) %Bird pupil.
    Draw.ThickLine (39, yAltitude - 7, 46, yAltitude - 7, 6, 43) %Bird beak.
    Draw.FillOval (24, yAltitude - 3, 8, 3, birdColour * 2) %Bird wings.
    Pic.Draw (grass, 0, 60, picCopy) %Grass on bottom.
    %PIPES
    Draw.FillBox (xPipe, maxy, xPipe + 50, yPipe + difficulty - 1, black)
    Draw.FillBox (xPipe, 75, xPipe + 50, yPipe, black)
    Draw.FillBox (xPipe + 3, maxy, xPipe + 47, yPipe + difficulty + 2, green)
    Draw.FillBox (xPipe + 3, 75, xPipe + 47, yPipe - 3, green)
    Draw.FillBox (xPipe2, maxy, xPipe2 + 50, yPipe2 + difficulty - 1, black)
    Draw.FillBox (xPipe2, 75, xPipe2 + 50, yPipe2, black)
    Draw.FillBox (xPipe2 + 3, maxy, xPipe2 + 47, yPipe2 + difficulty + 2, green)
    Draw.FillBox (xPipe2 + 3, 75, xPipe2 + 47, yPipe2 - 3, green)
    Draw.ThickLine (3, 5, maxx - 3, 5, 9, black)
    Font.Draw ("Power Up", 2, 13, font, green)
end background
%MENU SCREEN
loop
    %Resets variable values for when the user plays again.
    death := false
    xPipe := maxx
    yPipe := Rand.Int (75, maxy - 100)
    xPipe2 := maxx + 174
    yPipe2 := Rand.Int (75, maxy - 100)
    yAltitude := 250
    score := 0
    powerUp := false
    gameType := 0
    exitBtn := false
    xGrass := 50
    powerUpx := 1
    instructions := false
    birdColour := Rand.Int (36, 62)
    Music.PlayFileStop
    background %Draws the Menu Screen.
    Font.Draw ("Easy High Score: " + intstr (highScore (3)), 30, maxy - 90, font, yellow)
    Font.Draw ("Medium High Score: " + intstr (highScore (2)), 30, maxy - 110, font, yellow)
    Font.Draw ("Hard High Score: " + intstr (highScore (1)), 30, maxy - 130, font, yellow)
    Font.Draw ("Flappy Bird", round (maxx / 2 - width4 / 2), maxy - 50, font2, blue)
    Draw.Box (maxx div 2 - 50, 285, maxx div 2 + 50, 325, black)
    Draw.Box (maxx div 2 - 50, 185, maxx div 2 + 50, 225, black)
    Draw.Box (maxx div 2 - 50, 85, maxx div 2 + 50, 125, black)
    Draw.Fill (maxx div 2 - 45, 290, blue, black)
    Draw.Fill (maxx div 2 - 45, 190, blue, black)
    Draw.Fill (maxx div 2 - 45, 90, blue, black)
    Font.Draw ("Play Game", round (maxx / 2 - width / 2), 295, font, green)
    Font.Draw ("Instructions", round (maxx / 2 - width / 2), 195, font, yellow)
    Font.Draw ("Exit", round (maxx / 2 - width6 / 2), 95, font, brightred)
    View.Update
    loop %Keeps looking for the mouse.
	Mouse.Where (xmouse, ymouse, button) %Finds out where the mouse is.
	if button = 1 then %If "Play Game" is clicked, exit the Menu screen.
	    if xmouse > maxx div 2 - 50 and ymouse > 285 and xmouse < maxx div 2 + 50 and ymouse < 325 then
		gameModes := true
		exit
		%If "Instructions" is clicked, make "instructions" boolean true.
	    elsif xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 185 and ymouse < 225 then
		instructions := true
		exit
		%If "exit" is clicked, make exitBtn boolean true.
	    elsif xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 85 and ymouse < 125 then
		exitBtn := true
		exit
	    end if
	end if
    end loop
    if exitBtn = true then
	exit
    end if
    %If user clicks on instructions, display them.
    if instructions = true then
	cls %Clears the Menu Screen.
	background %Displays the background.
	Font.Draw ("Flappy Bird", round (maxx / 2 - width4 / 2), maxy - 50, font2, blue)
	Font.Draw ("Hold or tap the mouse to make ", 1, maxy - 80, font, yellow)
	Font.Draw ("the bird fly higher. You lose if ", 1, maxy - 100, font, yellow)
	Font.Draw ("you hit a pipe, the floor, or the", 1, maxy - 120, font, yellow)
	Font.Draw ("top. Every 10 points, you will get ", 1, maxy - 140, font, yellow)
	Font.Draw ("a power up. It will double the", 1, maxy - 160, font, yellow)
	Font.Draw ("the value of normal points for", 1, maxy - 180, font, yellow)
	Font.Draw ("5 points. Good luck!", 1, maxy - 200, font, yellow)
	Draw.Box (maxx div 2 - 50, 90, maxx div 2 + 50, 130, black)     %Button.
	Draw.Fill (maxx div 2 - 45, 95, blue, black) %Button.
	Font.Draw ("Ready!", round (maxx / 2 - width2 / 2), 100, font, green)
	View.Update
	loop %Keeps looking for the mouse.
	    Mouse.Where (xmouse, ymouse, button)
	    %If button is clicked, exit the instructions to the start of the game.
	    if button = 1 and xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 90 and ymouse < 130 then
		gameModes := true
		exit
	    end if
	end loop
    end if

    if gameModes = true then
	cls %Clears the Menu Screen.
	background
	Font.Draw ("Flappy Bird", round (maxx / 2 - width4 / 2), maxy - 50, font2, blue)
	Draw.Box (maxx div 2 - 50, 130, maxx div 2 + 50, 170, black)     %Button.
	Draw.Fill (maxx div 2 - 45, 135, blue, black) %Button.
	Draw.Box (maxx div 2 - 50, 230, maxx div 2 + 50, 270, black)     %Button.
	Draw.Fill (maxx div 2 - 45, 235, blue, black) %Button.
	Draw.Box (maxx div 2 - 50, 330, maxx div 2 + 50, 370, black)     %Button.
	Draw.Fill (maxx div 2 - 45, 335, blue, black) %Button.
	Font.Draw ("Hard", round (maxx / 2 - width7 / 2), 142, font, brightred)
	Font.Draw ("Medium", round (maxx / 2 - width8 / 2), 242, font, yellow)
	Font.Draw ("Easy", round (maxx / 2 - width9 / 2), 342, font, green)
	View.Update
	loop %Keeps looking for the mouse.
	    Mouse.Where (xmouse, ymouse, button)
	    %If button is clicked, exit the instructions to the start of the game.
	    if button = 1 then
		if xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 130 and ymouse < 170 then
		    difficulty := 125 %Hard game type.
		    gameType := 1
		    exit
		elsif xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 230 and ymouse < 270 then
		    difficulty := 150 %Medium game type.
		    gameType := 2
		    exit
		elsif xmouse > maxx div 2 - 50 and xmouse < maxx div 2 + 50 and ymouse > 330 and ymouse < 370 then
		    difficulty := 200 %Easy game type.
		    gameType := 3
		    exit
		end if
	    end if
	end loop
    end if
    Music.PlayFileReturn ("In Game Sound.mp3")
    loop
	Mouse.Where (xmouse, ymouse, button) %Finds the mouse
	background
	xPipe -= 2 %Moves pipe over to the left.
	Draw.ThickLine (0, 5, powerUpx, 5, 5, brightred)
	if xPipe < -50 then %If the pipe is off screen, reset it to maxx and find a new height for it.
	    xPipe := maxx
	    yPipe := Rand.Int (75, maxy - difficulty)
	end if
	xPipe2 -= 2 %Moves second pipe over to the left.
	if xPipe2 < -50 then %If the pipe is off screen, reset it to maxx and find a new height for it.
	    xPipe2 := maxx
	    yPipe2 := Rand.Int (75, maxy - difficulty)
	end if
	xGrass := xGrass + 12 %Moves the grass over.
	if xGrass > 12 then
	    xGrass := 0
	end if
	Pic.Draw (grass, xGrass - 12, 60, picCopy)
	if button = 1 then
	    yAltitude += 3
	else
	    yAltitude -= 3
	end if
	Font.Draw (intstr (score), round (maxx / 2 - width5 / 2), 20, font2, blue)
	View.Update
	if powerUpx >= 280 then
	    powerUp := true
	end if
	if xPipe + 50 = 30 or xPipe2 + 50 = 30 then
	    if powerUp = true then
		score += 2
		powerUpx -= 56
		if powerUpx <= 5 then
		    powerUp := false
		end if
	    else
		score += 1
		powerUpx += 28
	    end if
	    width5 := Font.Width (intstr (score), font2)
	    Music.PlayFileReturn ("scoring.wav")
	end if

	delay (12) %Death situations.
	if yAltitude - 7 <= 83 or yAltitude + 12 >= maxy then
	    death := true
	elsif whatdotcolor (45, yAltitude) = black then
	    death := true
	elsif whatdotcolour (30, yAltitude + 15) = black then
	    death := true
	elsif whatdotcolour (30, yAltitude - 15) = black then
	    death := true
	elsif whatdotcolour (38, yAltitude - 10) = black then
	    death := true
	elsif whatdotcolour (28, yAltitude - 10) = black then
	    death := true
	elsif whatdotcolour (28, yAltitude + 10) = black then
	    death := true
	elsif whatdotcolour (38, yAltitude + 10) = black then
	    death := true
	end if
	if death = true then
	    Music.PlayFileStop
	    Music.PlayFileReturn ("Smack.wav")
	    if score = 0 then
		delay (500)
	    end if
	    for decreasing x : yAltitude .. 90 %Death animation.
		background
		Font.Draw (intstr (score), round (maxx / 2 - width5 / 2), 20, font2, blue)
		yAltitude -= 1
		delay (2)
		Draw.FillOval (30, yAltitude, 17, 17, blue)
		Draw.FillOval (30, yAltitude, 15, 15, birdColour)
		Draw.FillOval (37, yAltitude + 3, 3, 6, white)
		Draw.FillOval (37, yAltitude + 3, 2, 2, black)
		Draw.ThickLine (39, yAltitude - 7, 46, yAltitude - 7, 6, 43)
		Draw.FillOval (24, yAltitude - 3, 8, 3, birdColour * 2)
		View.Update
	    end for
	end if
	exit when death = true
    end loop
    if score > highScore (gameType) then %Congratulate the user and set their score as their new high score.
	Music.PlayFileReturn ("Applause.mp3")
	highScore (gameType) := score
	Font.Draw ("High Score!", round (maxx / 2 - width10 / 2), maxy div 2, font2, white)
	View.Update
	delay (2000) %Time to hear the congratulations sound.
	% File.Delete ("scores.txt") %deletes the old one
	% File.Rename ("scoresout.txt", "scores.txt")
	open : scoresInt, "scores.txt", put                 %this will open a connection to send data
	for h : 1 .. 3
	    put : scoresInt, highScore (h)
	end for
	close : scoresInt
    end if
end loop
