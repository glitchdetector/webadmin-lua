-- CoreUI / Bootstrap Structure
-- https://coreui.io/

-- by glitchdetector, Nov. 2019

-- CoreUI Alerts
-- https://coreui.io/docs/components/alerts/
function Alert(alert, content, dismissable, no_icon)
    return Node("div", {class = "alert alert-" .. alert .. (dismissable and " alert-dismissable fade show" or ""), role = "alert"}, Nodes({
        (dismissable and (Node("button", {type = "button", class = "close", ["data-dismiss"] = "alert", ["aria-label"] = "Close"}, Node("span", {["aria-hidden"] = "true"}, "&times;"))) or ""),
        content
    }))
end
function AlertLink(text, link)
    return Node("a", {href = link, class = "alert-link"}, text)
end
function AlertHeading(text)
    return Node("h4", {class = "alert-heading"}, text)
end

-- CoreUI Badges
-- https://coreui.io/docs/components/badge/
function Badge(badge, text, href)
    if href then
        return Node("a", {href = href, class = "badge badge-" .. badge}, text)
    else
        return Node("span", {class = "badge badge-" .. badge}, text)
    end
end

-- CoreUI Breadcrumb
-- https://coreui.io/docs/components/breadcrumb/
function Breadcrumb(elements, menu)
    local html = ""
    for n, elem in next, elements do
        if n < #elements then
            html = html .. Node("a", {class = "breadcrumb-item", href = elem[2]}, elem[1])
        else
            html = html .. Node("span", {class = "breadcrumb-item active"}, elem[1])
        end
    end
    if menu then
        html = html .. Node("div", {class = "breadcrumb-menu"}, Node("div", {class = "btn-group", role = "group"}, table.concat(menu, "")))
    end
    return Node("nav", {class = "breadcrumb"}, html)
end

-- CoreUI Buttons
-- https://coreui.io/docs/components/buttons/
function Button(button, text, attr, node)
    if not text then return Node("button", {class = "btn btn-primary"}, button) end
    local _attr = {class = "btn btn-" .. button}
    if attr then for k,v in next, attr do _attr[k] = v end end
    if node == "a" then _attr['role'] = 'button' end
    if node == "input" then _attr['value'] = text end
    return Node(node or "button", _attr, text)
end

-- CoreUI Button Group
-- https://coreui.io/docs/components/button-group/
function ButtonGroup(content)
    return Node("div", {class = "btn-group", role = "group"}, content)
end
function ButtonToolbar(content)
    return Node("div", {class = "btn-toolbar", role = "toolbar"}, content)
end

-- CoreUI Callout
-- https://coreui.io/docs/components/callout/
function Callout(title, value, type, outline)
    return Node("div", {class = "callout callout-" .. type .. (outline and " b-t-1 b-r-1 b-b-1" or "")}, Nodes({
        Node("small", {class = "text-muted"}, title),
        Node("br"),
        Node("strong", {class = "h4"}, value),
    }))
end

-- CoreUI Cards
-- https://coreui.io/docs/components/cards/
function Card(title, subtitle, content, footer)
    return CardBase({CardBody({
        title and CardTitle(title) or "",
        subtitle and CardSubtitle(subtitle) or "",
        content or "",
    }), footer and CardFooter(footer) or ""})
end
function CardList(title, items)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. Node("li", {class = "list-group-item"}, item)
    end
    return CardBase({
        CardHeader(title),
        Node("ul", {class = "list-group list-group-flush"}, innerItems)
    })
end

function CardBase(content)
    return Node("div", {class = "card"}, content)
end
function CardBody(content)
    return Node("div", {class = "card-body"}, content)
end
function CardTitle(content)
    return Node("h5", {class = "card-title"}, content)
end
function CardSubtitle(content)
    return Node("h6", {class = "card-subtitle mb-2 text-muted"}, content)
end
function CardText(content)
    return Node("p", {class = "card-text"}, content)
end
function CardLink(content, href)
    return Node("a", {href = href, class = "card-link"}, content)
end
function CardHeader(content)
    return Node("div", {href = href, class = "card-header"}, content)
end
function CardFooter(content)
    return Node("div", {href = href, class = "card-footer text-muted"}, content)
end

-- CoreUI Carousel
-- https://coreui.io/docs/components/carousel/
-- No. Just no
function Carousel(items)
    return Alert("warning", "Carousel is currently not supported")
end

-- CoreUI Collapse
-- https://coreui.io/docs/components/collapse/
-- No. Just no

