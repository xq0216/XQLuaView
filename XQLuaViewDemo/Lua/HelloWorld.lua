w,h = System.screenSize();
window:frame(0, 0, w, h);
window:backgroundColor(0xDDDDDD);

label = Label();
label:frame(0,50,w, 60);
label:text("Hello  LuaView!");


button0 = Button();
button0:frame(10,10,100,100);
button1:title("button0-DebugReadCmd");
button0:callback(function()
debug.DebugReadCmd();
print("button0-DebugReadCmd");
end);

button1 = Button();
button1:frame(120,10,100,100);
button1:title("button1");
button1:callback(function()
debug.DebugWriteCmd("debugger","XQInfo","");
print("button1-debugger.XQInfo.");
end);

button2 = Button();
button2:frame(10,130,100,100);
button2:image("http://g.alicdn.com/ju/lua/2.0.25/doc/icon.png","http://g.alicdn.com/ju/lua/2.0.25/doc/icon2.png");
button2:callback(function()
debug.DebugPrintToServer("true");
print("button2-DebugPrintToServer");
end);


button3 = Button();
button3:frame(102,130,100,100);
button3:image("button0.png","button1.png");
button3:callback(function()
debug.runningLine("HelloWord.lua","2");
print("button3-runningLine");
end);

