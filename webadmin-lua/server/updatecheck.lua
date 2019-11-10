
local OUTDATED_RESOURCES = {}
function AddOutdatedResouce(resourceName, currentVersion, newVersion, downloadUrl)
    print("^3/======================================^7")
    print("^3| OUTDATED WEBADMIN PLUGIN!^7")
    print("^3|======================================^7")
    print("^3| ^5Resource:^7", resourceName)
    print("^3| ^5Version:^7", currentVersion, " -> ", newVersion)
    print("^3| ^5Download:^7", downloadUrl)
    print("^3\\======================================^7")
    OUTDATED_RESOURCES[resourceName] = {currentVersion, newVersion, downloadUrl}
end

AddEventHandler("onResourceStart", function(resourceName)
    local isWebadminPlugin = (GetNumResourceMetadata(resourceName, "webadmin_plugin") > 0)
    if (GetNumResourceMetadata(resourceName, "webadmin_plugin") > 0) then
        -- This is a webadmin plugin
        if (GetNumResourceMetadata(resourceName, "version") > 0) then
            -- It has a defined version
            local version = GetResourceMetadata(resourceName, "version", 0)
            if (GetNumResourceMetadata(resourceName, "author") > 0) then
                -- It has a defined author
                local author = GetResourceMetadata(resourceName, "author", 0)
                -- Time to check their github
                local url = "https://github.com/" .. author .. "/" .. resourceName .. "/"
                local versionurl = "https://raw.githubusercontent.com/" .. author .. "/" .. resourceName .. "/master/VERSION"
                PerformHttpRequest(versionurl, function(err, data, headers)
                    if err == 200 then
                        if tonumber(version) < tonumber(data) then
                            AddOutdatedResouce(resourceName, tonumber(version), tonumber(data), url)
                        end
                    end
                end, "GET")
            end
        end
    end
end)

function RemoveOutdatedResouce(resourceName)
    OUTDATED_RESOURCES[resourceName] = nil
end

AddEventHandler("onResourceStop", RemoveOutdatedResouce)

Citizen.CreateThread(function()
    local FAQ = getFactory()
    exports['webadmin']:registerPluginOutlet("home/dashboardTop", function()
        local nodes = {}
        for resourceName, resource in next, OUTDATED_RESOURCES do
            table.insert(nodes, FAQ.Alert("warning", FAQ.Nodes({
                FAQ.AlertHeading({"The plugin ", FAQ.AlertLink(resourceName, resource[3]), " is outdated!"}),
                FAQ.Node("div", {}, {
                    "Please upgrade from ",
                    FAQ.Node("code", {}, resource[1]),
                    " to ",
                    FAQ.Node("code", {}, resource[2]),
                    ".",
                })
            }), false, true))
        end
        return FAQ.Nodes(nodes)
    end)
end)