-- CoreUI Dropdown
-- https://coreui.io/docs/components/dropdowns/
function Dropdown(text, items)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. Node("a", {class = "dropdown-item", href = item[2]}, item[1])
    end
    return Node("div", {class = "dropdown"}, {
        Button("secondary dropdown-toggle", text, {
            type = "button",
            ["data-toggle"] = "dropdown",
            ["aria-haspopup"] = true,
            ["aria-expanded"] = false
        }),
        Node("div", {class = "dropdown-menu"}, innerItems),
    })
end
function DropdownButton(button, text, href, items)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. Node("a", {class = "dropdown-item", href = item[2]}, item[1])
    end
    return ButtonGroup({
        Button(button, text, {href = href}),
        Button(button .. " dropdown-toggle dropdown-split", "", {
            type = "button",
            ["data-toggle"] = "dropdown",
            ["aria-haspopup"] = true,
            ["aria-expanded"] = false
        }),
        Node("div", {class = "dropdown-menu"}, innerItems),
    })
end

-- CoreUI Forms
-- https://coreui.io/docs/components/forms/
function FormInputText(name, placeholder, label)
    return Node("div", {class = "form-group row"}, {
        label and Node("label", {class = "col-sm-2 col-form-label"}, label) or "",
        Node("div", {class = "col-sm-10"}, Node("input", {
            type = "text",
            class = "form-control",
            name = name,
            value = "",
            placeholder = placeholder or "",
        }, ""))
    })
end
function FormInputPassword(name, placeholder, label)
    return Node("div", {class = "form-group row"}, {
        label and Node("label", {class = "col-sm-2 col-form-label"}, label) or "",
        Node("div", {class = "col-sm-10"}, Node("input", {
            type = "password",
            class = "form-control",
            name = name,
            value = "",
            placeholder = placeholder or "",
        }, ""))
    })
end
function FormInputCheckbox(name, checked, label, inline)
    return Node("div", {class = "form-check" .. (inline and " form-check-inline" or "")}, {
        Node("input", {class = "form-check-input", name = name, type = "checkbox", value = (checked and "on" or nil)}, ""),
        label and Node("label", {class = "form-check-label"}, label) or "",
    })
end

function FormInputRadio(name, value, checked, label, inline)
    return Node("div", {class = "form-check" .. (inline and " form-check-inline" or "")}, {
        Node("input", {class = "form-check-input", name = name, type = "radio", value = value, checked = (checked and "checked" or nil)}, ""),
        label and Node("label", {class = "form-check-label"}, label) or "",
    })
end

-- CoreUI Footer
-- https://coreui.io/docs/components/footer/
function Footer(left, right)
    return Node("footer", {class = "app-footer"}, {
        left and Node("div", {}, left) or "",
        right and Node("div", {class = "ml-auto"}, right) or "",
    })
end

-- CoreUI Input Group
-- https://coreui.io/docs/components/input-group/
function FormInputTextGroup(name, placeholder, left, right)
    return Node("div", {class = "input-group mb-3"}, {
        left and Node("div", {class = "input-group-prepend"}, Node("span", {class = "input-group-text"}, left)) or "",
        Node("input", {
            type = "text",
            class = "form-control",
            name = name,
            value = "",
            placeholder = placeholder or "",
        }, ""),
        right and Node("div", {class = "input-group-append"}, Node("span", {class = "input-group-text"}, right)) or "",
    })
end

-- CoreUI List Groups
-- https://coreui.io/docs/components/list-group/


-- CoreUI Navs
-- https://coreui.io/docs/components/navs/
function NavList(items, align)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. NavItem(item)
    end
    return Node("ul", {class = "nav justify-content-" .. align or "left"}, innerItems)
end
function NavItem(item)
    return Node("li", {class = "nav-item"}, item)
end
function NavLink(text, href)
    return Node("a", {class = "nav-link", href = href}, text)
end

-- CoreUI Navbar
-- https://coreui.io/docs/components/navbar/
function Navbar(title, content)
    return Node("nav", {class = "navbar navbar-expand-lg navbar-light bg-light"}, {
        NavbarBrand(title),
        content
    })
end
function NavbarBrand(text)
    return Node("div", {class = "navbar-brand"}, text)
end
function NavbarNav(items)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. NavItem(item)
    end
    return Node("ul", {class = "navbar-nav mr-auto"}, innerItems)
end
function NavbarText(text)
    return Node("span", {class = "navbar-text"}, text)
