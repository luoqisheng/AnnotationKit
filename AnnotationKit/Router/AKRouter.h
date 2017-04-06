//
//  AKRouter.h
//  Pods
//
//  Created by luoqihsneg on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

typedef id (^AKRouterBlock)(NSDictionary *params);


@interface AKRouter : NSObject
+ (instancetype)shared;
- (UIViewController *)matchController:(NSString *)route;
- (void)routeTo:(NSString *)route;
- (BOOL)canRoute:(NSString *)route;
- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route toBlock:(AKRouterBlock)block;

@end

///--------------------------------
/// @name UIViewController Category
///--------------------------------

@interface UIViewController (AKRouter)
    
@property (nonatomic, strong) NSDictionary *params;

@end
