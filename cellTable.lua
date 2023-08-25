
local composer=require("composer")
local widget=require("widget")

local scene=composer.newScene();


--colors of scene
local backgroundColor = {1,1,1}

local aliveCellColor={default={1,1,1,1}}
local aliveCellBorderColor={default={0,0,0,1}}


local width=display.actualContentWidth
local height=display.actualContentHeight

local cellNumber=5   --number of cells er side

local function changeState(event)
    local state=event.target.id
    if state==1 then state=0
    else state=1
    end
end

function makeButton(x,y,cellSide)
    button= widget.newButton({
        id=1,
        onRelease=changeState,
        shape = "Rect",
        x=x,
        y=y,
        width = cellSide,
		height = cellSide,
        fillColor=aliveCellColor,
        strokeColor = aliveCellBorderColor,
		strokeWidth = 5
    }
    );
    return button
end


local function divideBackground(sceneGroup,rectWidth)

    local cellSide=rectWidth/cellNumber
    local zeroX=width/14+cellSide/2
    local zeroY=(height/3)-(6*width)/14+cellSide/2

    local grid={}
    local x=0
    
    for j=zeroY,(zeroY*cellNumber+zeroY)/2, cellSide do
        local y=0
        grid[x]={}
        for i= zeroX,zeroX*cellNumber+zeroX, cellSide do

            local cell=makeButton(i,j,cellSide)
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
    background:setFillColor(unpack(backgroundColor))
    sceneGroup:insert(background)

    divideBackground(sceneGroup,rectWidth)

end



scene:addEventListener("create",scene)

return scene
