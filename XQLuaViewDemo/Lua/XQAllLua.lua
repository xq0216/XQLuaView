function bottomViewUI()
aLabel = Label();
aLabel:text("bbbb");
aLabel:frame(0, 0, 100, 30);
end


w,h = System:screenSize();
bannerHeight = 180;

defaultIcon = "placeholder";
icons = {"icon","chat","check","icon","chat"};
titles = {"个人信息","我的朋友","我的钱包","商城","其他"};

local columnsCount 
columnsCount = 3;
if(h > 667) then
    columnsCount = 4;
end

itemSpace = 1;
cellWidth =  (w-columnsCount*itemSpace-itemSpace)/columnsCount;
cellHeight = cellWidth*100/125;


collectionView = CollectionView{
	Section = {
		SectionCount = 2;
    	RowCount = function ( section )
            if(section == 1)then 
                return 1;
            else
                return table.getn(icons);
            end
        end,
	},

    Cell = {
    	Id = function ( section, row )
            if(section == 1)then 
                return "Banner";
            else
                return "IconAndTitle";
            end
    	end,

        -- 顶部广告图片   
        Banner = {
            Size = function ( section, row )
                    return w,bannerHeight;
            end,
            Init = function ( cell )
                cell.banner = Image();
                cell.banner:scaleType(0);
                cell.banner:frame(0, 0, w, bannerHeight);
            end,
            Layout = function ( cell, section, row )
                 cell.banner:image("xqbanner0");
            end,
            Callback = function ( cell, section, row )
                System:gc();
                print("点击banner");
            end
        },
        -- 九宫格
    	IconAndTitle = {
    		Size = function ( section, row )
                    -- print("cellWidth=", cellWidth,"---cellHeight=" ,cellHeight);
    				return cellWidth,cellHeight;
    		end,

    		Init = function ( cell )
    			local cellWidth ,cellHeight = cell.window:size();
                local iconWidth = 72/2;
                local iconHeight = 72/2;
                local titleHeight = 20;
                local space = (cellHeight - iconHeight - titleHeight)/3;
                -- icon
                cell.icon = Image();
                cell.icon:scaleType(1);
                cell.icon:frame((cellWidth - iconWidth)/2, space, iconWidth, iconHeight);
                -- cell.icon:backgroundColor(0xFFFF00);
                -- title
                cell.title = Label();
                cell.title:frame(0, space*2 + iconHeight, cellWidth, titleHeight);
                cell.title:textAlign(1);
                cell.title:textColor(0x000000);
                -- cell.title:backgroundColor(0xFFFFF0);
                -- print("构造IconAndTitle-Cell");
    		end,

    		Layout = function ( cell, section, row )
    			-- print("section=", section,"---row=" ,row);
                imgName = icons[row];
                cell.icon:image(imgName);
                cell.title:text(titles[row]);
                cell.window:backgroundColor(0xFFFFFF);
    		end,

    		Callback = function ( cell, section, row )
				print("点击 "..titles[row]);
                System:gc();
    		end

    	}
    },
    Callback = {
			Scrolling = function( firstVisibleSection, firstVisibleRow, visibleCellCount )
				print("scrolling", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
			end,
			ScrollBegin = function(firstVisibleSection, firstVisibleRow, visibleCellCount )
				print("scrolling begin", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
			end,
			ScrollEnd = function(firstVisibleSection, firstVisibleRow, visibleCellCount )
				print("scrolling end", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
			end
	}
    
};

collectionView:frame(0,0,w,h);
collectionView:backgroundColor(0xF5F5F5);
collectionView:miniSpacing(itemSpace,itemSpace);
