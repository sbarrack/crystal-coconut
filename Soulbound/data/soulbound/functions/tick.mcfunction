scoreboard objectives add sb_deaths deathCount
scoreboard objectives add sb_debt dummy
scoreboard objectives add sb_calc dummy
scoreboard objectives add sb_single dummy
scoreboard objectives add sb_multiple dummy
scoreboard players set #cc sb_single 40
scoreboard players set #cc sb_multiple 1

execute as @a[scores={sb_debt=1..}] run xp add @s -1 points
execute as @a[scores={sb_debt=1..}] run scoreboard players remove @s sb_debt 1

scoreboard players set @a sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:single 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_calc *= #cc sb_single
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc
scoreboard players set @a sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:multiple 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_calc *= #cc sb_multiple
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc

# TODO create predicates for each inventory slot being not soulbound and then execute if predicate replaceitem with air

scoreboard players set @a sb_deaths 0
