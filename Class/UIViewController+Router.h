//
//  UIViewController+Router.h
//  VIRouterKit
//
//  Created by Vienta on 2016/9/29.
//  Copyright © 2016年 Vienta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Router)

- (NSDictionary *)customPropertyMapper;
- (BOOL)needInNavigationController;

@end
