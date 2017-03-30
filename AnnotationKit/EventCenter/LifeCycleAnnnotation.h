//
//  LifeCycleAnnnotation.h
//  Pods
//
//  Created by luoqihsneg on 2016/11/5.
//
//

#import <Foundation/Foundation.h>
#import "AKEngine.h"


#ifndef When

#define AppLaunched
#define AppResignActive
#define AppBecameActive
#define AppEnterForeground
#define AppEnterBackground
#define AppWillTerminate
#define AppFirstLaunched            

#define When(event,cls,selector) \
class AKEngine; char * const NameGen(event,cls,selector) AnnotationDATA(eventkit) = "{\"cls\":\""#cls"\",\"sel\":\""#selector"\",\"event\":\""#event"\"}";
#endif
