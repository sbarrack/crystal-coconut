execute if score @s nightowl_sleep <= #nightowl zero if score @s nightowl_query > #nightowl zero run tag @p add objd_isTrue1
execute as @p if entity @s[tag=objd_isTrue1] run function nightowl:objd/if1
execute as @p unless entity @s[tag=objd_isTrue1] run playsound minecraft:entity.donkey.angry master @s ~ ~ ~ 1 1
execute as @p unless entity @s[tag=objd_isTrue1] run tellraw @s [{"text":"You are not at a bed or 10 minutes (12 game hours) have not passed!","color":"red"}]
tag @p remove objd_isTrue1