local FAQ = {}
setmetatable(FAQ, {__index = _G})

-- Exported function
-- Returns the factory object
-- Optional callback param that is passed the factory object
function getFactory(cb)
    if cb then
        cb(FAQ)
    end
    return FAQ
end

-- Replicate the following functions in the FAQ table, so we can use them in the export
local REPLICATES = {
    "Node","Nodes",
    "Icon","TextIcon","AlertLink","AlertHeading",
    "Badge","Breadcrumb","Button","ButtonGroup",
    "ButtonToolbar","Callout","Card","CardList",
    "CardBase","CardBody","CardTitle","CardSubtitle",
    "CardText","CardLink","CardHeader","CardFooter",
    "Carousel","Dropdown","DropdownButton","FormInputText",
    "FormInputPassword","FormInputCheckbox","FormInputRadio",
    "Footer","FormInputTextGroup","NavList","NavItem",
    "NavLink","Navbar","NavbarBrand","NavbarNav",
    "NavbarText","Pagination","PageItem","PageLink",
    "ProgressBar","ProgressGroup","Switch","TableSmall",
    "TableBase","TableHead","TableBody","Form",
}
for _, replicate in next, REPLICATES do
    FAQ[replicate] = _G[replicate]
end

FAQ.BuildPage = function(cb, data)
    local html = ""
    data = FAQ.PatchData(data)
    local ok, msg = cb(FAQ, data, function(input)
        html = html .. input
    end)
    if not ok then
        return FAQ.Alert("warning", (msg or "Failed to build page"))
    end
    return html
end

FAQ.ReadableNumber = function(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000000000 then
        ret = placeValue:format(num / 1000000000000) .. "T" -- trillion
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. "B" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. "M" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = placeValue:format(num) -- hundreds
    end
    return ret
end

-- Generate a paginator widget to navigate between pages
FAQ.GeneratePaginator = function(pageName, currentPage, maxPages, align)
    local paginatorList = {}
    if maxPages > 0 then
        if currentPage > maxPages or currentPage < 0 then currentPage = 1 end
        table.insert(paginatorList, {"Previous", FAQ.GenerateDataUrl(pageName, {page = math.max(currentPage - 1, 1)}), false, currentPage == 1})
        for i = 1, maxPages do
            table.insert(paginatorList, {i, FAQ.GenerateDataUrl(pageName, {page = i}), i == currentPage})
        end
        table.insert(paginatorList, {"Next", FAQ.GenerateDataUrl(pageName, {page = math.min(currentPage + 1, maxPages)}), false, currentPage == maxPages})
        return Pagination(paginatorList, align or "center")
    end
    return Pagination({
        {"Previous", "#", false, true},
        {"-", "#", true, true},
        {"Next", "#", false, true},
    }, "center")
end

-- Get the plugin url with extra parameters
FAQ.GenerateDataUrl = function(name, data)
    local url = exports["webadmin"]:getPluginUrl(name)
    for get, val in next, data do
        if get ~= 'name' then
            url = url .. ("&%s=%s"):format(get, val)
        end
    end
    return url
end

-- Show a button in the sidebar
-- page, string, name of page
-- icon, string, font awesome icon to represent page
-- name, string, title of page
-- badge, string, badge content (optional)
-- badgetype, string, badge type (optional, defaults to warning)
-- active, bool, highlight button as if it's the current page (optional)
FAQ.SidebarOption = function(page, icon, name, badge, badgetype, active)
    return Node("li", {class = "nav-item" .. (active and " open" or "")}, Node("a", {class = "nav-link" .. (active and " active" or ""), href = FAQ.GenerateDataUrl(page, {})}, {
        Node("i", {class = "nav-icon fa fa-" .. icon}, ""),
        " " .. name,
        badge and Badge(badgetype or "warning", badge) or "",
    }))
end

-- Simply turns a table of tables into a key value pair
-- Yes, it breaks if you have multiple of the same key, but who the fuck does that anyways?
FAQ.PatchData = function(data)
    local returnData = {}
    for k, v in next, data do
        returnData[k] = v[1]
        -- Convert string numbers to real numbers
        if tostring(tonumber(v[1])) == v[1] then
            returnData[k] = tonumber(v[1])
        end
    end
    return returnData
end

--[[
Arguments:
table headers*
    list of header titles
table data*
    list of rows, each row is a list of each column
function datafunc(rowdata, n)
    advanced function ran for every row, return formatted row data
string style
    extra table css style
string headstyle
    extra table head css style
]]
FAQ.Table = function(headers, data, datafunc, style, headstyle)
    local rows = {}
    if datafunc then
        for n, row in next, data do
            table.insert(rows, datafunc(row, n))
        end
    else
        rows = data
    end
    return TableBase({
        TableHead(headers, headstyle),
        TableBody(rows, true)
    }, style)
end

FAQ.PageTitle = function(title)
    return Node("h1", {}, title)
end

FAQ.InfoCard = function(title, data)
    local innerData = ""
    for _, entry in next, data do
        innerData = innerData .. Node("dt", {class = "col-sm-2"}, entry[1])
        innerData = innerData .. Node("dd", {class = "col-sm-10"}, entry[2])
    end
    innerData = Node("dl", {class = "row my-0"}, innerData)
    return CardBase({
        CardHeader(title),
        CardBody(innerData),
    })
end

FAQ.UserCard = function(title, subtitle, data)
    local innerData = ""
    for _, entry in next, data do
        innerData = innerData .. Callout(entry[1], entry[2], "primary", true)
    end
    return CardBase({
        CardHeader({TextIcon("user"), title}),
        CardBody({
            CardSubtitle(subtitle),
            innerData,
        }),
    })
end

local ALERT_ICON_TYPES = {
    ["warning"] = [[<i class="fa fa-exclamation-triangle"></i> ]],
    ["danger"] = [[<i class="fa fa-exclamation-circle"></i> ]],
    ["info"] = [[<i class="fa fa-info-circle"></i> ]],
}
FAQ.Alert = function(alert, message, important, no_icon)
    return [[<div class="alert alert-]]..alert..[[" role="alert">]]..(important and "<strong>" or "")..(no_icon and "" or (ALERT_ICON_TYPES[alert] or ""))..message..(important and "</strong>" or "")..[[</div>]]
end
