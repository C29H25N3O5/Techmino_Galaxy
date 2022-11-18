return {
    initialize=function()
        GAME.newPlayer(1,'mino')
        GAME.setMain(1)
    end,
    settings={mino={
        skin='mino_interior',
        shakeness=0,
        dropDelay=1e99,
        lockDelay=1e99,
        infHold=true,
        -- spawnDelay=26,
        soundEvent={
            countDown=function(num)
                SFX.playSample('lead',num>0 and 'A3' or 'A4')
            end,
        },
        event={
            -- Display ghost at not-bad places to help new players learn stacking
            always=function(P)
                P.modeData.waitTime=P.modeData.waitTime+1
            end,
            afterResetPos=function(P)
                local field=P.field:export_table_simp()
                local m=P.hand.matrix
                local shape={}
                for y=1,#m do
                    shape[y]={}
                    for x=1,#m[y] do
                        shape[y][x]=m[y][x] and true or false
                    end
                end
                local x,y,dir=AI.retard.findPosition(field,shape)
                P.modeData.x,P.modeData.y,P.modeData.shape=x,y,TABLE.rotate(shape,dir)
                P.modeData.waitTime=0
                -- if dir~='0' then P:rotate(dir) end
                -- P.handX,P.handY,P.ghostY=P.modeData.x,P.modeData.y,P.modeData.y
                -- P:minoDropped()
            end,
            drawBelowMarks=function(P)
                local m=P.modeData.shape
                if type(m)=='table' then
                    GC.setColor(1,1,1,.26*(math.min(P.modeData.waitTime/62,1)-math.cos(P.modeData.waitTime*.012)))
                    GC.setLineWidth(6)
                    for y=1,#m do for x=1,#m[1] do
                        local C=m[y][x]
                        if C then
                            GC.rectangle('line',(P.modeData.x+x-2)*40+5,-(P.modeData.y+y-1)*40+5,30,30)
                        end
                    end end
                end
            end
        },
    }},
}
