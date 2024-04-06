//
//  main.m
//  darkMode
//
//  Created by Sriteja Sugoor on 09/01/23.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <objc/runtime.h>

//#include "MobileSafariSettings/SafariSettingsController.h"


@class CPLRUDictionaryNode;

@interface CPLRUDictionary : NSObject {

    CFDictionaryRef _dictionary;
    unsigned long long _maxCount;
    CPLRUDictionaryNode* _head;
    CPLRUDictionaryNode* _tail;

}
+(id)dictionaryWithMaximumCapacity:(unsigned long long)arg1 ;
-(void)_moveNodeToFront:(id)arg1 ;
-(void)removeObjectForKey:(id)arg1 ;
-(void)_removeNode:(id)arg1 ;
-(id)initWithMaximumCapacity:(unsigned long long)arg1 ;
-(void)_addNodeToFront:(id)arg1 ;
-(void)_removeNodeFromLinkedList:(id)arg1 ;
-(void)removeAllObjects;
-(id)allKeys;
-(void)setObject:(id)arg1 forKey:(id)arg2 ;
-(id)objectForKeyWithoutAffectingLRU:(id)arg1 ;
-(id)description;
-(id)objectForKey:(id)arg1 ;
-(unsigned long long)count;
-(id)allKeysInLRUOrder;
-(unsigned long long)linkedListCount;
-(void)dealloc;
-(id)allValuesInLRUOrder;
@end


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
//    [[NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/TipKit.framework"] load];
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    id instance = [[NSClassFromString(@"CPLRUDictionary") alloc] initWithMaximumCapacity:4];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    CPLRUDictionary* dict = [[CPLRUDictionary alloc] initWithMaximumCapacity:4];
#pragma clang diagnostic pop

    [dict setObject:@"1" forKey:@"first"];
    [dict setObject:@"2" forKey:@"second"];
    [dict setObject:@"3" forKey:@"third"];
    [dict setObject:@"4" forKey:@"fourth"];
    [dict objectForKey:@"first"];    // Bump "first" as most recently used.
    [dict setObject:@"5" forKey:@"fifth"];
    [dict setObject:@"6" forKey:@"sixth"];
    unsigned long long hi = 2;
    NSString * a = @"after one day";
    id arged = a;
//    dlopen("/System/Library/Frameworks/SafariServices.framework/SafariServices", RTLD_LAZY);
    void *handle = dlopen("/System/Library/PreferenceBundles/MobileSafariSettings.bundle/MobileSafariSettings", RTLD_NOW);
    
    if (handle) {
        NSLog(@"loaded succesfully");
//        id safariInstance = [[SafariSettingsController alloc] init];
        Class SafariController = NSClassFromString(@"SafariSettingsController");
        
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(SafariController, &methodCount);
        for (int i = 0; i < methodCount; i++)
        {
           Method method = methodList[i];
           SEL selector = method_getName(method);
            NSLog(@"Method name %@", NSStringFromSelector(selector));
           NSMethodSignature *signature = [SafariController instanceMethodSignatureForSelector:selector];

           NSUInteger numberOfArguments = [signature numberOfArguments];
            NSLog(@"number of arguments %d", numberOfArguments);

           for (int i=0 ; i<numberOfArguments ; i++)
           {
//              NSString *type = [NSString stringWithUTF8String:[signature getArgumentTypeAtIndex:i]];
//                            NSLog(type);
           }
        }

        
//        Class SafariController = NSClassFromString(@"SafariSettingsController");
        id safariControllerInstance = [[NSClassFromString(@"SafariSettingsController") alloc] init];
        
        SEL cookiesSelector = @selector(_setValueForClosingTabsAutomatically:);
        NSMethodSignature *cookiesSignature = [SafariController
            instanceMethodSignatureForSelector:cookiesSelector];

        NSInvocation *safariInvocation = [NSInvocation
            invocationWithMethodSignature:cookiesSignature];
        

        BOOL ret = false;
//        id
        NSNumber *someNumber = @(2);
//        BOOL someBoolean = false;
//        int a = 1;
        NSNumber *otherNumber = @(1);

        NSString *srt = @"com.apple";
        id retVal;
        id argVal;
        [safariInvocation setSelector:cookiesSelector];
        [safariInvocation setTarget:safariControllerInstance];
//        [safariInvocation getArgument:&argVal atIndex:2];
//        NSLog(@"asffasdf %@ sfsdf",[ safariInvocation getA)
        [safariInvocation setArgument:&someNumber atIndex:2];
//        [safariInvocation setAr   gument:&srt atIndex:3];
//        NSLog(@"ARGVAL %@",argVal, [argVal class]);

        [safariInvocation invoke];
//        [safariInvocation getReturnValue:&retVal];
//        NSLog(@"Sdfsdfsdf %@ sfsdf %@",retVal, [retVal class]);
//        NSLog(@"ARGVAL %@ dgdfg %@",argVal, [argVal class]);

//        NSLog(ret ? @"hiiiiiiiiiiisdfsdfsdfYes" : @"hiiiiiiiiiisdfsdfsdfsdfdsNo");
//

    } else {
        NSLog(@"dlopen failed  ");
    }


    NSLog(@"sdfsdf sdfsdf  %@", [dict allKeys]);    // Should have "first", "fourth", "fifth" and "sixth" in any order.

//    [dict release];


    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
