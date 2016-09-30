//
//  VIRouterKit.m
//  VIRouterKit
//
//  Created by Vienta on 2016/9/29.
//  Copyright © 2016年 Vienta. All rights reserved.
//

#import "VIRouterKit.h"
#import <UIKit/UIKit.h>
#import "UIViewController+Router.h"

@interface VIRouterKit ()

@property (strong, nonatomic) NSDictionary *routerMapper;

@end

@implementation VIRouterKit

+ (instancetype)sharedInstance
{
    static VIRouterKit *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc]init];
    });
    
    return _sharedInstance;
}


// scheme://alias?param1=value1&param2=value2  建议以url形式
- (void)openUrl:(NSString *)url delegate:(id)delegate
{
    NSRange fromClsAliasRange = [url rangeOfString:@"://"];
    NSRange toClsAliasRange = [url rangeOfString:@"?"];
    
    if (!fromClsAliasRange.length || !toClsAliasRange.length) {
        return;
    }
    
    
    
    NSUInteger from = fromClsAliasRange.location + fromClsAliasRange.length;
    NSUInteger to = toClsAliasRange.location;
    NSUInteger length = to - from;
    
    NSString *schema = [url substringToIndex:fromClsAliasRange.location];
    if (!self.schema) {
        self.schema = schema;
    }
    NSAssert([self.schema isEqualToString:schema], @"schema需要和app的schema保持一致");
    
    NSString *clsAlias = [url substringWithRange:NSMakeRange(from, length)];
    
    NSString *properties = [url substringFromIndex:to + 1];
    NSArray *propertyPairs = [properties componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *propertiesMapper = [[NSMutableDictionary alloc] init];
    
    for (NSString *property in propertyPairs) {
        NSArray *propertyPair = [property componentsSeparatedByString:@"="];
        [propertiesMapper setObject:propertyPair[1] forKey:propertyPair[0]];
    }
    
    [self openCls:clsAlias parmas:propertiesMapper delegate:delegate];
}


- (void)openNoneSchemaUrl:(NSString *)url delegate:(id)delegate
{
    
}

- (void)openCls:(NSString *)clsName parmas:(NSDictionary *)parmas delegate:(id)delegate
{
    NSString *className = [self classNameFromClassAlias:clsName];
    if (!className) {
        className = clsName;
    }
    
    Class viewControllerClass = NSClassFromString(className);
    if (!viewControllerClass) {
        NSLog(@"类 %@ 不存在", className);
        return;
    }
    
    UIViewController *viewController = [[viewControllerClass alloc] init];
    
    NSDictionary *customPropertyMapper = [viewController customPropertyMapper];
    
    NSMutableDictionary *propertyMapper = [[NSMutableDictionary alloc] init];
    
    if (customPropertyMapper) {
        for (NSString *key in parmas) {
            NSString *actualPropertyKey = [customPropertyMapper objectForKey:key];
            if (actualPropertyKey) {
                [propertyMapper setValue:[parmas objectForKey:key] forKey:actualPropertyKey];
            } else {
                [propertyMapper setValue:[parmas objectForKey:key] forKey:key];
            }
        }
    } else {
        [propertyMapper setValuesForKeysWithDictionary:parmas];
    }
    
    for (NSString *key in [propertyMapper allKeys]) {
        if ([viewController respondsToSelector:@selector(key)]) {
            [viewController setValue:[propertyMapper objectForKey:key] forKey:key];
        }
    }
    
    
}

- (NSString *)classNameFromClassAlias:(NSString *)clsAlias
{
    if (self.routerMapper) {
        return [self.routerMapper objectForKey:clsAlias];
    }
    
    if (self.clsAliasConfigFileName) {
        NSString *fileSuffix = [[self.clsAliasConfigFileName componentsSeparatedByString:@"."] lastObject];
        NSString *fileName = [[self.clsAliasConfigFileName componentsSeparatedByString:@"."] firstObject];
        NSAssert([fileSuffix isEqualToString:@"plist"], @"目前仅支持plist文件");
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileSuffix];
        self.routerMapper = [[NSDictionary alloc] initWithContentsOfFile:filePath];
 
        return [self.routerMapper objectForKey:clsAlias];
    }
    
    return nil;
}


@end
