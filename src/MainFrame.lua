local MergeItems = {
	[190322] = "Rousing Order",
	[190315] = "Rousing Earth",
	[190330] = "Rousing Decay",
	[190328] = "Rousing Frost",
	[190320] = "Rousing Fire",
	[190326] = "Rousing Air"
};

local macroBtn = CreateFrame("Button", "myMacroButton", UIParent, "SecureActionButtonTemplate")

function MainFrame_OnEvent(self, event, ...)
	if event == "WORLD_MAP_OPEN" then
		message("Open!")
	end

	if event == "BAG_NEW_ITEMS_UPDATED" and not InCombatLockdown() then
		macroBtn:RegisterForClicks("AnyUp", "AnyDown")
		macroBtn:SetAttribute("macrotext1", "/raid zomg a left click!")
		for k, v in pairs(MergeItems) do
			local count = GetItemCount(k)

			if count >= 10 then
				macroBtn:SetAttribute("macrotext1", "/use " .. v)
			end
		end
	end
end
