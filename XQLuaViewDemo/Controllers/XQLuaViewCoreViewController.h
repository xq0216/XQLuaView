//
//  XQLuaViewCoreViewController.h
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/21.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQLuaViewCoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

- (instancetype)initWithLuaName:(NSString *)luaName;
@end
