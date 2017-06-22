function topViewUI( )
	aLabel = Label();
	aLabel:text("aaaaa");
	aLabel:frame(0, 0, 100, 30);
end

function CenterViewUI()
aLabel = Label();
aLabel:text("bbbbb");
aLabel:frame(0, 0, 100, 30);
end

function bottomViewUI()
xqView = XQItemLuaView();
xqView:frame(0, 0, 100, 100);
xqView:title("自定义View");
xqView:image("icon");
end
