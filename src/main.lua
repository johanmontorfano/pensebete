require "os"
require "src.save"
require "src.utils"

Init_db()
if arg[1] == "--help" then
    print "USAGE"
    print "\tpensebete --help"
    print "\tpensebete [--all | --ongoing | --finished]"
    print "\tpensebete --add <name> <path>"
    print "\tpensebete -a"
    print "\tpensebete --log <name> <progression>"
    print "\tpensebete -l <progression>"
    print "\tpensebete --msg <name> <message>"
    print "\tpensebete -m <message>"
    print "\tpensebete --open <path>"
    print "\tpensebete --del <name>"
    print "COMMANDS"
    print "\t--help         show this dialog"
    print "\t--all          show all projects"
    print "\t--ongoing      show ongoing projects"
    print "\t--finished     show finished projects"
    print "\t--add          add a project"
    print "\t--a            add the current path and dir name as a project"
    print "\t--log          change the progression rate of a project"
    print "\t-l             add the given rate to the project if found"
    print "\t--msg          add a note to a project"
    print "\t-m             add a note to the current project"
    print "\t--open         open a project's location"
    print "\t--del          delete a project"
    print "ARGUMENTS"
    print "\t<name>         project name"
    print "\t<path>         project path"
    print "\t<progression>  project progression rate over 10"
    print "\t<message>      note stored with the project"
    os.exit(0)
end
if arg[2] == "--all" then List_with_filter(-1, 11)
elseif arg[2] == "--ongoing" then List_with_filter(1, 9)
elseif arg[2] == "--finished" then List_with_filter(10, 10)
elseif arg[2] == "--add" then Add_new(arg[3], arg[4])
elseif arg[2] == "--del" then Operate_on(arg[3], "del")
elseif arg[2] == "--msg" then Operate_on(arg[3], "msg", arg[4])
elseif arg[2] == "--log" then Operate_on(arg[3], "log", tonumber(arg[4]))
elseif arg[2] == "--open" then Operate_on(arg[3], "cd")
elseif arg[2] == "-a" then Auto_add()
elseif arg[2] == "-l" then Auto_log(arg[3])
elseif arg[2] == "-m" then Auto_msg(arg[3])
end
Save_db()
