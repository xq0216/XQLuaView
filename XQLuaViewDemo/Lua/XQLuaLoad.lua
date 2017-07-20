-- 待下载的脚本url
fileUrl = "http://xxxx/XQOnline0.lua"

Download( fileUrl,"online0.lua",
    function (data)
        print( data );
        -- 使用 loadstring 的方式加载下载的脚本，并运行
        online0 = loadstring(tostring(data));
        online0();

        -- 将下载的数据流写到文件中
        -- File.save("online0.lua",data);
        -- 使用 loadfile 的方式加载下载的脚本，并运行
        -- online1 = loadfile(PathOfResource("online0.lua"));
        -- online1();
        -- print("xq--",PathOfResource("online0.lua"));

        -- 使用 load 的方式加载方法，并运行
        -- hi4 = load(function() print('this is a function') end);
        -- hi4();
    end);
