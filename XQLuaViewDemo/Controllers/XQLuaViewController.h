//
//  XQLuaViewController.h
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/20.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewType) {
    ViewType_halfLua = 0,
    ViewType_allLua,
    ViewType_allLuaAndCustomUI,
    ViewType_luaViewCore,
};

@interface XQLuaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (instancetype)initWithType:(ViewType)type luaName:(NSString *)luaName;
@end
