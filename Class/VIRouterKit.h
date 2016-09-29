//
//  VIRouterKit.h
//  VIRouterKit
//
//  Created by Vienta on 2016/9/29.
//  Copyright © 2016年 Vienta. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 VIRouterKit以单例的模式进行配置和调用
 */
@interface VIRouterKit : NSObject

/**
 app的schema
 */
@property (nonatomic, copy) NSString *schema;

/**
 类别名配置文件名称 需带上文件后缀名
 */
@property (nonatomic, copy) NSString *clsAliasConfigFileName;

/**
 类别名配置文件所在的文件夹目录
 */
@property (nonatomic, copy) NSString *clsAliasConfigFileFolder;

/**
 类别名配置文件存放的目录
 */
@property (nonatomic, copy) NSString *clsAliasConfigFilePath;


- (instancetype)sharedInstance;

// scheme://alias?param1=value1&param2=value2  建议以url形式
- (void)openUrl:(NSString *)url delegate:(id)delegate;

- (void)openCls:(NSString *)clsName parmas:(NSDictionary *)parmas delegate:(id)delegate;


@end
