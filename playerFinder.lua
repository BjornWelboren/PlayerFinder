script_name("PlayerFinder")
script_author("6jorn_")
script_dependencies("SAMPFUNCS", "SAMP")

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do
	wait(400)
  end
  sampAddChatMessage("playerFinder.lua scripted by Bjorn initialised!", 0xFF0000)
  sampRegisterChatCommand("vind",cmd)
  sampSetClientCommandDescription("vind", "vind een speler /vind [playerId]")
  wait(-1)
end
	
function cmd(arg)
	if #arg > 0 then
		local id = tonumber(arg)

		if sampIsPlayerConnected(id) then
			result, posX, posY, posZ = sampGetStreamedOutPlayerPos(id)
			if result then
				marker(posX, posY, posZ)
			else
				result, handle = sampGetCharHandleBySampPlayerId(id)
				if result then --and doesCharExist(id) 
					posX, posY, posZ = getCharCoordinates(handle)
					marker(posX, posY, posZ)
				end
			end
		else
			sampAddChatMessage(string.format(sampGetPlayerNickname(id),"not connected"),0xFF0000)
		end
	else
		sampAddChatMessage(string.format("Gebruik het zo: /vind [playerId]"),0x00DD00)
	end
end

function marker(posX,posY,posZ)
	removeBlip(checkpoint)
	checkpoint = addBlipForCoord(posX,posY,posZ)
	changeBlipColour(checkpoint, 4)
	setCoordBlipAppearance(checkpoint, 1)
end



		

