
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
-- creating wrong sound
local wrongsound = audio.loadSound( "Sounds/Incorrect.mp3" )
local wrongSoundChannel
-- creating correct sound
local correctsound = audio.loadSound( "Sounds/correct.mp3" )
local correctSoundChannel
-- creating level 2 sound
local Level2Sound = audio.loadSound("Sounds/Level2.mp3") -- setting a variable to an mp3 file
local Level2SoundChannel 
-- creating youwin sound
local youwinSound = audio.loadSound("Sounds/youwin.mp3") -- setting a variable to an mp3 file
local youwinSoundChannel 
-- creating gameover sound
local GameOverSound = audio.loadSound("Sounds/GameOver.mp3") -- setting a variable to an mp3 file
local GameOverSoundChannel 

----------------------------------------------------------------------------------------++=
-- LOCAL VARIABLES
----------------------------------------------------------------------------------------


local lives = 3 
local heart1
local heart2
local heart3

local youWin
local you_lose

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
local sub
local sub2

local pointsTextObject
local bkg_image



---------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------

local function HideYouLose()
    you_lose.isVisible = false
end

local function HideEverything()
    correctObject.isVisible = false

    incorrectObject.isVisible = false

    pointsTextObject.isVisible = false

    questionObject.isVisible = false

    numericField.isVisible = false

    heart1.isVisible = false

    heart2.isVisible = false

    heart3.isVisible = false

    bkg_image.isVisible = false
end

local function GoToLevel3()
    composer.gotoScene( "level3_screen" )
end

local function ShowYouWin()
    youWin.isVisible = true
end

local function ShowYouLose()
    you_lose.isVisible = true
end

local function HideYouWin()
    youWin.isVisible = false
end

local function RestartScene()

    --alreadyClickedAnswer = false
    --correct.isVisible = false
    --incorrect.isVisible = false

    --livesText.text = "Number of lives = " .. tostring(lives)
    --numberCorrectText.text = "NumberCorrect = " .. tostring(numberCorrect)

    -- if they have 0 lives, go to the You Lose screen
    if (lives == 0) then

        timer.performWithDelay(500, ShowYouLose)

        timer.performWithDelay(500, HideEverything)

        timer.performWithDelay(2000, GoToLevel3)

        timer.performWithDelay(2000, HideYouLose)

        

        

        
    elseif (numberPoints == 5) then

        timer.performWithDelay(500, ShowYouWin)

        timer.performWithDelay(500, HideEverything)

        timer.performWithDelay(2050, GoToLevel3)

        timer.performWithDelay(2000, HideYouWin)
        
        youwinSoundChannel = audio.play(youwinSound)
    end
end


local function UpdateHearts()
    if (lives == 3) then
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = true
    


    elseif (lives == 2) then
            heart1.isVisible = true
            heart2.isVisible = true
            heart3.isVisible = false

        
    elseif (lives == 1) then
            heart1.isVisible = true
            heart2.isVisible = false
            heart3.isVisible = false


    elseif (lives == 0) then
            heart1.isVisible = false
            heart2.isVisible = false
            heart3.isVisible = false
        
        

            
            GameOverSoundChannel = audio.play(GameOverSound,{ loops = -1 })
            
                        
    end
end



local function AskQuestion()
    -- generate 2 random numbers between a max. and a min. number
    randomOperator = math.random(1,3)
    randomNumber1 = math.random(0,10)
    randomNumber2 = math.random(0,10)
    sub = math.random(10,20)
    sub2 = math.random(2,10)


    -- if the random operater is one then do addition
    if (randomOperator == 1) then
        correctAnswer = randomNumber1 + randomNumber2
    
        --create question text object
        questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

    -- If it is 2 the do subtraction
    elseif (randomOperator == 2) then
        correctAnswer = sub - sub2

        --create question text object
        questionObject.text = sub .. " - " .. sub2 .. " = "

    -- If it is 3 the do multiplication
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
                

                correctSoundChannel = audio.play(correctSound)  
                timer.performWithDelay(2000, HideCorrect)
                numberPoints = numberPoints + 1

                    -- create increasing points in the text object
                pointsTextObject.text = "Points = ".. numberPoints
                RestartScene()


            -- If the users answer is incorrect, Incorrect is displayed
            else            
                incorrectObject.isVisible = true
                wrongSoundChannel = audio.play(wrongSound)
                lives = lives - 1
                UpdateHearts() 
                RestartScene() 
                timer.performWithDelay(2000, HideIncorrect)

        

            end

        event.target.text = ""
     end
end


---------------------------------------------------------------------
-- OBJECT CREATION
---------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view


-- Insert the background image and set it to the center of the screen
bkg_image = display.newImage("Images/Level2Screen.png")
bkg_image.x = display.contentCenterX
bkg_image.y = display.contentCenterY
bkg_image.width = display.contentWidth
bkg_image.height = display.contentHeight

-- create you win screen
youWin = display.newImage("Images/YouWinScreen.png")
youWin.x = display.contentCenterX
youWin.y = display.contentCenterY
youWin.width = display.contentWidth
youWin.height = display.contentHeight
youWin.isVisible = false


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


-- create you lose screen
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



end --function scene:create( event )


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
        AskQuestion()

        -- play audio
        Level2SoundChannel = audio.play(Level2Sound,{ loops = -1 }) 

        -- initialize the number of lives and number correct 
        lives = 3
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

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
     -- Called immediately after scene goes off screen.
     -- Stop audio
        audio.stop (Level2SoundChannel)
        audio.stop(GameOverSoundChannel)
        audio.stop(youwinSoundChannel)
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