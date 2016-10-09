//
//  VIRouterKit.h
//  VIRouterKit
//
//  Created by Vienta on 2016/9/29.
//  Copyright © 2016年 Vienta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


+ (instancetype)sharedInstance;


/**
 类名和类的别名的映射
 */
- (void)setClassAliasConfig:(NSDictionary *)clsAliasConfigMapper;

// scheme://alias?param1=value1&param2=value2  建议以url形式
- (void)openUrl:(NSString *)url delegate:(UIViewController *)delegate;


/**
 打开不带scheme的url  alias?param1=value1&param2=value2  建议以url形式
 */
- (void)openNoneSchemaUrl:(NSString *)url delegate:(UIViewController *)delegate;

/**
 以类名的方式跳转

 @param clsName  类名
 @param parmas   参数
 @param delegate 代理ViewController
 */
- (void)openCls:(NSString *)clsName parmas:(NSDictionary *)parmas delegate:(UIViewController *)delegate;


@end
