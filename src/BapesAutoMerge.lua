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
macroBtn:SetAttribute("type", "macro")

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetPoint("CENTER")
f:SetSize(150, 50)
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
				ShowMergeButton(itemName)
			end
		end
	else
		macroBtn:Hide()
	end
end

macroBtn:HookScript("OnClick", function()
	local hide = true

	for itemID, itemName in pairs(MergeItems) do
		local count = GetItemCount(itemID)

		if count >= 10 then
			ShowMergeButton(itemName)
			hide = false
		end
	end

	if hide then
		macroBtn:Hide()
	end
end)

macroBtn:SetScript("OnDragStart", function(self, button)
	self:StartMoving()
	print("OnDragStart", button)
end)

macroBtn:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	print("OnDragStop")
end)

function ShowMergeButton(itemName)
	macroBtn:SetText(string.format("Merge %s", itemName))
	macroBtn:SetAttribute("macrotext", string.format("/use %s", itemName))
	print(string.format("Ready to merge %s to Awakened", itemName))
	macroBtn:SetPoint("CENTER")
	macroBtn:SetSize(150, 50)
	macroBtn:SetMovable(true)
	macroBtn:EnableMouse(true)
	macroBtn:RegisterForDrag("LeftButton")
	macroBtn:Show()
end
