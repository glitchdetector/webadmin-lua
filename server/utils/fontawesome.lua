-- Font Awesome Icon Structure
-- https://fontawesome.com/

-- by glitchdetector, Nov. 2019

function Icon(icon)
    return Node("i", {class = "fa fa-" .. icon}, "")
end

function TextIcon(icon)
    return Icon(icon) .. " "
end
