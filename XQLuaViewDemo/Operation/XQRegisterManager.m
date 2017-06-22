//
//  XQRegisterManager.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/19.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQRegisterManager.h"
#import "XQItemLuaView.h"

@implementation XQRegisterManager
/**
 自定义类的注册管理

 @param luaState 状态机
 */
+(void)registerClassWithLuaState:(lua_State*)luaState{
    [XQItemLuaView lvClassDefine:luaState globalName:@"XQItemLuaView"];
}
@end
