//
//  XQRegisterManager.h
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/19.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lua.h"

@interface XQRegisterManager : NSObject

/**
  自定义类的注册管理

 @param luaState 状态机
 */
+(void)registerClassWithLuaState:(lua_State*)luaState;
@end
