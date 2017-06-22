//
//  XQImage.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/21.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQImage.h"
#import "LVHeads.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation XQImage

-(void) setWebImageUrl:(NSURL*) url finished:(LVLoadFinished) finished{
    
    [self sd_setImageWithURL:url];
}
@end
