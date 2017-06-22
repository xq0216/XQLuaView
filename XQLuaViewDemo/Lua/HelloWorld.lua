w,h = System.screenSize();
window:frame(0, 0, w, h);
window:backgroundColor(0xDDDDDD);

label = Label();
label:frame(0,50,w, 60);
label:text("Hello  LuaView!");



function bottomViewUIWithParm(cmd)
    if( cmd==nil ) then
        return;
    end
    if type(cmd) ~= "table" then
        return;
    end

    for i=1,table.getn(cmd) do
        print(cmd[i]);
    end
    print(cmd);
    local c = cmd[0];
    print(c);
    aLabel = Label();
    aLabel:text(c);
    aLabel:frame(0, 0, 100, 30);
end
