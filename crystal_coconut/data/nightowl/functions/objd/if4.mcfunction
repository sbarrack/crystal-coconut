# If statement from file: objd/ray1
scoreboard players set @s nightowl_query 9
bossbar set nightowl:debug color green
bossbar set nightowl:debug value 9
bossbar set nightowl:debug max 9
bossbar set nightowl:debug players @a
tellraw @s [{"text":"Sleep until nightfall?","color":"aqua","clickEvent":{"action":"run_command","value":"/function nightowl:sleep"},"hoverEvent":{"action":"show_text","value":[{"text":"Click to hit the sack...","color":"gray"}]}},{"text":" (click)","color":"gray"}]
tag @s add objd_ray_stop