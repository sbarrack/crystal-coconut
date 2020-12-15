advancement revoke @a only nightowl:try
execute if predicate nightowl:can_sleep run tellraw @s {"text": "Sweet dreams...","color": "blue"}
execute if predicate nightowl:can_sleep run time set 12542
execute if predicate nightowl:can_sleep run weather clear
