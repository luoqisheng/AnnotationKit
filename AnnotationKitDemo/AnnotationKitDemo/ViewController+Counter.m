//
//  ViewController+Counter.m
//  AnnotationKitDemo
//
//  Created by bytedance on 2018/10/24.
//  Copyright © 2018 com.luoqisheng.annotationkit. All rights reserved.
//

#import "ViewController+Counter.h"
#import <AnnotationKit/LifeCycleAnnnotation.h>

@implementation ViewController (Counter)

@When(AppLaunched, ViewController, @selector(counterExample:))
+ (void)counterExample:(NSNotification *)note {
    NSLog(@"counterExample");
}

@end
