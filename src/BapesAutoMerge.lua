local addonName, addonTable = ...;

local MergeItems = {
	[190322] = "Rousing Order",
	[190315] = "Rousing Earth",
	[190330] = "Rousing Decay",
	[190328] = "Rousing Frost",
	[190320] = "Rousing Fire",
	[190326] = "Rousing Air"
};

local macroBtn = CreateFrame("Button", string.format("%s_MergeItemMacroButton", addonName), UIParent,
	"SecureActionButtonTemplate")
macroBtn:RegisterForClicks("AnyUp", "AnyDown")

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
f:SetScript("OnEvent", function(self, event, ...)
	if f[event] then
		f[event](f, ...)
	end
end)

function f:ADDON_LOADED(...)
	if (...) == addonName then
		print("BapesAutoMerge loaded! Feel free to contact me for any requests, feedback, or bugs at Bapes#1111 on Discord and Battle.net.")
	end
end

function f:BAG_NEW_ITEMS_UPDATED(...)
	if not InCombatLockdown() then
		for itemID, itemName in pairs(MergeItems) do
			local count = GetItemCount(itemID)

			if count >= 10 then
				macroBtn:SetAttribute("macrotext1", string.format("/use %s", itemName))
				print(string.format("Ready to merge %s to Awakened", itemName))
			end
		end
	end
end
