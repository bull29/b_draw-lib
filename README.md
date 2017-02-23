# Bull's neat little drawing library
Ever wanted to draw textures/materials from the internet rather than vtfs/hardmounted pngs?
Me too. 

# Current functions: 
Draw a webimage from a url in an identical fashion to draw.RoundedBox. Optional angle argument. be warned, angled textures have a different offset than straight ones, unless cornerorigin is set to true. (Leave cornerorigin set to true if you don't know what i'm talking about)

`draw.WebImage( url, x, y, width, height, color=Color(255,255,255), angle=0, cornerorigin=false )`

Draw a steam user's avatar; sizes are "large", "medium", "small"

`draw.SteamAvatar( string steamID64, string size = "small", x, y, width, height, color=Color(255,255,255) )`

