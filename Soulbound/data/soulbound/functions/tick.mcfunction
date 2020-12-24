scoreboard objectives add sb_deaths deathCount
scoreboard objectives add sb_debt dummy
scoreboard objectives add sb_calc dummy
scoreboard objectives add sb_40 dummy
scoreboard players set #cc sb_40 40

execute as @a[scores={sb_debt=1..}] run xp add @s -1 points
execute as @a[scores={sb_debt=1..}] run scoreboard players remove @s sb_debt 1

execute as @a unless score @s sb_deaths matches 0 run scoreboard players set @s sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:multiple 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc
execute as @a unless score @s sb_deaths matches 0 run scoreboard players set @s sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:single 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_calc *= #cc sb_40
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc

# TODO clear all items (clear/replaceitem/item)? that are not #soulbound 

scoreboard players set @a sb_deaths 0
