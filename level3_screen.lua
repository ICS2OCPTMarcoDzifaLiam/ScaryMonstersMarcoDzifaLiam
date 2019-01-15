-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------
local Level1ScreenSound = audio.loadSound("Sounds/Level1.mp3") -- setting a variable to an mp3 file
local Level1ScreenSoundChannel 

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level3_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local rArrow 
local uArrow
local lArrow

local questionsAnswered = 0

local character1
local character2
local character3
local theCharacter

local youWin

local spikes1
local spikes2
local spikes3

local correctObject
local incorrectObject

local door

local platform2
local platform3
local platform4

local spikesPoints1 = 0
local spikesPoints2 = 0
local spikesPoints3 = 0

local leftW
local rightW 
local topW
local floor

local motionx = 0
local SPEED = 6
local nSPEED = -6
local LINEAR_VELOCITY = -225
local GRAVITY = 1

---------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------

-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    monster.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (monster ~= nil) then
        monster:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

local function left (touch)
    motionx = nSPEED
    monster.xScale = -1
end

-- Move monster horizontally
local function movePlayer (event)
    monster.x = monster.x + motionx
end
 
-- Stop monster movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end


local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end
local function ReplaceMonster()
    monster = display.newImageRect("Images/Monster1.png", 100, 150)
    monster.x = display.contentWidth * 0.5 / 8
    monster.y = display.contentHeight  * 0.1 / 3
    monster.width = 75
    monster.height = 100
    monster.myName = "KickyKat"

    -- intialize horizontal movement of monster
    motionx = 0

    -- add physics body
    physics.addBody( monster, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent monster from being able to tip over
    monster.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end
local function ShowYouWin()
    youWin.isVisible = true
end

local function HideMonster()
    monster.isVisible = false
end

local function StopMotion()
    motionx = 0

end
local function MakeSoccerBallsVisible()
    character1.isVisible = true
    character2.isVisible = true
    character3.isVisible = true

end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )
    if ( event.phase == "began" ) then
 
    
        if  (event.target.myName == "character1") or
            (event.target.myName == "character2") or
            (event.target.myName == "character3")  then


            print  ("***Hit the character")

            -- get the monster that the user hit
            theCharacter = event.target

            -- stop the monster from moving
            motionx = 0

            
            -- make the monster invisible
            monster.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level3_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            
            print ("***questionsAnswered = " .. questionsAnswered)

            
        end    

        if  (event.target.myName == "spikes1") or 
            (event.target.myName == "spikes2") or
            (event.target.myName == "spikes3") then

            print  ("***Hit the spikes")
            
                if (event.target.myName == "spikes1") then 
                    -- add a point to spikes1 
                    spikesPoints1 = spikesPoints1 + 1
                end

                if (event.target.myName == "spikes2") then
                    -- add a point to spikes2 
                    spikesPoints2 = spikesPoints2 + 1
                end

                if (event.target.myName == "spikes3") then
                    -- add a point to spikes3 
                    spikesPoints3 = spikesPoints3 + 1
                end
            

            if  (spikesPoints1 == 1) or
                (spikesPoints2 == 1) or
                (spikesPoints3 == 1) then

                -- stop the monster from moving
                motionx = 0

                -- make the monster invisible
                monster.isVisible = false

                -- show overlay with math question
                composer.showOverlay( "level3_question2", { isModal = true, effect = "fade", time = 100})

                
                print ("***questionsAnswered = " .. questionsAnswered)
            end  
        end   
     
    end        
end

local function DisplayCharecter()
    monster.isVisible = true
end

local function AddCollisionListeners()
    -- if monster collides with ball, onCollision will be called
    spikes1.collision = onCollision
    spikes1:addEventListener( "collision" )
    spikes2.collision = onCollision
    spikes2:addEventListener( "collision" )
    spikes3.collision = onCollision
    spikes3:addEventListener( "collision" )

    -- if monster collides with character, onCollision will be called    
    character1.collision = onCollision
    character1:addEventListener( "collision" )
    character2.collision = onCollision
    character2:addEventListener( "collision" )
    character3.collision = onCollision
    character3:addEventListener( "collision" )

    --door.collision = onCollision
    --door:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    spikes1:removeEventListener( "collision" )
    spikes2:removeEventListener( "collision" )
    spikes3:removeEventListener( "collision" )

    character1:removeEventListener( "collision" )
    character2:removeEventListener( "collision" )
    character3:removeEventListener( "collision" )

    --door:removeEventListener( "collision")
