//
//  PHAnnotationHandler.m
//  Pods
//
//  Created by luoqihsneg on 2017/1/13.
//
//

#import "PHAnnotationHandler.h"

@interface PHAnnotationHandler ()
@end

static NSMutableDictionary * _sharedInstances = nil;
@implementation PHAnnotationHandler

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstances = [NSMutableDictionary dictionary];
    });
    
    __kindof PHAnnotationHandler *instance = nil;
    @synchronized (self) {
        NSString *instanceClass = NSStringFromClass(self);
        // Looking for existing instance
        instance = [_sharedInstances objectForKey:instanceClass];
        if (!instance) {
            instance = [[self alloc] init];
            [_sharedInstances setObject:instance forKey:instanceClass];
        }
    }
    
    return instance;
}
- (void)handleAnnotationConfig:(NSArray<NSString *>*)configs
{
    @throw [NSException exceptionWithName:@"PHAnnotation Exception" reason:[NSString stringWithFormat:@"you have should override @selector(handleAnnotationConfig:) in %@",[self class]] userInfo:nil];
}
@end
