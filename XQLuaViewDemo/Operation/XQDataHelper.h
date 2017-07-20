//
//  XQRequestHelper.h
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/30.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQDataHelper : NSObject

/**
 获取服务器的lua脚本压缩包

 @param urlStr 脚本资源链接
 @param savePath 保存到本地的地址
 @return YES：下载且保存到指定目录成功 NO：下载失败或者保存失败
 */
+ (BOOL)loadZipLuaFilesWithUrl:(NSString *)urlStr savePath:(NSString *)savePath;


/**
 解压缩文件包

 @param zipFilePath 待解压的文件存储路径
 @param unzipFilePath 解压的文件存储路径
 @return 解压后的文件数组
 */
+ (NSArray *)unzipFileWithFilePath:(NSString *)zipFilePath path:(NSString *)unzipFilePath;
@end
