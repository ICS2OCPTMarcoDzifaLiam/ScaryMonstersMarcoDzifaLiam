-----------------------------------------------------------------------------------------
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
sceneName = "splash_screen2"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

--------------------------------------------------------------------------------------------
-- SOUNDS
--------------------------------------------------------------------------------------------

-- make a evil sound
local evil = audio.loadSound("Sound/evil.mp3")
local evilSoundChannel 

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local vampire
local Monsterfun
local backgroundImage


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that will go to the main menu 
local function gotoMainMenu()
    
    composer.gotoScene( "main_menu" )
end


-- The function called when the scene is issued to appear on screen
-- Function: MoveVampire
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the Vampire
local function MoveVampire(event)

    -- add the scroll speed to the x-value of the vampire
    vampire.x = vampire.x + scrollSpeed


    -- change the transparency of the vampire every time it moves
    -- so that it fades out.
    vampire.alpha = vampire.alpha - 0.00000000000001
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- create background
    local backgroundImage = display.newImageRect("Images/RainbowBackground@2x.png", 2048, 1536)

-- create vampire
    local vampire = display.newImageRect("Images/vampire.png", 300, 200)

-- ceate monster fun text
    local Monsterfun = display.newImageRect("Images/Monsterfun.png", 300, 200)

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view


    -- set the initial x and y position of vampire.
   vampire.x = 500
   vampire.y = display.contentHeight/2

  -- set the initial x and y position of monsterfun.
   Monsterfun.x = 500
   Monsterfun.y = display.contentHeight/5


   -- Insert objects into the scene group in order to ONLY be associated with this scene
   sceneGroup:insert( vampire )
   sceneGroup:insert( Monsterfun )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------


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
        evilSoundChannel = audio.play(evil)

    
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        


    end --function scene:show( event )
 end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )
    audio.stop(bkgSoundChannel)

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


