WINDOW_WIDTH = 600
WINDOW_HEIGHT = 600

function love.load()
    -- set background
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT )

    -- load bg sprite
    bg_sprite = love.graphics.newImage('images/bg.png')

    -- load x and o sprites
    x_sprites = {}
    o_sprites = {}
    for i = 1 , 9 do
        x_sprites[i] = love.graphics.newImage('images/X' .. i .. '.png')
        o_sprites[i] = love.graphics.newImage('images/O' .. i .. '.png')
    end

    -- create player1 array
    p1arr = {}
    for i=1,9 do
        p1arr[i] = 0
    end

    -- create player2 array
    p2arr = {}
    for i=1,9 do
        p2arr[i] = 0
    end

    love.keyboard.keypressed = {}

    turn = false

    finish = false

    winner = 1

    love.graphics.setFont(love.graphics.newFont(18))

end

function love.keypressed(key)
    love.keyboard.keypressed[key] = true
end

function love.update(dt)

    if finish then
        return
    end

    for i = 1, 9 do
        if love.keyboard.keypressed['kp' .. i ] then
            if not ( i == 4 or i == 5 or i == 6 ) then
                i = (i + 6) % 12
            end

            if p1arr[i] == 0 and p2arr[i] == 0 then
                if turn then
                    p2arr[i] = 1
                else
                    p1arr[i] = 1
                end
                turn = not turn
            end
        end
    end
    
    if win( p1arr ) then
        finish = true
    elseif win( p2arr ) then
        finish = true
        winner = 2
    end

    love.keyboard.keypressed = {}

end

function love.draw()
    -- draw bg
    love.graphics.draw(bg_sprite)

    -- draw x and o
    for i = 1, 9 do
        if p1arr[i] == 1 then
            love.graphics.draw(o_sprites[i])
        end
        if p2arr[i] == 1 then
            love.graphics.draw(x_sprites[i])
        end
    end

    -- draw text
    love.graphics.setColor(0,0,0)
    if not finish then
        if turn then
            love.graphics.print("player2")
        else
            love.graphics.print("player1")
        end
    else
        if winner == 1 then
            love.graphics.print("player1 won!")
        else
            love.graphics.print("player2 won!")
        end
    end

    love.graphics.setColor(1,1,1)

end

function win( player )
    if player[1] == 1 and player[2] == 1 and player[3] == 1 then
        return true
    elseif player[4] == 1 and player[5] == 1 and player[6] == 1 then
        return true
    elseif player[7] == 1 and player[8] == 1 and player[9] == 1 then
        return true
    elseif player[1] == 1 and player[4] == 1 and player[7] == 1 then
        return true
    elseif player[2] == 1 and player[5] == 1 and player[8] == 1 then
        return true
    elseif player[3] == 1 and player[6] == 1 and player[9] == 1 then
        return true
    elseif player[3] == 1 and player[5] == 1 and player[7] == 1 then
        return true
    elseif player[1] == 1 and player[5] == 1 and player[9] == 1 then
        return true
    end

    return false
end