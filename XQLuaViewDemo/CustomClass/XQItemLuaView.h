//
//  XQItemView.h
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/7.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "LuaView.h"
#import "lua.h"

@interface XQItemLuaView : UIView<LVProtocal, LVClassProtocal>

@property(nonatomic,weak) LuaViewCore* lv_luaviewCore;
@property(nonatomic,assign) LVUserDataInfo* lv_userData;

/**
 *  生成class
 *
 *  @param L 状态机
 */
+(int) lvClassDefine:(lua_State *)L globalName:(NSString*) globalName;


@end
