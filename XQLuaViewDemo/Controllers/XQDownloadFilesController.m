//
//  XQDownloadFilesController.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/7/3.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQDownloadFilesController.h"
#import "XQLuaViewController.h"

#import "XQDataHelper.h"

static NSString *luaResourceUrlStr = @"http://xxxx/XQOnlineLuas.zip";
@interface XQDownloadFilesController ()
{
    NSArray *p_keys;
    NSArray *p_values;
}
@end

@implementation XQDownloadFilesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"XQCell"];

    [self loadData];

    //用这种方式获取服务器返回的文件，因为直接获取解压后的文件，会有包含隐藏文件，暂不知道如何去除
    NSArray* urlArray =  [[NSBundle mainBundle] URLsForResourcesWithExtension:@"lua" subdirectory:@"XQOnlineLuas"];
    NSMutableArray* nameArray = [[NSMutableArray alloc] init];
    for( int i =0; i<urlArray.count; i++ ) {
        NSURL* url = urlArray[i];
        NSString* name = [url relativeString];
        [nameArray addObject:name];
    }
    p_keys = p_values = [NSArray arrayWithArray:nameArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{
    NSString *urlStr = luaResourceUrlStr;
    NSString *saveZipFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"XQOnlineLuas.zip"];
    NSString *saveUnzipFilePath = [[NSBundle mainBundle] bundlePath];

    BOOL loadZipSucess = [XQDataHelper loadZipLuaFilesWithUrl:urlStr savePath:saveZipFilePath];
    if (loadZipSucess) {
        NSArray *ary = [XQDataHelper unzipFileWithFilePath:saveZipFilePath path:saveUnzipFilePath];
        if (ary) {
            NSLog(@"解压成功，解压的文件是：\n %@",ary);
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [p_keys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XQCell" forIndexPath:indexPath];
    cell.textLabel.text = p_keys[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

    ViewType type = ViewType_nativeDowloadLua;
    NSString *luaName = p_values[row];
    if (![luaName hasSuffix:@".lua"]) {
        luaName = [luaName stringByAppendingString:@".lua"];
    }

    XQLuaViewController *controller = [[XQLuaViewController alloc]initWithType:type luaName:luaName];
    controller.title = p_keys[row];
    [self.navigationController pushViewController:controller animated:YES];

}

@end
