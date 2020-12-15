
execute if data storage nightowl enabled run tag #nightowl add enabled
execute as @p if entity @s[tag=objd_isTrue] run data merge storage nightowl:store {enabled:1b}
execute as @p if entity @s[tag=objd_isTrue] run function nightowl:timers/timer
execute as @p if entity @s[tag=objd_isTrue] run scoreboard players set #nightowl nightowl_enabled 1
execute as @p unless entity @s[tag=objd_isTrue] run data merge storage nightowl:store {enabled:0b}
execute as @p unless entity @s[tag=objd_isTrue] run tag @a add objd_timer
execute as @p unless entity @s[tag=objd_isTrue] run scoreboard players set #nightowl nightowl_enabled 0
tag @p remove objd_isTrue