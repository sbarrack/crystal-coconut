execute if score @s nightowl_sleep > #nightowl zero run tag @p add objd_isTrue2
execute as @p if entity @s[tag=objd_isTrue2] run function nightowl:objd/if2
execute as @p unless entity @s[tag=objd_isTrue2] run execute if score @s nightowl_query > #nightowl zero run tag @p add objd_isTrue3
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p if entity @s[tag=objd_isTrue3] run function nightowl:objd/if3
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute if block ~ ~ ~ #minecraft:beds run tag @p add objd_isTrue4
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute as @p if entity @s[tag=objd_isTrue4] run function nightowl:objd/if4
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute as @p unless entity @s[tag=objd_isTrue4] run execute unless block ~ ~ ~ minecraft:air run tag @p add objd_isTrue5
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute as @p unless entity @s[tag=objd_isTrue4] run execute unless entity @s[distance=0..4] run tag @p add objd_isTrue5
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute as @p unless entity @s[tag=objd_isTrue4] run execute as @p if entity @s[tag=objd_isTrue5] run tag @s add objd_ray_stop
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run execute as @p unless entity @s[tag=objd_isTrue4] run tag @p remove objd_isTrue5
execute as @p unless entity @s[tag=objd_isTrue2] run execute as @p unless entity @s[tag=objd_isTrue3] run tag @p remove objd_isTrue4
execute as @p unless entity @s[tag=objd_isTrue2] run tag @p remove objd_isTrue3
tag @p remove objd_isTrue2
execute unless block ~ ~ ~ minecraft:air run tag @s add objd_ray_hit
execute unless entity @s[tag=objd_ray_hit] unless entity @s[tag=objd_ray_stop] positioned ^ ^ ^1 run function nightowl:objd/ray1
execute if entity @s[tag=objd_ray_hit] unless entity @s[tag=objd_ray_stop] run function nightowl:objd/rayhit1
execute if entity @s[tag=objd_ray_hit] run tag @s remove objd_ray_hit
tag @s remove objd_ray_stop