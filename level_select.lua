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

 -- sets the background colour
 display.setDefault("background", 204/255, 230/255, 255/255) 
---------------------------------------------------------------------------------------------
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

  -- Display background
   you_lose = display.newImageRect("Images/you_lose.png", display.contentWidth, display.contentHeight)
   you_lose.anchorX = 0
   you_lose.anchorY = 0
   you_lose.isVisible = false

local function level1ScreenTransition( )        
    composer.gotoScene( "level1", {effect = "zoomInOutFade", time = 1000})
end 

local function level2ScreenTransition( )        
    composer.gotoScene( "level2", {effect = "zoomInOutFade", time = 1000})
end 

local function level3ScreenTransition( )        
    composer.gotoScene( "level3", {effect = "zoomInOutFade", time = 1000})
end 
