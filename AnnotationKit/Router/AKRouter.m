//
//  AKRouter.m
//  Pods
//
//  Created by luoqihsneg on 2017/3/30.
//
//

#import "AKRouter.h"
#import <HHRouter/HHRouter.h>
@implementation AKRouter

+ (instancetype)shared
{
    static AKRouter *router = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        router = [[self alloc] init];
    });
    return router;
}
    
    
- (UIViewController *)matchController:(NSString *)route
{
    return [[HHRouter shared]matchController:route];
}
    
- (void)routeTo:(NSString *)route
{
    UIViewController *vc = [self matchController:route];
    [[self topViewController].navigationController pushViewController:vc animated:YES];
}
    
- (BOOL)canRoute:(NSString *)route
{
    HHRouteType ret= [[HHRouter shared]canRoute:route];
    
    return (ret != HHRouteTypeNone);
}

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass
{
    [[HHRouter shared]map:route toControllerClass:controllerClass];
}
    
    
    
- (UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
    
- (UIViewController *)topViewController:(UIViewController *)rootViewController
    {
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)rootViewController;
            return [self topViewController:[navigationController.viewControllers lastObject]];
        }
        if ([rootViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabController = (UITabBarController *)rootViewController;
            return [self topViewController:tabController.selectedViewController];
        }
        if (rootViewController.presentedViewController) {
            return [self topViewController:rootViewController];
        }
        return rootViewController;
    }
@end
