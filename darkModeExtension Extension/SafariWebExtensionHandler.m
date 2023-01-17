//
//  SafariWebExtensionHandler.m
//  darkModeExtension Extension
//
//  Created by Sriteja Sugoor on 17/01/23.
//

#import "SafariWebExtensionHandler.h"

#import <SafariServices/SafariServices.h>

@implementation SafariWebExtensionHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context
{
    id message = [context.inputItems.firstObject userInfo][SFExtensionMessageKey];
    NSLog(@"Received message from browser.runtime.sendNativeMessage: %@", message);

    NSExtensionItem *response = [[NSExtensionItem alloc] init];
    response.userInfo = @{ SFExtensionMessageKey: @{ @"Response to": message } };

    [context completeRequestReturningItems:@[ response ] completionHandler:nil];
}

@end
