-- Creating, loading, and saving data is entirely managed by this module. To
-- prevent over-engineering this project, data will be stored as a JSON file
-- in the appropriate Linux directory.
-- P.S. Nevertheless, for the sake of over-engineering, I may implement
-- cryptography and hashing (custom implementation) to this project.

require "io"
local json = require "src.modules.json"
local save_path = "/home/johanmontorfano/.pensebete.json"
Appdata = {}

function Init_db()
    local file = io.open(save_path, "r")

    if file ~= nil then
        local content = file:read("a")
        if file ~= nil then
            Appdata = json.decode(content)
        end
    end
end

function Save_db()
    local file = io.open(save_path, "w")

    file:write(json.encode(Appdata))
    file:flush()
    file:close()
end
