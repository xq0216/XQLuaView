w,h = System:screenSize();
bannerHeight = 180;
bannerImageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1498534338&di=9ebd22cf998a6527993ec33fd0ad60bc&src=http://img5q.duitang.com/uploads/item/201505/01/20150501111402_cdGWt.png";

defaultIcon = "placeholder";
icons = {"http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",
        "http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",
        "http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",
        "http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png",
        "http://g.alicdn.com/ju/lua/2.0.24/doc/icon.png"};

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
                -- 利用自定义Image，进行图片下载及展示 
                 cell.banner:image(bannerImageUrl);
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
                -- 自定义View，添加到cell上展示
                cell.xqView = XQItemLuaView();
                cell.xqView:frame(0, 0, cellWidth, cellHeight);

                -- print("构造含有自定义View的IconAndTitle-Cell");
            end,

            Layout = function ( cell, section, row )
                imgName = icons[row];
                -- 自定义view设置UI展示
                cell.xqView:image(imgName);
                cell.xqView:title(titles[row]);
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
