-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local vampire
local vampireWaving
local bkgSound = audio.loadSound( "Sounds/CreepySound.mp3" )
local bkgSoundChannel
--------------------------------------------------------------------------------------------
--GLOBAL FUNCTIONS
--------------------------------------------------------------------------------------------

function DisplayVampireWaving()
    -- made vampire waving visible
    vampireWaving.isVisible = true
    -- made vampire visible
    vampire.isVisible = false
    -- called the display vampire function
    timer.performWithDelay(500, DisplayVampire)
    -- made vampire fade out
    vampireWaving.alpha = vampire.alpha - 0.17
end

function DisplayVampire()
    -- made vampire visible
    vampire.isVisible = true
    -- made vampire waving invisible
    vampireWaving.isVisible = false
    -- called the function display vampire waving
    timer.performWithDelay(500, DisplayVampireWaving)
    -- shrunk the vampire
    vampire.alpha = vampire.alpha - 0.17
end


-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "splash_screen2" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------



-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the vampire image
    vampireWaving = display.newImage("Images/VampireWaving.PNG")


    -- set the initial x and y position of the vampire
    vampireWaving.y = display.contentHeight/2
    vampireWaving.x = display.contentWidth/2
    vampireWaving.height = display.contentHeight
    vampireWaving.width = display.contentWidth
    vampireWaving.isVisible = false

    -- Insert the vampire image
    vampire = display.newImage("Images/Vampire.PNG")


    -- set the initial x and y position of the waving vampire
    vampire.x = display.contentWidth/2
    vampire.y = display.contentHeight/2
    vampire.height = display.contentHeight
    vampire.width =  display.contentWidth
    vampire.isVisible = false


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( vampire )
    sceneGroup:insert( vampireWaving )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        bkgSoundChannel = audio.play(bkgSound)

        -- Call the DisplayVampire function as soon as we enter the frame.
        DisplayVampire()
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the creepy channel for this screen
        audio.stop(bkgSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
