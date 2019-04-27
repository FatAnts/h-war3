--为lua引擎注册你的本机路径
package.path = package.path .. ';E:\\Web\\workSpace\\hunzsigGitlab\\h-war3\\h-lua\\?.lua';
package.path = package.path .. ';E:\\Web\\workSpace\\hunzsigGitlab\\h-war3\\bossHunter\\?.lua';

--调试
console = require "jass.console"
console.enable = true

--加载hJLua
require "h-lua"

--英雄SLK系统
local heroNames = {
    "人类·全能骑士·格雷戈里",
}
hslk_global.heroesLen = #heroNames
for k, hname in ipairs(heroNames) do
    table.insert(hslk_global.heroes, cj.LoadStr(cg.hash_myslk, cj.StringHash("heros"), cj.StringHash(hname)))
    table.insert(hslk_global.heroesItems, cj.LoadStr(cg.hash_myslk, cj.StringHash("herosItems"), cj.StringHash(hname)))
end
for k, v in ipairs(hslk_global.heroes) do
    local jv = json.parse(v)
    hslk_global.heroes[k] = jv
    hslk_global.heroesKV[jv.heroID] = jv
    hslk_global.unitsKV[jv.heroID] = jv
end
for k, v in ipairs(hslk_global.heroesItems) do
    local jv = json.parse(v)
    hslk_global.heroesItems[k] = jv
    hslk_global.heroesItemsKV[jv.itemID] = jv
end

cj.TimerStart(cj.CreateTimer(), 5.00, true,
        function()
            print(hslk_global.attr)
        end
)

local preload = {};
for k, v in pairs(hslk_global.unitsKV) do
    table.insert(preload, k)
end

--预读
for k, v in ipairs(preload) do
    local u = cj.CreateUnit(hplayer.player_passive, hsystem.getObjId(v), 0, 0, 0)
    hattr.registerAll(u)
    hunit.del(u, 0.1)
    print(hunit.getAvatar(u))
end

-- 镜头模式
hcamera.setModel("zoomin")
-- 属性 - 硬直条
-- hattrUnit.punishTtgIsOpen(false)
-- hattrUnit.punishTtgIsOnlyHero(false)
-- hattrUnit.punishTtgHeight(250.00)
-- 迷雾
cj.FogEnable(true)
-- 阴影
cj.FogMaskEnable(true)
-- 开始你的游戏