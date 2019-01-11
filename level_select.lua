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
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local level1
local level2
local level3

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

-- Creating a group that associates objects with the scene
local sceneGroup = self.view

-----------------------------------------------------------------------------------------

local function level1ScreenTransition( )        
    composer.gotoScene( "level1_screen", {effect = "zoomInOutFade", time = 1000})
end 

local function level2ScreenTransition( )        
    composer.gotoScene( "level2_screen", {effect = "zoomInOutFade", time = 1000})
end 

local function level3ScreenTransition( )        
    composer.gotoScene( "level3_screen", {effect = "zoomInOutFade", time = 1000})
end 


-- create level1, set its position and make it visible
local level1 = display.newImageRect("Images/level1.png", 198, 96)
level1.x = display.contentWidth/2
level1.y = display.contentHeight/2
level1.isVisible = true

-- create level2, set its position and make it visible
local level2 = display.newImageRect("Images/level2.png", 198, 96)
level2.x = display.contentWidth/2
level2.y = display.contentHeight/2
level2.isVisible = true

-- create level3, set its position and make it visible
local level3 = display.newImageRect("Images/level3.png", 198, 96)
level3.x = display.contentWidth/2
level3.y = display.contentHeight/2
level3.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(level1_screen) 
    sceneGroup:insert(level2_screen)  
    sceneGroup:insert(level3_screen)         

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        physics.start()
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
         Level1SoundChannel = audio.play(Level1Sound,{ loops = -1 })

        AddPhysicsBodies()
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        ReplaceCharacter()
        AddCollisionListeners()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )
 audio.stop(Level1Sound)
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
        RemoveArrowEventListeners()
        RemoveCollisionListeners()
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

---------------------------------------------------------------------------------------------



