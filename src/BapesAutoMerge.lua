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
	"SecureActionButtonTemplate, UIPanelButtonTemplate")

macroBtn:RegisterForClicks("AnyUp", "AnyDown")

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetPoint("CENTER")
f:SetSize(100, 50)
f:SetMovable(true)
f:EnableMouse(true)
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

				macroBtn:SetText(string.format("Merge %s", itemName))
				macroBtn:SetAttribute("macrotext1", string.format("/use %s", itemName))
				print(string.format("Ready to merge %s to Awakened", itemName))
				ShowMergeButton()
			end
		end
	end
end

function ShowMergeButton()
	macroBtn:SetPoint("CENTER")
	macroBtn:SetSize(100, 50)
	macroBtn:SetMovable(true)
	macroBtn:EnableMouse(true)
	macroBtn:Show()
end
