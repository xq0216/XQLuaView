//
//  XQItemView.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/7.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQItemLuaView.h"

#import "LVImage.h"
#import "LVStyledString.h"
#import "LVBaseView.h"
#import "LVUtil.h"
#import "LVStruct.h"

#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat imageMinHeightWidth = 36;
static const CGFloat iconImageToTitleVerSpace = 10;
static const CGFloat titleLabelToHorBorder = 2;

@interface XQItemLuaView ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XQItemLuaView

- (void)dealloc{
    [self.lv_luaviewCore releaseLuaView];
}

-(id) init:(lua_State*) l{
    self = [super init];
    if( self ){
        self.lv_luaviewCore = LV_LUASTATE_VIEW(l);
        [self initSubViews];
    }
    return self;
}


#pragma mark - UI
- (void) initSubViews {

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:self.iconImageView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.titleLabel];

//    self.iconImageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
//    self.backgroundColor = [UIColor yellowColor];
}

- (void) refreshSubViewFrames {
    //adjust image and label postion
    self.titleLabel.preferredMaxLayoutWidth = self.bounds.size.width - 2*titleLabelToHorBorder;
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width-2*titleLabelToHorBorder, 0);
    [self.iconImageView sizeToFit];
    [self.titleLabel sizeToFit];

    //aptotic size
    CGSize imageSize = CGSizeMake(imageMinHeightWidth, imageMinHeightWidth);

    CGSize titleLabelSize = CGSizeMake(MIN(self.titleLabel.bounds.size.width, self.bounds.size.width-2*titleLabelToHorBorder), self.titleLabel.bounds.size.height);
    CGSize contentViewSize = self.bounds.size;

    CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    imageFrame.origin.x = (contentViewSize.width - imageSize.width) / 2;
    if (self.titleLabel.text.length > 0) {
        imageFrame.origin.y = (contentViewSize.height - imageSize.height - iconImageToTitleVerSpace - titleLabelSize.height) / 2;
    } else {
        imageFrame.origin.y = (contentViewSize.height - imageSize.height) / 2;
    }
    imageFrame.origin.y = (imageFrame.origin.y < 0)?0:imageFrame.origin.y;

    self.iconImageView.frame = imageFrame;

    CGRect titleFrame = CGRectMake(0, 0, titleLabelSize.width, titleLabelSize.height);
    titleFrame.origin.x =  (contentViewSize.width - titleLabelSize.width) / 2;
    titleFrame.origin.y = imageFrame.origin.y+imageFrame.size.height + iconImageToTitleVerSpace;
    self.titleLabel.frame = titleFrame;
    
}

-(void) setImageByName:(NSString*) imageName{
    if( imageName==nil )
        return;

    if( [LVUtil isExternalUrl:imageName] ){
       [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageName]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       [self refreshSubViewFrames];
       }];
    } else {
        // local Image
        UIImage* image = [UIImage imageNamed:imageName];
        self.iconImageView.image = image;
        [self refreshSubViewFrames];
    }
}

#pragma mark - LVClassProtocal
+(int) lvClassDefine:(lua_State *)L globalName:(NSString*) globalName{
    [LVUtil reg:L clas:self cfunc:lvNewItem globalName:globalName defaultName:@"XQItemLuaView"];

    const struct luaL_Reg memberFunctions [] = {
        {"frame",   setFrame},
        {"image",   setIconImage},
        {"title",   title},

        {NULL, NULL}
    };

    lv_createClassMetaTable(L,META_TABLE_CustomView);

    luaL_openlib(L, NULL, [LVBaseView baseMemberFunctions], 0);
    luaL_openlib(L, NULL, memberFunctions, 0);

    const char* keys[] = { "addView", NULL};// 移除多余API
    lv_luaTableRemoveKeys(L, keys );
    
    return 1;
    
}

#pragma mark - C function
//c函数，初始化itemView
static int lvNewItem (lua_State *L){
    Class c = [LVUtil upvalueClass:L defaultClass:[XQItemLuaView class]];

    {
        XQItemLuaView* customView = [[c alloc] init:L];
        {
            NEW_USERDATA(userData, View);
            userData->object = CFBridgingRetain(customView);
            customView.lv_userData = userData;

            luaL_getmetatable(L, META_TABLE_CustomView );
            lua_setmetatable(L, -2);
        }
        LuaViewCore* father = LV_LUASTATE_VIEW(L);
        if( father ){
            [father containerAddSubview:customView];
        }
    }
    return 1; /* new userdatum is already on the stack */
}