end

-- CoreUI Pagination
-- https://coreui.io/docs/components/pagination/
function Pagination(items, align)
    local innerItems = ""
    for _, item in next, items do
        innerItems = innerItems .. PageItem(PageLink(item[1], item[2]), item[3], item[4])
    end
    return Node("nav", {}, Node("ul", {class = "pagination justify-content-" .. (align or "left")}, innerItems))
end
function PageItem(item, active, disabled)
    return Node("li", {class = "page-item" .. (active and " active" or "") .. (disabled and " disabled" or "")}, item)
end
function PageLink(text, href)
    return Node("a", {class = "page-link", href = href}, text)
end

-- CoreUI Progress
-- https://coreui.io/docs/components/progress/
function ProgressBar(min, max, value, label, bg, style)
    local percent = math.floor(((value / max) * 100) + 0.5)
    return Node("div", {class = "progress" .. (style and " " .. style or "")}, {
        Node("div", {
            class = "progress-bar progress-bar-animated progress-bar-striped" .. (bg and " bg-" .. bg or ""),
            role = "progressbar",
            style = "width: " .. percent .. "%",
            ["aria-valuenow"] = value,
            ["aria-valuemin"] = min,
            ["aria-valuemax"] = max,
        }, label)
    })
end
function ProgressGroup(min, max, value, title, right, bg, style)
    local percent = math.floor(((value / max) * 100) + 0.5)
    return Node("div", {class = "progress-group" .. (style and " " .. style or "")}, {
        Node("div", {class = "progress-group-header align-items-end"}, {
            Node("div", {}, title),
            Node("div", {}, ""),
            Node("div", {class = "ml-auto font-weight-bold mr-2"}, right),
            Node("div", {class = "text-muted small"}, "(" .. percent .. "%)"),
        }),
        Node("div", {class = "progress-group-bars"}, ProgressBar(min, max, value, "", bg, "progress-xs")),
    })
end

-- CoreUI Switches
-- https://coreui.io/docs/components/switches/
function Switch(name, checked, color)
    return Node("label", {class = "switch switch-" .. (color or "primary")}, {
        Node("input", {name = name, type = "checkbox", class = "switch-input", checked = (checked and "checked" or nil)}, ""),
        Node("span", {class = "switch-slider"}, "")
    })
end

-- CoreUI Tables
function Table(headers, rows, style)
    return TableBase({
        TableHead(headers),
        TableBody(rows, true),
    }, style)
end
function TableSmall(headers, rows)
    return Table(headers, rows, "table-sm")
end
function TableBase(content, style)
    return Node("table", {class = "table table-striped table-hover" .. (style and " " .. style or "")}, content)
end
function TableHead(headers, style)
    local innerHeaders = ""
    for n, head in next, headers do
        innerHeaders = innerHeaders .. Node("th", {scope = "col", style = ((n == 1) and "width: 1px;" or ((n == 2) and "width: 25%;" or ""))}, head)
    end
    return Node("thead", {class = "thead-" .. (style or "dark")}, Node("tr", {}, innerHeaders))
end
function TableBody(rows, thfirst)
    local innerRows = ""
    for _, row in next, rows do
        local innerRow = ""
        for n, data in next, row do
            if n == 1 and thfirst then
                innerRow = innerRow .. Node("th", {scope = "row"}, data)
            else
                innerRow = innerRow .. Node("td", {}, data)
            end
        end
        innerRows = innerRows .. Node("tr", {}, innerRow)
    end
    return Node("tbody", {}, innerRows)
end

function Form(target, values, contents)
    local url = exports["webadmin"]:getPluginUrl(target)
    local innerValues = Node("input", {type = "hidden", name = "name", value = target}, "")
    for k, v in next, values do
        innerValues = innerValues .. Node("input", {type = "hidden", name = k, value = v}, "")
    end
    return Node("form", {method = "get", action = url}, Nodes({innerValues, contents}))
end

function _Form(target, values, contents)
    local url = exports["webadmin"]:getPluginUrl(target)
    local html = [[<form method="get" style="display: inline-block;" action="]]..url..[[">]]
    html = html .. [[<input type="hidden" name="name" value="]]..target..[[">]]
    for k, v in next, values do
        html = html .. [[<input type="hidden" name="]]..k..[[" value="]]..v..[[">]]
    end
    for _, v in next, contents do
        html = html .. v
    end
    html = html .. [[</form>]]
    return html
end
