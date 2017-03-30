//
//  AKRouter.h
//  Pods
//
//  Created by luoqihsneg on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
@interface AKRouter : NSObject
+ (instancetype)shared;
- (UIViewController *)matchController:(NSString *)route;
- (void)routeTo:(NSString *)route;
- (BOOL)canRoute:(NSString *)route;
- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
    
@end

///--------------------------------
/// @name UIViewController Category
///--------------------------------

@interface UIViewController (AKRouter)
    
@property (nonatomic, strong) NSDictionary *params;

@end
