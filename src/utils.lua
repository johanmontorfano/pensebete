-- Manipulating and printing `Appdata` is managed by those utilities. Those 
-- ones will not be affected by potential over-engineering since they are 
-- fairly simple ;)
-- However, they require a specific Appdata format:
-- [entry]
--      rate
--      name
--      path
--      msg
-- ...

require "src.save"

local function get_posname_of(name)
    for key, data in ipairs(Appdata) do
        if name == data.name then
            return key
        end
    end
    return -1
end

local function get_posdir_of(dir)
    for key, data in ipairs(Appdata) do
        if dir == data.path then
            return key
        end
    end
    return -1
end

local function get_path()
    return arg[1]
end

-- List all the items saved in pensebete filtered by rate. 
-- @param lowrate Does not show items below a certain rate
-- @param highrate Does not show items past a certain rate
function List_with_filter(lowrate, highrate)
    if #Appdata == 0 then
        print "error: No entries found."
        return
    end
    for _, data in ipairs(Appdata) do
        local details = ""
        data.rate = tonumber(data.rate)
        if data.rate >= lowrate and data.rate <= highrate then
            if data.msg ~= nil and data.msg ~= "nothing" then
                details = data.msg
            end
            print(string.format(
                "%s\t%d%%\t%s",
                data.name,
                data.rate / 10 * 100,
                details
            ))
        end
    end
end

function Add_new(name, path)
    table.insert(Appdata, {
        name = name,
        path = path,
        rate = 0,
        msg = "nothing"
    })
end

function Auto_add()
    local path = get_path()
    local name = path:match("([^/\\]+)[/\\]*$")

    Add_new(name, path)
end

function Auto_log(rate)
    local path = get_path()
    local pos = get_posdir_of(path)

    if pos ~= -1 then
        local name = path:match("([^/\\]+)[/\\]*$")
        Operate_on(name, "log", rate)
    else
        print "error: Project not found"
    end
end

function Auto_msg(msg)
    local path = get_path()
    local pos = get_posdir_of(path)

    if pos ~= -1 then
        local name = path:match("([^/\\]+)[/\\]*$")
        Operate_on(name, "msg", msg)
    else
        print "error: Project not found"
    end
end

function Operate_on(name, operation, data)
    local pos = get_posname_of(name)

    if pos ~= -1 then
        if operation == "log" then Appdata[pos].rate = data
        elseif operation == "del" then Appdata[pos] = nil
        elseif operation == "cd" then
            os.execute(os.getenv("SHELL") ..
                " -c \"cd " .. Appdata[pos].path ..
                "; " .. os.getenv("SHELL") .. "\"")
        elseif operation == "msg" then Appdata[pos].msg = data
        end
    end
end
