-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Gil Robern
-- Modified by: Dzifa
-- Date: November 20, 2018
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
--Spring sound effect
local wrongsound = audio.loadSound( "Sounds/Incorrect.mp3" )
local wrongSoundChannel

local correctsound = audio.loadSound( "Sounds/CorrectAnswer.mp3" )
local correctSoundChannel


local Gameoversound = audio.loadSound( "Sounds/GameOver.mp3" )
local GameoverSoundChannel

local Level2Sound = audio.loadSound("Sounds/Level2.mp3") -- setting a variable to an mp3 file
local Level2SoundChannel 

-------------------------------------------------------------------------------------------
 -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/Level2Screen.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight



-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------


-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------++=
-- LOCAL VARIABLES
----------------------------------------------------------------------------------------


local lives = 3 
local heart1
local heart2
local heart3

-- create local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectObject
local incorrectAnswer
local randomOperater
local numberPoints = 0

---------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------

-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE 
        -- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
        if (lives == 2) then
            heart2.isVisible = false
            elseif (lives == 1) then
                heart1.isVisible = false
            end

           -- *** CALL THE FUNCTION TO ASK A NEW QUESTION
    end
end

-- function that calls the timer
local function startTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

local function UpdateHearts()
    if (lives == 4) then
            heart1.isVisible = true
            heart2.isVisible = true
            heart3.isVisible = true
            heart4.isVisible = true


        elseif (lives == 3) then
            heart1.isVisible = true
            heart2.isVisible = true
            heart3.isVisible = true
            heart4.isVisible = false

        
        elseif (lives == 2) then
            heart1.isVisible = true
            heart2.isVisible = true
            heart3.isVisible = false
            heart4.isVisible = false


        elseif (lives == 1) then
            heart1.isVisible = true
            heart2.isVisible = false
            heart3.isVisible = false
            heart4.isVisible = false


        elseif (lives == 0) then
            heart1.isVisible = false
            heart2.isVisible = false
            heart3.isVisible = false
            heart4.isVisible = false

            you_lose.isVisible = true
            GameoverSoundChannel = audio.play(GameoverSound)
            lives = lives - 1
            UpdateHearts()
            clockText.isVisible = false
            incorrectObject.isVisible = false
            

            numericField.isVisible = false
            pointsTextObject.isVisible = false
            questionObject.isVisible = false
        end
end


local function AskQuestion()
    -- generate 2 random numbers between a max. and a min. number
    randomOperator = math.random(1,3)
    randomNumber1 = math.random(0,10)
    randomNumber2 = math.random(0,10)

    -- if the random operater is one then do addition
    if (randomOperator == 1) then
        correctAnswer = randomNumber1 + randomNumber2
    
        --create question text object
        questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

    -- If it is 2 the do subtraction
    elseif (randomOperator == 2) then
        correctAnswer = randomNumber1 - randomNumber2

        --create question text object
        questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

    -- If it is 3 the do subtraction
    elseif (randomOperator == 3) then
        correctAnswer = randomNumber1 * randomNumber2

        --create question text object
        questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

    end 

end

local function HideCorrect()
    correctObject.isVisible = false
    AskQuestion()
end

local function HideIncorrect()
    incorrectObject.isVisible = false
    AskQuestion()
end


local function NumericFieldListener( event )

    -- User begins editing " numericField"
    if ( event.phase == "began" ) then

        -- clear text field
        event.target.text = ""

    elseif event.phase == "submitted" then


            -- when the answer is submited( enter key is pressed ) set user input to user's answer
            userAnswer = tonumber(event.target.text)


            -- if the users answer and the correct answer are the same:
            if (userAnswer == correctAnswer) then
                correctObject.isVisible = true      
                UpdateTime()

                correctSoundChannel = audio.play(correctSound)  
                timer.performWithDelay(2000, HideCorrect)
                numberPoints = numberPoints + 1

                    -- create increasing points in the text object
                pointsTextObject.text = "Points = ".. numberPoints

            -- If the users answer is incorrect, Incorrect is displayed
            else            
                incorrectObject.isVisible = true
                wrongSoundChannel = audio.play(wrongSound)
                lives = lives - 1
                UpdateHearts()  
                timer.performWithDelay(2000, HideIncorrect)

            end

        event.target.text = ""
     end
end


---------------------------------------------------------------------
-- OBJECT CREATION
---------------------------------------------------------------------

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7



you_lose = display.newImageRect("Images/you_lose.png", display.contentWidth, display.contentHeight)
you_lose.anchorX = 0
you_lose.anchorY = 0
you_lose.isVisible = false

-- display a question and sets the colour 
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/1.5, nil, 70 )
questionObject:setTextColor(255/255, 255/255, 255/255)  


-- Create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*1/3, nil, 50 )
correctObject:setTextColor(0,0,0)
correctObject.isVisible = false

-- Create the correct text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*1/3, nil, 50 )
incorrectObject:setTextColor(0,0,0)
incorrectObject.isVisible = false

-- create a points box and make it visible
pointsTextObject = display.newText( "Points = ".. numberPoints, 800, 385, nil, 50 )
pointsTextObject:setTextColor(155/255, 42/255, 198/255)


-- Create numeric field
numericField = native.newTextField( display.contentWidth/1.5, display.contentHeight/1.5, 200, 200 )
numericField.inputType = "default"

-- add the event listener for the numeriuc field
numericField:addEventListener("userInput", NumericFieldListener )

-- add a clock
clockText = display.newText(secondsLeft, 100, 650, native.systemFontBold, 100)
clockText:setFillColor( 0/255, 0/255, 153/255 )




-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    --local sceneGroup = self.view
    local phase = event.phase


    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- play audio
        Level2SoundChannel = audio.play(Level2Sound,{ loops = -1 }) 

        -- initialize the number of lives and number correct 
        lives = 2
        numberCorrect = 0
    

    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then


        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        
        -- remove the listeners when leaving the scene
        RemoveTextObjectListeners()

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
         -- Called immediately after scene goes off screen.
        audio.stop (Level2SoundChannel)
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners for Scene
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene