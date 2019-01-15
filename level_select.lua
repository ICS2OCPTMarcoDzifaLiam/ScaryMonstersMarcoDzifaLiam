-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level_select"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local level1Button
local level2Button
local level3Button
-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

local levelselectSound = audio.loadSound("Sounds/levelselectsound.mp3") -- setting a variable to an mp3 file
local levelselectSoundChannel 
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "flipFadeOutIn", time = 1000})
end    

-- Creating Transition to Level1 Screen
local function Level2ScreenTransition( )
    composer.gotoScene( "level2_screen", {effect = "zoomInOutFade", time = 1000})
end    

-- Creating Transition to Level1 Screen
local function Level3ScreenTransition( )
    composer.gotoScene( "level3_screen", {effect = "zoomInOutFade", time = 1000})
end    

----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- BACKGROUND IMAGE 
----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/RainbowBackground@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- BUTTON WIDGETS
-----------------------------------------------------------------------------------------   

    -- Creating level 1 Button
    level1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,
            width = 250,
            height = 200,

            -- Insert the images here
            defaultFile = "Images/level1.png",
            overFile = "Images/level1.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition 
        } )

    -- Creating level2 Button
   level2Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,
            width = 200,
            height = 200,
            -- Insert the images here
            defaultFile = "Images/level2.png",
            overFile = "Images/level2.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level2ScreenTransition
        } )

      -- Creating level3 Button
  level3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,
            width = 200,
            height = 200,
            -- Insert the images here
            defaultFile = "Images/level3.png",
            overFile = "Images/level3.png",

            -- When the button is released, call the Credits transition function
            onRelease = Level3ScreenTransition
        } )
------------------------------------------------------------------------------
------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( level1Button)
    sceneGroup:insert( level2Button )
    sceneGroup:insert( level3Button )

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then 
     

        -- play audio
      levelselectSoundChannel = audio.play(levelselectSound,{ loops = -1 })   

           
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

   
    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        audio.stop (levelselectSound)
       

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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






