//
//  XQLuaViewController.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/20.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQLuaViewController.h"
#import "XQRegisterManager.h"
#import "XQItemLuaView.h"
#import "XQImage.h"

#import <LView.h>
#import <LuaViewCore.h>

#import <SDWebImage/SDImageCache.h>

@interface XQLuaViewController ()
{
    ViewType p_currentType;
    NSString *currentLuaName;
}

@property(nonatomic,strong) LView *lv;

@end

@implementation XQLuaViewController

- (void)dealloc{
    [self.lv releaseLuaView];
}

- (instancetype)initWithType:(ViewType)type luaName:(NSString *)luaName{
    self = [super initWithNibName:@"XQLuaViewController" bundle:nil];
    if (self) {
        p_currentType = type;
        currentLuaName = luaName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    if (p_currentType == ViewType_allLuaAndCustomUI) {
        //界面消失清理图片缓存,便于观察网络图片下载
        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        [imageCache clearMemory];
        [imageCache clearDisk];
    }

}
- (void)viewDidLayoutSubviews{

    [self setLuaViewUI];

    [self runLua];
}


/**
 初始化 LuaView UI
 */
- (void)setLuaViewUI{

    CGRect lvRect = self.view.bounds;
    lvRect.origin = CGPointZero;

    //若界面全是由lua控制渲染，则全屏
    if (p_currentType == ViewType_halfLua) {
        lvRect.origin.y = CGRectGetHeight(_imgView.bounds)+10;
        lvRect.size.height -= CGRectGetHeight(_imgView.bounds)+10;
    }
    else{
        _imgView.hidden = YES;
    }

    self.lv = [[LView alloc] initWithFrame:lvRect];
    self.lv.backgroundColor = [UIColor yellowColor];

    //若为自定义控件，则需要注册
    if (p_currentType == ViewType_allLuaAndCustomUI) {
        [self registerCustomClass];
    }

    //由于lua语法升级，若是老语法，则设置YES，将 . --> : ，若新语法，勿设，默认NO
    //    self.lv.changeGrammar = YES;

    //指定Controller
    self.lv.viewController = self;

    [self.view addSubview:self.lv];
}


/**
 自定义类注册到lua
 */
- (void)registerCustomClass{
    //完全自定义控件的注册
    [XQRegisterManager registerClassWithLuaState:self.lv.luaviewCore.l];

    //继承自luaviewUI控件的覆盖注册
    self.lv[@"Image"] = [XQImage class];
}


/**
 运行当前lua
 */
- (void)runLua{
   [self.lv runFile: currentLuaName];
}

@end
