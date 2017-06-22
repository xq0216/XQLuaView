//
//  XQLuaViewCoreViewController.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/21.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQLuaViewCoreViewController.h"
#import <LuaViewCore.h>
#import "XQRegisterManager.h"

@interface XQLuaViewCoreViewController ()
{
    NSString *currentLuaName;
}
@property(nonatomic,strong)LuaViewCore *lvCore;
@end

@implementation XQLuaViewCoreViewController

- (void)dealloc{
    [self.lvCore releaseLuaView];
}

- (instancetype)initWithLuaName:(NSString *)luaName
{
    self = [super initWithNibName:@"XQLuaViewCoreViewController" bundle:nil];
    if (self) {
        currentLuaName = luaName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;

    self.lvCore = [[LuaViewCore alloc]init];
    [XQRegisterManager registerClassWithLuaState:self.lvCore.l];


    if (currentLuaName) {
        [self.lvCore runFile:currentLuaName];

        //lua中，方法的定义是放在运行时的，而非编译时，故此处必须 run ，否则只 load，下面调用方法会返回错误：function is nil error
        [self.lvCore runFile:@"XQLuaViewCore.lua"];
        //    [self.lvCore loadFile:@"XQLuaViewCore.lua"];

        NSString *str0 = [self.lvCore callLua:@"topViewUI" environment:self.topView args:nil];
        NSLog(@"%@",str0?str0:@"LuaViewCore-topViewUI-sucessed");

        NSString *str1 = [self.lvCore callLua:@"bottomViewUI" environment:self.bottomView args:nil];
        NSLog(@"%@",str1?str1:@"LuaViewCore-bottomViewUI-sucessed");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
