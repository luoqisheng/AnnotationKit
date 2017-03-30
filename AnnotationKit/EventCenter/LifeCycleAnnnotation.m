//
//  LifeCycleAnnnotation.m
//  Pods
//
//  Created by luoqihsneg on 2016/11/5.
//
//

#import "LifeCycleAnnnotation.h"
#import "NSDictionary+AnnotationKit.h"



//section 是这个注解的配置来源，无需加双引号
//handler 是获取注解配置的地方。
@DefineAnnotation(LifeCycleAnnnotation,eventkit)
@interface LifeCycleAnnnotation : PHAnnotationHandler

@property (nonatomic,strong)NSMutableArray *AppLaunchedHandler;
@property (nonatomic,strong)NSMutableArray *AppResignActiveHandler;
@property (nonatomic,strong)NSMutableArray *AppBecameActiveHandler;
@property (nonatomic,strong)NSMutableArray *AppToForegroundHandler;
@property (nonatomic,strong)NSMutableArray *AppToBackgroundHandler;
@property (nonatomic,strong)NSMutableArray *AppFirstLaunchedHandler;


@end



static NSString *const AppLaunchedEventName      = @"AppLaunched";
static NSString *const AppResignActiveEventName  = @"AppResignActive";
static NSString *const AppBecameActiveEventName  = @"AppBecameActive";
static NSString *const AppToForegroundEventName  = @"AppEnterForeground";
static NSString *const AppToBackgroundEventName  = @"AppEnterBackground";
static NSString *const AppFirstLaunchedEventName = @"AppFirstLaunched";


@implementation LifeCycleAnnnotation
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.AppLaunchedHandler      = [NSMutableArray array];
        self.AppResignActiveHandler  = [NSMutableArray array];
        self.AppBecameActiveHandler  = [NSMutableArray array];
        self.AppToForegroundHandler  = [NSMutableArray array];
        self.AppToBackgroundHandler  = [NSMutableArray array];
        self.AppFirstLaunchedHandler = [NSMutableArray array];
        
        

        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onLifeCycleCallBack:)
                                                    name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onLifeCycleCallBack:)
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];

        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onLifeCycleCallBack:)
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onLifeCycleCallBack:)
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];

        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(onLifeCycleCallBack:)
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];

    }
    return self;
}

- (void)handleAnnotationConfig:(NSArray<NSString *> *)configs
{
    for (NSString *map in configs) {
        NSData *jsonData =  [map dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                NSString *clsName = [json akSafeObjectForKey:@"cls"];
                NSString *sel     = [json akSafeObjectForKey:@"sel"];
                NSString *event = [json akSafeObjectForKey:@"event"];
                
                if ([event isEqualToString:AppLaunchedEventName]) {
                    [self.AppLaunchedHandler addObject:@{clsName:sel}];
                }
                
                if ([event isEqualToString:AppResignActiveEventName]) {
                    [self.AppResignActiveHandler addObject:@{clsName:sel}];
                }
                
                if ([event isEqualToString:AppBecameActiveEventName]) {
                    [self.AppBecameActiveHandler addObject:@{clsName:sel}];
                }
                
                if ([event isEqualToString:AppToForegroundEventName]) {
                    [self.AppToForegroundHandler addObject:@{clsName:sel}];
                }
                
                if ([event isEqualToString:AppToBackgroundEventName]) {
                    [self.AppToBackgroundHandler addObject:@{clsName:sel}];
                }
                
                if ([event isEqualToString:AppFirstLaunchedEventName]) {
                    [self.AppFirstLaunchedHandler addObject:@{clsName:sel}];
                }
                
                
            }
            
        }
    }
}
         
#pragma mark - notification
- (void)onLifeCycleCallBack:(NSNotification *)note
{
    @synchronized (self) {
        
        NSMutableArray *dispatcher = nil;
        if ([note.name isEqualToString:UIApplicationDidFinishLaunchingNotification]) {
            dispatcher = self.AppLaunchedHandler;
        }
        
        if ([note.name isEqualToString:UIApplicationWillResignActiveNotification]) {
            dispatcher = self.AppResignActiveHandler;
        }
        
        if ([note.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
            dispatcher = self.AppBecameActiveHandler;
        }
        
        if ([note.name isEqualToString:UIApplicationWillEnterForegroundNotification]) {
            dispatcher = self.AppToForegroundHandler;
        }
        
        if ([note.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
            dispatcher = self.AppToBackgroundHandler;
        }
        
        
        
        for (NSDictionary *map in dispatcher) {
            NSString *clsName = [[map allKeys]firstObject];
            if (clsName && [map akSafeObjectForKey:clsName]) {
                Class cls = NSClassFromString(clsName);
                NSString *selName = [NSString stringWithFormat:@"%@:",[map akSafeObjectForKey:clsName]];
                SEL sel   = NSSelectorFromString(selName);
                
                if ([cls respondsToSelector:sel]) {
                    ((void (*)(id, SEL,NSNotification *))[cls methodForSelector:sel])(cls, sel,note);
                }
            }
            
        }
        
    }
}

@end
