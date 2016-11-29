-- Copyright 2016 Bull [ STEAM_0:0:42437032 ]
-- Released under the MIT License

file.CreateDir("downloaded_assets")

local exists = file.Exists
local write = file.Write
local fetch = http.Fetch
local white = Color( 255, 255, 255 )
local surface = surface
local crc = util.CRC
local _error = Material("error")

local mats = {}
local fetchedavatars = {}

local function fetch_asset(url)
	if not url then return _error end

	if mats[url] then
		return mats[url]
	end

	local crc = crc(url)

	if exists("downloaded_assets/" .. crc .. ".png", "DATA") then
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png")

		return mats[url]
	end

	mats[url] = _error

	fetch(url, function(data)
		write("downloaded_assets/" .. crc .. ".png", data)
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png")
	end)

	return mats[url]
end

local function fetchAvatarAsset( id64, size )
	size = size == "medium" and "medium" or size == "small" and "" or size == "large" and "full" or ""

	if fetchedavatars[ id64 .. " " .. size ] then
		return fetchedavatars[ id64 .. " " .. size ]
	end

	http.Fetch("http://steamcommunity.com/profiles/" .. id64 .. "/?xml=1",function( body )
		local link = body:match("http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/.-jpg")
		if not link then return end

		fetchedavatars[ id64 .. " " .. size ] = link:Replace( ".jpg", ( size ~= "" and "_" .. size or "") .. ".jpg")
	end)
end

function draw.WebImage( url, x, y, width, height, color )
	color = color or white

	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.SetMaterial( fetch_asset( url ) )
	surface.DrawTexturedRect( x, y, width, height)
end

function draw.SteamAvatar( avatar, res, x, y, width, height, color )
	local url = fetchAvatarAsset( avatar, res )
	draw.WebImage( url, x, y, width, height, color )	
end