//c函数，设置frame
static int setFrame (lua_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lua_touserdata(L, 1);
    if( user ){
        XQItemLuaView* view = (__bridge XQItemLuaView *)(user->object);
        if( view ){
            CGRect r = view.frame;
            if( lua_gettop(L)>=2 ) {
                if ( lua_isuserdata(L, 2) ) {
                    LVUserDataInfo* user = lua_touserdata(L, 2);
                    if ( LVIsType(user, Struct) ) {
                        LVStruct* stru = (__bridge LVStruct *)(user->object);
                        if( [stru dataPointer] ) {
                            memcpy(&r, [stru dataPointer], sizeof(CGRect));
                        }
                    } else {
                        LVError(@"XQItemLuaView.setFrame1");
                    }
                } else {
                    if( lua_isnumber(L, 2) ){
                        r.origin.x = lua_tonumber(L, 2);// 2
                    }
                    if( lua_isnumber(L, 3) ){
                        r.origin.y = lua_tonumber(L, 3);// 3
                    }
                    if( lua_isnumber(L, 4) ){
                        r.size.width = lua_tonumber(L, 4);// 4
                    }
                    if( lua_isnumber(L, 5) ){
                        r.size.height = lua_tonumber(L, 5);// 5
                    }
                }
                if( isnan(r.origin.x) || isnan(r.origin.y) || isnan(r.size.width) || isnan(r.size.height) ){
                    LVError(@"XQItemLuaView.setFrame2: %s", NSStringFromCGRect(r) );
                } else {
                    view.frame = r;
                    [view refreshSubViewFrames];
                }
                view.lv_align = 0;
                return 0;
            } else {
                lua_pushnumber(L, r.origin.x    );
                lua_pushnumber(L, r.origin.y    );
                lua_pushnumber(L, r.size.width  );
                lua_pushnumber(L, r.size.height );
                return 4;
            }
        }
    }
    return 0;

}

//c函数，设置图片
static int setIconImage (lua_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lua_touserdata(L, 1);
    int returnNum = 0;
    if( user ){
        NSString* normalImage = lv_paramString(L, 2);// 2
        XQItemLuaView* cell = (__bridge XQItemLuaView *)(user->object);
        if( [cell isKindOfClass:[XQItemLuaView class]] ){
            [cell setImageByName:normalImage];
            lua_pushvalue(L, 1);
            returnNum = 1;
        }
    }
    return returnNum;
}

//c函数，设置标题
static int title (lua_State *L) {
    int returnNum = 0;

    LVUserDataInfo * user = (LVUserDataInfo *)lua_touserdata(L, 1);
    if( user ){
        XQItemLuaView* cell = (__bridge XQItemLuaView *)(user->object);
        if( [cell isKindOfClass:[XQItemLuaView class]] ){
            if( lua_gettop(L)>=2 ) {
                if ( lua_isnoneornil(L, 2 ) ) {
                    cell.titleLabel.text = nil;
                    [cell refreshSubViewFrames];
                } else if( lua_type(L, 2)==LUA_TNUMBER ){
                    CGFloat text = lua_tonumber(L, 2);// 2
                    cell.titleLabel.text = [NSString stringWithFormat:@"%f",text];
                } else if( lua_type(L, 2)==LUA_TSTRING ){
                    NSString* text = lv_paramString(L, 2);// 2
                    cell.titleLabel.text = text;
                } else if( lua_type(L, 2)==LUA_TUSERDATA ){
                    LVUserDataInfo * user2 = lua_touserdata(L, 2);// 2
                    if( user2 && LVIsType(user2, StyledString) ) {
                        LVStyledString* attString = (__bridge LVStyledString *)(user2->object);
                        [cell.titleLabel setAttributedText:attString.mutableStyledString];
                    }
                }
            } else {
                NSString* text = cell.titleLabel.text;
                lua_pushstring(L, text.UTF8String);
                returnNum = 1;
            }
        }
        [cell refreshSubViewFrames];
    }

    return returnNum;
}

@end
