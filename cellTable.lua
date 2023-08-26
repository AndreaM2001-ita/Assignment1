
local composer=require("composer")
local widget=require("widget")

local scene=composer.newScene();


--colors of scene
local deadCellColor={1,1,1}   --WHITE
local aliveCellColor={0,0,0} --BLACK   
local CellBorderColor={0.502,0.502,0.502}


local width=display.actualContentWidth
local height=display.actualContentHeight

local cellNumber=5   --number of cells er side

function setColor(state)
    if state==0 then
        return unpack(deadCellColor)
    else 
        return unpack(aliveCellColor)
    end
end

function makeButton(x,y,cellSide,state)
    
    -- Create a rectangle as the background of the button
    local button = display.newRect( x, y, cellSide, cellSide)
    button.strokeWidth = 5
    button:setStrokeColor(unpack(CellBorderColor))
    button:setFillColor(setColor(state)) -- Set the background color based on state
    

       
    return button
end


local function divideBackground(sceneGroup,rectWidth)

    local cellSide=rectWidth/cellNumber
    local zeroX=width/14+cellSide/2
    local zeroY=(height/3)-(6*width)/14+cellSide/2

    local grid={}
    local x=0
    for i= zeroX,zeroX*cellNumber+zeroX, cellSide do
        local y=0
        grid[x]={}
        for j=zeroY,(zeroY*cellNumber+zeroY)/2, cellSide do   
            local cell
            if x==2 and y>0 and y<4 then 
                cell=makeButton(i,j,cellSide,1)
            else 
                cell=makeButton(i,j,cellSide,0)
            end
            sceneGroup:insert(cell)
            grid[x][y]=cell.id

            y=y+1
        end
        x=x+1
    end

end

function scene:create(event)
    local sceneGroup=self.view

    local x=width/2
    local y=height/3

    local rectWidth=width-width/7

    local background=display.newRect(x,y,rectWidth,rectWidth) --creating backgroud
    sceneGroup:insert(background)

    divideBackground(sceneGroup,rectWidth)

end



scene:addEventListener("create",scene)

return scene
