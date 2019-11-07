local PAGE_NAME = "boilerplate"
local PAGE_TITLE = "Boilerplate Plugin"
local PAGE_ICON = "plug"

function CreatePage(FAQ, data, add)
    add(FAQ.Alert("info", "Boilerplate is working!"))
    add(FAQ.InfoCard("Random Facts", {
        {"Lines of code", 29},
        {"Characters", 1161},
        {"Created", "November 7th 2019"},
    }))
    return true, "OK"
end

-- Automatically sets up a page and sidebar option based on the above configurations
Citizen.CreateThread(function()
    local FAQ = exports['webadmin-lua']:getFactory()
    exports['webadmin']:registerPluginOutlet("nav/sideList", function(data) --[[R]]--
        if not exports['webadmin']:isInRole("webadmin."..PAGE_NAME..".view") then return "" end
        return FAQ.SidebarOption(PAGE_NAME, PAGE_ICON, PAGE_TITLE) --[[R]]--
    end)
    exports['webadmin']:registerPluginPage(PAGE_NAME, function(data) --[[E]]--
        if not exports['webadmin']:isInRole("webadmin."..PAGE_NAME..".view") then return "" end
        return FAQ.Nodes({ --[[R]]--
            FAQ.PageTitle(PAGE_TITLE),
            FAQ.BuildPage(CreatePage, data), --[[R]]--
        })
    end)
end)
