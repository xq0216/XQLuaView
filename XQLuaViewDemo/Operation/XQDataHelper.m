//
//  XQRequestHelper.m
//  XQLuaViewDemo
//
//  Created by LaiXuefei on 2017/6/30.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQDataHelper.h"
#import "ZipArchive.h"

@implementation XQDataHelper

/**
 获取服务器的lua脚本压缩包

 @param urlStr 脚本资源链接
 @param savePath 保存到本地的地址
 @return YES：下载且保存到指定目录成功 NO：下载失败或者保存失败
 */
+ (BOOL)loadZipLuaFilesWithUrl:(NSString *)urlStr savePath:(NSString *)savePath{
    if (urlStr.length == 0 || savePath.length == 0) {
        return NO;
    }
    BOOL sucess = NO;
    NSURL    *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                                       error:&error];
    if (data != nil){
        NSLog(@"下载成功");
        NSString *filePath = savePath;
        sucess = [data writeToFile:filePath atomically:YES];
    } else {
        NSLog(@"%@", error);
        
    }
    return sucess;
}

+ (NSArray *)unzipFileWithFilePath:(NSString *)zipFilePath path:(NSString *)unzipFilePath{
    BOOL sucess = NO;
    ZipArchive *zip = [[ZipArchive alloc] init];
    if ([zip UnzipOpenFile:zipFilePath]) {
        sucess = [zip UnzipFileTo:unzipFilePath overWrite:YES];
        if (!sucess) {
            [zip UnzipCloseFile];
        }
    }
    if (sucess) {
        NSLog(@"解压保存成功.");
        return [zip getZipFileContents];
    }
    else{
        NSLog(@"解压保存失败.");
        return nil;
    }
}
@end
