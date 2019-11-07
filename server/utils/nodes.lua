-- HTML DOM Node Structure
-- no source or relevancy I guess

-- by glitchdetector, Nov. 2019

-- HTML Node creator
function Node(name, attr, content)
    local html = ""
    html = html .. ("<%s%s"):format(content and "" or "/", name)
    if attr then
        for k, v in next, attr do
            html = html .. (" %s=\"%s\""):format(k, v)
        end
    end
    if content then
        if type(content) == 'table' then
            html = html .. (">%s</%s>"):format(Nodes(content), name)
        else
            html = html .. (">%s</%s>"):format(tostring(content or ""), name)
        end
    else
        html = html .. ">"
    end
    return html
end

-- Generates HTML from a list of Nodes
-- Actually just a recursive deep concat
function Nodes(nodes, sep)
    local html = ""
    for _, node in next, nodes do
        if type(node) == 'table' then
            html = html .. Nodes(node, sep)
        else
            html = html .. tostring(node) .. (sep or "")
        end
    end
    return html
end
