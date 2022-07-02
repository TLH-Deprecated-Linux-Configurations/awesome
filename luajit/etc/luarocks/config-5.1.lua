-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/home/tlh/Samsung/Work/awesome/luajit" };
}
lua_interpreter = "lua";
variables = {
   LUA_DIR = "/home/tlh/Samsung/Work/awesome/luajit";
   LUA_BINDIR = "/home/tlh/Samsung/Work/awesome/luajit/bin";
}
