//
//  UIViewController+Router.m
//  VIRouterKit
//
//  Created by Vienta on 2016/9/29.
//  Copyright © 2016年 Vienta. All rights reserved.
//

#import "UIViewController+Router.h"

@implementation UIViewController (Router)

/**
 Overwrite
 */
- (NSDictionary *)customPropertyMapper
{
    return nil;
}

- (BOOL)needInNavigationController
{
    return NO;
}

@end
