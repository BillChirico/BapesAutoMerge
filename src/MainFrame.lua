-- Author      : Bill Chirico
-- Create Date : 1/31/2023 12:35:04 AM


function MainFrame_OnLoad()
	
end

function MainFrame_OnEvent(self, event, ...)
	if(event == "WORLD_MAP_OPEN") then
		message("Open!")
	end
end

function SecureCmdUseItem(name, bag, slot, target)
	if ( bag ) then
		C_Container.UseContainerItem(bag, slot, target);
	elseif ( slot ) then
		UseInventoryItem(slot, target);
	else
		UseItemByName(name, target);
	end
end