end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( spikes1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( spikes2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( spikes3, "static", { density=1.0, friction=0.3, bounce=0.2 } )    

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody( platform2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform4, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(character1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(character2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(character3, "static",  {density=0, friction=0, bounce=0} )

    --physics.addBody(door, "static", {density=1, friction=0.3, bounce=0.2})
end

local function RemovePhysicsBodies()
    physics.removeBody(platform2)
    physics.removeBody(platform3) 
    physics.removeBody(platform4)

    physics.removeBody(spikes1)
    physics.removeBody(spikes2)
    physics.removeBody(spikes3)

    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
 
end

local function HideCorrect()
    correctObject.isVisible = false
end

-- hide incorrect answer
local function HideIncorrect()
    incorrectObject.isVisible = false
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------


function ResumeLevel3(answerIsCorrect)

    if (answerIsCorrect == true) then
        correctObject.isVisible = true
        --correctSoundChannel = audio.play(correctSound)
        timer.performWithDelay(2000, HideCorrect)
    else
        incorrectObject.isVisible = true
        --incorrectSoundChannel = audio.play(incorrectSound)
        --event.target.text = ""
        timer.performWithDelay(2000, HideIncorrect)
    end 
    
    questionsAnswered = questionsAnswered + 1
    -- make the monster visible again
    monster.isVisible = true

    if (questionsAnswered == 3) then
        -- make you win visible
        timer.performWithDelay(1000, ShowYouWin)         

        -- hide correct
        timer.performWithDelay(1000, HideIncorrect)

        -- hide incorrect
        timer.performWithDelay(1000, HideCorrect)         
            
        -- make the monster invisible
        timer.performWithDelay(1000, HideMonster)

        -- stop motion
        timer.performWithDelay(1000, StopMotion)
    end
    if (questionsAnswered > 0) then
        if (theCharacter ~= nil) and (theCharacter.isBodyActive == true) then
            -- remove the physics on the charecter
            physics.removeBody(theCharacter)
            -- show the charecter
            theCharacter.isVisible = false
        end
    end

end

function ResumeLevel32(answerIsCorrect)

    if (answerIsCorrect == true) then
        -- show the correct object 
        correctObject.isVisible = true
        --correctSoundChannel = audio.play(correctSound)
        timer.performWithDelay(2000, HideCorrect)
    else
        incorrectObject.isVisible = true
        --incorrectSoundChannel = audio.play(incorrectSound)
        --event.target.text = ""
        timer.performWithDelay(2000, HideIncorrect)
    end 
    
    -- make the monster visible again
    monster.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theCharacter ~= nil) and (theCharacter.isBodyActive == true) then
            -- remove the physics from the charecter
            physics.removeBody(theCharacter)
            --show the charecter
            theCharacter.isVisible = false
        end
    end

end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/level3screenMarco.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    sceneGroup:insert( bkg_image )  

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
    sceneGroup:insert( rArrow) 

    --Insert the left arrow and up arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10
    sceneGroup:insert( uArrow)

    youWin = display.newImage("Images/YouWinScreen.png")
    youWin.x = display.contentCenterX
    youWin.y = display.contentCenterY
    youWin.width = display.contentWidth
    youWin.height = display.contentHeight
    youWin.isVisible = false

    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10
    sceneGroup:insert( lArrow)

    -- Inserting Platforms

    platform2 = display.newImageRect("Images/Platform.png", 180, 50)
    platform2.x = display.contentWidth /2.1
    platform2.y = display.contentHeight * 1.2 / 4
        
    sceneGroup:insert( platform2 )

    platform3 = display.newImageRect("Images/Platform.png", 180, 50)
    platform3.x = display.contentWidth *1 / 5
    platform3.y = display.contentHeight * 2.5 / 5
        
    sceneGroup:insert( platform3 )

    platform4 = display.newImageRect("Images/Platform.png", 180, 50)
    platform4.x = display.contentWidth *4.1 / 5
    platform4.y = display.contentHeight * 2.7 / 5
        
    sceneGroup:insert( platform4 )

    spikes1 = display.newImageRect("Images/Spikes.png", 50, 200)
    spikes1.x = display.contentWidth * 2.7 / 8
    spikes1.y = display.contentHeight * 1.8 / 5
    spikes1.myName = "spikes1"
        
    sceneGroup:insert( spikes1)

    spikes2 = display.newImageRect("Images/Spike2.png", 300, 50)
    spikes2.x = display.contentWidth * 5 / 8
    spikes2.y = display.contentHeight * 2.7 / 5
    spikes2.myName = "spikes2"
        
    sceneGroup:insert( spikes2)


    spikes3 = display.newImageRect("Images/Spike3.png", 300, 50)
    spikes3.x = display.contentWidth * 5.5 / 8
    spikes3.y = display.contentHeight * 0.4 / 5
    spikes3.myName = "spikes3"
        
    sceneGroup:insert( spikes3)


    --door = display.newImage("Images/Level-1Door.png", 200, 200)
    --door.x = display.contentWidth/2.15 
    --door.y = display.contentHeight* 1 / 1.9
    --door.myName = "door"
    --door.isVisible = false
--
    --sceneGroup:insert( door )
    -- Inserting left and right walls and there visibility
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Level-1Floor.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    -- Insert objects into the scene group in order to ONLY be associated with this scene
        -- create the correct text object and make it invisible
    correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/4, nil, 50)
    correctObject:setTextColor(200/255, 0/255, 0/255)
    correctObject.isVisible = false
    
    -- create the incorrect text object and make it invisible
    incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/4, nil, 50)
    incorrectObject:setTextColor(0/255, 0/255, 200/255)
    incorrectObject.isVisible = false
    --charecter1
    character1 = display.newImageRect ("Images/Character1.png", 70, 70)
    character1.x = 840
    character1.y = 355
    character1.myName = "character1"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( character1 )

    --character2
    character2 = display.newImageRect ("Images/Character2.png", 70, 70)
    character2.x = 490
    character2.y = 170
    character2.myName = "character2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( character2 )

    character3 = display.newImageRect ("Images/Character3.png", 70, 70)
    character3.x = 200
    character3.y = 325
    character3.myName = "character3"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( character3 )            

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
        
        Level1ScreenSoundChannel = audio.play(Level1ScreenSound)

        AddPhysicsBodies()
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        ReplaceMonster()
        AddCollisionListeners()
    end

end --function scene:show( event )

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
        RemoveArrowEventListeners()
        RemoveCollisionListeners()
        audio.stop(Level1Screen)
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
