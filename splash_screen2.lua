-----------------------------------------------------------------------------------------
-- Title: Company Logo Animation
-- Name: Dzifa
-- Course: ICS2O/3C
-- This program animates the company logo on the screen
-----------------------------------------------------------------------------------------

-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeed = 3

-- make a evil sound
local evil = audio.loadSound("Sound/evil.mp3")
local evilSoundChannel 

-- background image with width and height
local backgroundImage = display.newImageRect("Images/RainbowBackground@2x.png", 2048, 1536)
local vampire = display.newImageRect("Images/vampire.png", 300, 200)
local Monsterfun = display.newImageRect("Images/Monsterfun.png", 300, 200)

-- set the initial x and y position of vampire.
vampire.x = 500
vampire.y = display.contentHeight/2

-- set the initial x and y position of monsterfun.
Monsterfun.x = 500
Monsterfun.y = display.contentHeight/5
evilSoundChannel = audio.play(evil)


-- Function: MoveVampire
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the Vampire
local function MoveVampire(event)
	-- add the scroll speed to the x-value of the cutedog
	vampire.x = vampire.x + scrollSpeed


	-- change the transparency of the vampire every time it moves
	-- so that it fades out.
	vampire.alpha = vampire.alpha - 0.00000000000001
end

-- MoveVampire will be called over and over again
Runtime:addEventListener("enterFrame", MoveVampire)





 