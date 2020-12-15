data merge storage nightowl {enabled:1b}
advancement grant @a only nightowl:enabled
scoreboard objectives add nightowl_sleep dummy
scoreboard objectives add nightowl_query dummy
schedule function nightowl:loop 1s
