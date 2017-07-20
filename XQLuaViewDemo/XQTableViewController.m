//
//  XQTableViewController.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/20.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQTableViewController.h"
#import "XQLuaViewController.h"
#import "XQLuaViewCoreViewController.h"
#import "XQDownloadFilesController.h"

@interface XQTableViewController ()
{
    NSArray *p_keys;
    NSArray *p_values;
}
@end

@implementation XQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"LuaView";

    p_keys = @[@[@"Native+lua UI",
                 @"All lua UI",
                 @"All lua UI（CustomUI）"],
               @[@"LuaViewCore"],
               @[@"NativeDownLoadFiles",
                 @"LuaDownLoadFiles"]];

    p_values = @[@[@"XQHalfLua",
                   @"XQAllLua",
                   @"XQAllLuaAndCustomUI"],
                 @[@"XQLuaViewCore"],
                 @[@"NativeDownLoadFiles",
                   @"XQLuaLoad"]];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"XQCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return p_keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [p_keys[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XQCell" forIndexPath:indexPath];
    cell.textLabel.text = p_keys[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    ViewType type = 3*section + row;
    NSString *luaName = p_values[section][row];
    luaName = [luaName stringByAppendingString:@".lua"];

    if (section == 0) {
        XQLuaViewController *controller = [[XQLuaViewController alloc]initWithType:type luaName:luaName];
        controller.title = p_keys[section][row];
        [self.navigationController pushViewController:controller animated:YES];

    }
    else if (section == 1) {
        XQLuaViewCoreViewController *controller = [[XQLuaViewCoreViewController alloc]initWithLuaName:luaName];
        controller.title = p_keys[section][row];
        [self.navigationController pushViewController:controller animated:YES];

    }
    else{
        if (row == 0) {
            XQDownloadFilesController *controller = [[XQDownloadFilesController alloc]initWithStyle:UITableViewStyleGrouped];
            controller.title = p_keys[section][row];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else{
            XQLuaViewController *controller = [[XQLuaViewController alloc]initWithType:type luaName:luaName];
            controller.title = p_keys[section][row];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }

}
@end
