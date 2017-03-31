# AnnotationKit
The annotation implement by Objective-C

#### 0x00 Abstract

AnnotationKit provide a meta-programming approach,like the annotation in Java. 

#### 0x01 What can it do?

* @when for event  dispatch.  

```objective-c
@When(AppLaunched,ViewController,doLaunched)
+ (void)doLaunched:(NSNotification *)note
{
    NSLog(@"%@",note);
}

@When(AppEnterForeground,ViewController,doEnterForeground)
+ (void)doEnterForeground:(NSNotification *)note
{
    NSLog(@"%@",note);
}

@When(AppEnterBackground,ViewController,doEnterBackground)
+ (void)doEnterBackground:(NSNotification *)note
{
    NSLog(@"%@",note);
}

@When(AppResignActive,ViewController,doResignActive)
+ (void)doResignActive:(NSNotification *)note
{
    NSLog(@"%@",note);
}

@When(AppBecameActive,ViewController,doBecameActive)
+ (void)doBecameActive:(NSNotification *)note
{
    NSLog(@"%@",note);
}
```



* @RequestMapping for url route. 

```objective-c
//ViewController.m
@RequestMapping(ViewController, "prophet://demo/index/")
@implementation ViewController
@end

```



#### 0x03 extendable

1. Subclass the PHAnnotationHandler 

2. use @DefineAnnotation() to define your annotation.

3. override  `-(void)handleAnnotationConfig:(NSArray<NSString *>*)configs;` to gain your meta data

4. an example : Use HHRoute to impl my @RequestMapping

   ```objective-c
   //AKRouteAnnotation.h
   #import <Foundation/Foundation.h>
   #import "AKEngine.h"

   //provides the @RequestMapping
   #ifndef RequestMapping
   #define RequestMapping(name,url) \
   class AKEngine; char *const NameGen(name,_url) AnnotationDATA(route) = "{\""#name"\":"#url"}";
   #endif

   @interface AKRouteAnnotation : PHAnnotationHandler
   @end
   ```

   ​

   ```objective-c
   //AKRouteAnnotaion.m
   #import "AKRouteAnnotaion.h"
   #import "NSDictionary+AnnotationKit.h"
   #import <HHRouter/HHRouter.h>
   @interface AKRouteAnnotaion ()
   @end
    //arg0 :AKRouteAnnotaion for class name, arg1: route which is defined in AnnotationDATA ,
   @DefineAnnotation(AKRouteAnnotaion,route)
   @implementation AKRouteAnnotaion
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
                       [[HHRouter shared]map:url toControllerClass:NSClassFromString(clsName)];
                       [self.configs addObject:@{url:clsName}];
                   }
               }
               
           }
       }
   }
   @end
   ```

#### 0x04 License

* AnnotationKit

  ```
  MIT License

  Copyright (c) 2017 luoqisheng

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  ```

  ​


* libextobjc

  ```
  Copyright (c) Justin Spahr-Summers

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ```

  ​