//
//  AKRouteAnnotaion.m
//  Pods
//
//  Created by luoqihsneg on 2016/11/5.
//
//

#import "AKRouteAnnotation.h"
#import "NSDictionary+AnnotationKit.h"
#import "AKRouter.h"
@interface AKRouteAnnotation ()
@property (nonatomic,strong)NSMutableArray *configs;
@end

@DefineAnnotation(AKRouteAnnotation,route)
@implementation AKRouteAnnotation
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configs = [NSMutableArray array];
    }
    return self;
}

- (void)handleAnnotationConfig:(NSArray<NSString *> *)configs {
    for (NSString *map in configs) {
        NSData *jsonData =  [map dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            
            if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count == 1) {
                NSString *clsName = [[json allKeys] firstObject];
                NSString *url = [json akSafeObjectForKey:clsName];
                if (clsName && url) {
                    [[AKRouter shared]map:url toControllerClass:NSClassFromString(clsName)];
                    [self.configs addObject:@{url:clsName}];
                }
            }
            
        }
    }
}
@end

@DefineAnnotation(AKNPCAnnotation,npc)
@implementation AKNPCAnnotation
- (void)handleAnnotationConfig:(NSArray<NSString *> *)configs
{
    for (NSString *map in configs) {
        NSData *jsonData =  [map dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count == 3) {
                NSString *clsName = [json akSafeObjectForKey:@"cls_name"];
                NSString *selName = [json akSafeObjectForKey:@"sel_name"];
                NSString *url = [json akSafeObjectForKey:@"url"];
                
                Class cls  = NSClassFromString(clsName);
                SEL   sel  = NSSelectorFromString([NSString stringWithFormat:@"%@:",selName]);
                
                if ([cls respondsToSelector:sel] && url) {
                    
                    [[AKRouter shared]map:url toBlock:(id)^(NSDictionary *params) {
                        id ret = ((id (*)(id, SEL,NSDictionary *))[cls methodForSelector:sel])(cls, sel,params);
                        return ret;
                    }];
                }
            }            
        }
    }
    
}
@end
