# If statement from file: sleep
scoreboard players set @a nightowl_query 1
scoreboard players set @a nightowl_sleep 600
bossbar set nightowl:debug color green
bossbar set nightowl:debug value 9
bossbar set nightowl:debug max 9
bossbar set nightowl:debug players @a
time set 12000
particle minecraft:poof ~ ~ ~ 2 1 2 0.5 50 normal
execute as @s at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.2