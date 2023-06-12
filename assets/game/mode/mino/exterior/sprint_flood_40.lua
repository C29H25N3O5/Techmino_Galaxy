return {
    initialize=function()
        GAME.newPlayer(1,'mino')
        GAME.setMain(1)
        playBgm('race','base')
    end,
    settings={mino={
        seqType='bag7_flood',
        event={
            playerInit={
                mechLib.mino.statistics.event_playerInit,
                "P:addEvent('afterClear',mechLib.mino.progress.sprint_flood_40_afterClear)",
            },
            afterClear={
                mechLib.mino.statistics.event_afterClear,
                mechLib.mino.sprint.event_afterClear[40],
            },
            drawInField=mechLib.mino.sprint.event_drawInField[40],
            drawOnPlayer=mechLib.mino.sprint.event_drawOnPlayer[40],
        },
    }},
}
