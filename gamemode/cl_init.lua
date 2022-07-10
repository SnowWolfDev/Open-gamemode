hook.Run("RealRPStartLoading")

GM.Version = "0.0.1"
GM.Name = "RealRP"
GM.Author = "By snow-_-wolf"

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass


local function LoadModules()
    local root = GM.FolderName .. "/gamemode/modules/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if RealRP.disabledDefaults["modules"][folder] then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            if File == "sh_interface.lua" then continue end
            include(root .. folder .. "/" .. File)
        end

        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            if File == "cl_interface.lua" then continue end
            include(root .. folder .. "/" .. File)
        end
    end
end

GM.Config = {} -- config table
GM.NoLicense = GM.NoLicense or {}

include("config/config.lua")
include("libraries/sh_cami.lua")
include("libraries/simplerr.lua")
include("libraries/fn.lua")
include("libraries/tablecheck.lua")
include("libraries/interfaceloader.lua")
include("libraries/disjointset.lua")

include("libraries/modificationloader.lua")

hook.Call("RealRPPreLoadModules", GM)

LoadModules()

RealRP.REALRP_LOADING = true
include("config/jobrelated.lua")
include("config/addentities.lua")
include("config/ammotypes.lua")
RealRP.REALRP_LOADING = nil

RealRP.finish()

hook.Call("RealRPFinishedLoading", GM)