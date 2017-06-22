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
               @[@"LuaViewCore"]];

    p_values = @[@[@"XQHalfLua",
                   @"XQAllLua",
                   @"XQAllLuaAndCustomUI"],
                 @[@"XQLuaViewCore"]];

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
    else{
        XQLuaViewCoreViewController *controller = [[XQLuaViewCoreViewController alloc]initWithLuaName:luaName];
        controller.title = p_keys[section][row];
        [self.navigationController pushViewController:controller animated:YES];

    }

    }
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
