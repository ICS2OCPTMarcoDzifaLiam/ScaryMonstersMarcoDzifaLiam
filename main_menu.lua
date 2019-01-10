-----------------------------------------------------------------------------------------
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

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
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton
local muteButton
local unMuteButton
local audioMuted

-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

local MainMenuSound = audio.loadSound("Sounds/MainMenu.mp3") -- setting a variable to an mp3 file
local MainMenuSoundChannel 

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function PauseAudio(touch)    
    if (touch.phase == "ended") then
        audio.pause(MainMenuSound)
        audioMuted = true
        muteButton.isVisible = false
        unMuteButton.isVisible = true        
    end 
end

local function PlayAudio(touch)    
    if (touch.phase == "ended") then
        audio.play(MainMenuSound)
        audioMuted = false
        muteButton.isVisible = true
        unMuteButton.isVisible = false        
    end 
end

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "flipFadeOutIn", time = 500})
end 

local function InstructionsTransition( )       
    composer.gotoScene( "instructions_screen", {effect = "flipFadeOutIn", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOutFade", time = 1000})
end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuDzifaA@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,
            width = 250,
            height = 200,

            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressedMarcoS.png",
            overFile = "Images/PlayButtonPressedMarcoSterlini.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition 
        } )

    muteButton = display.newImage("Images/MuteButtonUnPressedMarcoS@2x.png")
    muteButton.x = display.contentWidth*7/8
    muteButton.y = display.contentHeight*1/8
    muteButton.width = 250
    muteButton.height = 200
    muteButton.isVisible = true

    unMuteButton = display.newImage("Images/MuteButtonPressedMarcoS@2x.png")
    unMuteButton.x = display.contentWidth*7/8
    unMuteButton.y = display.contentHeight*1/8
    unMuteButton.width = 250
    unMuteButton.height = 200
    unMuteButton.isVisible = false

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,
            width = 200,
            height = 200,
            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedDzifaA@2x.png",
            overFile = "Images/CreditsButtonPressedDzifaA@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,
            width = 200,
            height = 200,
            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedDzifaAgbenyoh@2x.png",
            overFile = "Images/InstructionsButtonPressedDzifaAgbenyoh@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 
    -- ADD INSTRUCTIONS BUTTON WIDGET

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unMuteButton )
    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

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
        audioMuted = false

        -- play audio
        MainMenuSoundChannel = audio.play(MainMenuSound,{ loops = -1 })   

        -- play audio
        muteButton:addEventListener("touch", PauseAudio)
        unMuteButton:addEventListener("touch", PlayAudio)
           
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
        audio.stop (MainMenuSoundChannel)
        muteButton:removeEventListener("touch", PauseAudio)
        unMuteButton:removeEventListener("touch", PlayAudio)
    end

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
