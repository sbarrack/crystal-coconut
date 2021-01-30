gamerule keepInventory true
scoreboard objectives add sb_deaths deathCount
scoreboard objectives add sb_debt dummy
scoreboard objectives add sb_calc dummy
scoreboard objectives add sb_single dummy
scoreboard objectives add sb_multiple dummy
scoreboard players set #cc sb_single 40
scoreboard players set #cc sb_multiple 2
scoreboard players set #cc sb_zero 0

# subtract xp every tick if there is debt
scoreboard players set @a sb_calc 0
execute as @a[scores={sb_debt=1..}] store result score @s sb_calc run xp query @s points
execute as @a[scores={sb_debt=1..,sb_calc=..0}] store result score @s sb_calc run xp query @s levels
execute as @a[scores={sb_debt=1..,sb_calc=1..}] run xp add @s -1 points
execute as @a[scores={sb_debt=1..,sb_calc=1..}] run scoreboard players remove @s sb_debt 1

# if died then add debt
scoreboard players set @a sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:single 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_calc *= #cc sb_single
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc
scoreboard players set @a sb_calc 0
execute as @a unless score @s sb_deaths matches 0 store result score @s sb_calc run clear @s #soulbound:multiple 0
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_calc *= #cc sb_multiple
execute as @a unless score @s sb_deaths matches 0 run scoreboard players operation @s sb_debt += @s sb_calc

# if not soulbound then replace item
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:feet run replaceitem entity @s armor.feet air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:legs run replaceitem entity @s armor.legs air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:chest run replaceitem entity @s armor.chest air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:head run replaceitem entity @s armor.head air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:offhand run replaceitem entity @s weapon.offhand air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar0 run replaceitem entity @s hotbar.0 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar1 run replaceitem entity @s hotbar.1 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar2 run replaceitem entity @s hotbar.2 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar3 run replaceitem entity @s hotbar.3 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar4 run replaceitem entity @s hotbar.4 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar5 run replaceitem entity @s hotbar.5 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar6 run replaceitem entity @s hotbar.6 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar7 run replaceitem entity @s hotbar.7 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:hotbar8 run replaceitem entity @s hotbar.8 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory0 run replaceitem entity @s inventory.0 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory1 run replaceitem entity @s inventory.1 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory2 run replaceitem entity @s inventory.2 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory3 run replaceitem entity @s inventory.3 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory4 run replaceitem entity @s inventory.4 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory5 run replaceitem entity @s inventory.5 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory6 run replaceitem entity @s inventory.6 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory7 run replaceitem entity @s inventory.7 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory8 run replaceitem entity @s inventory.8 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory9 run replaceitem entity @s inventory.9 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory10 run replaceitem entity @s inventory.10 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory11 run replaceitem entity @s inventory.11 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory12 run replaceitem entity @s inventory.12 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory13 run replaceitem entity @s inventory.13 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory14 run replaceitem entity @s inventory.14 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory15 run replaceitem entity @s inventory.15 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory16 run replaceitem entity @s inventory.16 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory17 run replaceitem entity @s inventory.17 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory18 run replaceitem entity @s inventory.18 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory19 run replaceitem entity @s inventory.19 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory20 run replaceitem entity @s inventory.20 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory21 run replaceitem entity @s inventory.21 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory22 run replaceitem entity @s inventory.22 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory23 run replaceitem entity @s inventory.23 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory24 run replaceitem entity @s inventory.24 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory25 run replaceitem entity @s inventory.25 air
execute as @a if score @s sb_deaths > #cc sb_zero unless predicate soulbound:inventory26 run replaceitem entity @s inventory.26 air

scoreboard players set @a sb_deaths 0
