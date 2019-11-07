local PAGE_NAME = "demo"
local PAGE_TITLE = "Demo"
local PAGE_ICON = "file-excel"

-- CreatePage is the main page function, this is where you can generate all elements
-- FAQ is the widget factory, it has several pre-made helpers to create widgets with
-- data is a table of the current data passed by Webadmin
-- add is the function you use to add elements to the page
-- return true/false based on if the page builds properly, pass a status as second return value
-- if the function return false, an error is displayed and no elements are shown
function CreatePage(FAQ, data, add)
    -- use FAQ.Node(type, attributes, content) to create a new DOM Element with the specificed attributes and content
    local hr = FAQ.Node("hr", {}, "")
    -- You can specify attributes, such as style, class etc.
    local h1 = FAQ.Node("h1", {style = "color: red;"}, "Please read the demo.lua file for more information")
    -- use FAQ.Nodes({node1, node2, ...}) to bunch together multiple DOM Elements
    local heading = FAQ.Nodes({h1, hr})
    -- use add(element) to add an element to the page
    add(heading)

    add(FAQ.Node("h3", {}, "Tables"))
    -- Tables can be generated easily
    -- Some special formatting is done on tables by default to make the first cols thinner
    -- Table(headers, data)
    local table = FAQ.Table(
        {"A", "B", "C"},
        {
            {1, 2, 3},
            {"<", "^", ">"},
        }
    )
    -- by default, each row is entered directly and has to be pre-formatted
    add(table)
    -- You can pass a row formatting function to do advanced stuff easily
    -- Table(headers, data, rowfunc)
    local advtable = FAQ.Table(
        {"#", "ID", "Username"},
        {
            {id = 420, name = "Snaily"},
            {id = 621, name = "glitchdetector", staff = "true"},
            {id = 1337, name = "John Doe"},
        },
        function(row, n)
            -- row contains the raw row data, n is the current row
            -- return data should be the pre-formatted row data
            if row.staff then
                -- Here we return the row, but it's with a fancy badge for "staff"
                return {n, row.id, FAQ.Nodes({
                    row.name, " ", FAQ.Badge("warning", {FAQ.TextIcon("star"), "Staff"})
                })}
            end
            -- Return the row
            return {n, row.id, row.name}
        end
    )
    add(advtable)
    -- there are also custom table styles you can apply
    -- Table(headers, data, rowfunc, tablestyle, tableheadstyle)
    local smtable = FAQ.Table(
        {"A", "B", "C"},
        {
            {1, 2, 3},
            {"<", "^", ">"},
        },
        function(row) return {row[3], row[2], row[1]} end,
        "table-sm",
        "light"
    )
    add(smtable)

    add(hr)
    -- a paginator can allow you to have multiple "pages", such as for long lists
    -- you need to handle showing each page yourself though!
    if not data.page then data.page = 1 end -- set a page value if none exist
    local maxpages = 10
    -- Do crazy stuff with the current page index!
    add(FAQ.Node("h3", {}, {
        "Paginator", " ", FAQ.Badge("info", {data.page, " / ", maxpages})
    }))

    -- generate the paginator with the current page and page amount
    local paginatorc = FAQ.GeneratePaginator(PAGE_NAME, data.page, maxpages)
    -- you can also specify the alignment left or center (default)
    local paginatorl = FAQ.GeneratePaginator(PAGE_NAME, data.page, maxpages, "left")
    add(FAQ.Nodes({paginatorl, paginatorc}))

    add(hr)
    add(FAQ.Node("h3", {}, "Info Card"))
    -- an info card is a simple card contaning some basic informational fields
    local infocard = FAQ.InfoCard("Card Title", {
        {"Information", "Yes"},
        {"Useful", "Yes!"},
        {"Dumb", "No!!!!"},
    })
    add(infocard)

    add(hr)
    add(FAQ.Node("h3", {}, "User Card"))
    -- a user card is an unfinished thing, it should probably be re-done, you're better off making your own cards
    local usercard = FAQ.UserCard("Username", "Professional Title", {
        {"Information", "I guess?"},
        {"Useful", "Not sure"},
        {"Dumb", "Eh, probably"},
    })
    add(usercard)

    add(hr)
    add(FAQ.Node("h3", {}, "Alerts"))
    -- alerts can be used to convey important messages
    -- they come in many different variations
    local warning = FAQ.Alert("warning", "This is a warning message!")
    local danger = FAQ.Alert("danger", "This is a danger message!")
    local info = FAQ.Alert("info", "This is an info message!")
    -- more variations exist, check coreui docs, these 3 have pre-assigned icons
    add(FAQ.Nodes({warning, danger, info}))

    add(hr)
    add(FAQ.Node("h3", {}, "Badges"))
    -- badges let you put a highlighted bit of information together with something else
    -- it maintains size properties from what it's joined with
    local badge = FAQ.Badge("info", "I'm a badge")
    local exampletitle = FAQ.Node("h2", {}, FAQ.Nodes({
        -- We also add a whitespace between the text and the badge
        "Some Long Title Text", " ", badge
    }))
    add(exampletitle)
    -- you can use them practically anywhere, even inside other badges (no idea who you'd need to, but you can!)
    local badgeception = FAQ.Badge("info", {"badgeception", FAQ.Badge("danger", {"badgeception", FAQ.Badge("warning", {"badgeception", FAQ.Badge("primary", "badgeception")})})})
    add(badgeception)

    add(hr)
    add(FAQ.Node("h3", {}, "Breadcrumb"))
    -- breadcrumbs allow you to make easy navigation between pages or between sub-pages
    -- pass a list containing every page up until the current page with a url
    local breadcrumb = FAQ.Breadcrumb({
        {"FiveM", "https://fivem.net"},
        {"Webadmin", "#"},
        {"Demo"}
    })
    add(breadcrumb)

    -- There's a lot of helper functions included in the factory, here's most of them:
    -- Node(name, attr, content)
    -- Nodes(nodes, sep)
    -- Icon(icon)
    -- TextIcon(icon)
    -- Alert(alert, content, dismissable, no_icon)
    -- AlertLink(text, link)
    -- AlertHeading(text)
    -- Badge(badge, text, href)
    -- Breadcrumb(elements, menu)
    -- Button(button, text, attr, node)
    -- ButtonGroup(content)
    -- ButtonToolbar(content)
    -- Callout(title, value, type, outline)
    -- Card(title, subtitle, content, footer)
    -- CardList(title, items)
    -- CardBase(content)
    -- CardBody(content)
    -- CardTitle(content)
    -- CardSubtitle(content)
    -- CardText(content)
    -- CardLink(content, href)
    -- CardHeader(content)
    -- CardFooter(content)
    -- Carousel(items)
    -- Dropdown(text, items)
    -- DropdownButton(button, text, href, items)
    -- FormInputText(name, placeholder, label)
    -- FormInputPassword(name, placeholder, label)
    -- FormInputCheckbox(name, checked, label, inline)
    -- FormInputRadio(name, value, checked, label, inline)
    -- Footer(left, right)
    -- FormInputTextGroup(name, placeholder, left, right)
    -- NavList(items, align)
    -- NavItem(item)
    -- NavLink(text, href)
    -- Navbar(title, content)
    -- NavbarBrand(text)
    -- NavbarNav(items)
    -- NavbarText(text)
    -- Pagination(items, align)
    -- PageItem(item, active, disabled)
    -- PageLink(text, href)
    -- ProgressBar(min, max, value, label, bg, style)
    -- ProgressGroup(min, max, value, title, right, bg, style)
    -- Switch(name, checked, color)
    -- Table(headers, rows, style)
    -- TableSmall(headers, rows)
    -- TableBase(content, style)
    -- TableHead(headers, style)
    -- TableBody(rows, thfirst)
    -- Form(target, values, contents)
    -- ReadableNumber(num, places)
    -- GeneratePaginator(pageName, currentPage, maxPages)
    -- GenerateDataUrl(name, data)
    -- SidebarOption(page, icon, name, badge, badgetype)
    -- PatchData(data)
    -- Table(headers, data, datafunc, style, headstyle)
    -- PageTitle(title)
    -- InfoCard(title, data)
    -- UserCard(title, subtitle, data)

    -- return with the build status
    -- if this returns false, an error message is shown instead of the page
    return true, "ok"
end

-- The below code is responsible for setting up the plugin
-- Unless you need advanced behavior you can resort to only editing the contents of CreatePage
-- For the sake of being a demo, I'll comment the behavior anyways
Citizen.CreateThread(function()
    -- Fetch the factory object
    local FAQ = exports['webadmin-lua']:getFactory()
    -- Register the sidebar button
    exports['webadmin']:registerPluginOutlet("nav/sideList", function(data)
        -- Make sure the user has access to the page
        if not exports['webadmin']:isInRole("webadmin."..PAGE_NAME..".view") then return "" end
        -- Create the sidebar button
        return FAQ.SidebarOption(PAGE_NAME, PAGE_ICON, PAGE_TITLE)
    end)
    -- Register the plugin page itself
    exports['webadmin']:registerPluginPage(PAGE_NAME, function(data)
        -- Make sure the user has access to the page
        if not exports['webadmin']:isInRole("webadmin."..PAGE_NAME..".view") then return "" end
        -- Build the page by combining a title and the output from the CreatePage function
        return FAQ.Nodes({
            FAQ.PageTitle(PAGE_TITLE),
            -- BuildPage sets up for the CreatePage function
            FAQ.BuildPage(CreatePage, data),
        })
    end)
end)
