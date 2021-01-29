advancement revoke @a only nightowl:try
execute if predicate nightowl:can_sleep run tellraw @a {"text":"§9Sweet daydreams ","extra":[{"selector": "@p","color":"gray"},{"text":"§9..."}]}
execute if predicate nightowl:can_sleep run time set 12040
execute if predicate nightowl:can_sleep run weather clear
