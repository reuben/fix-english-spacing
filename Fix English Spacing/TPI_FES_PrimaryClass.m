//
//  TPI_FES_PrimaryClass.m
//  Fix English Spacing
//
//  Created by Reuben Morais on 5/14/13.
//  Copyright (c) 2013 reub.in. All rights reserved.
//

#import "TPI_FES_PrimaryClass.h"

@implementation TPI_FES_PrimaryClass

- (IRCMessage *)interceptServerInput:(IRCMessage *)input
                                 for:(IRCClient *)client
{
    if ([input.command isEqualToString:IRCPrivateCommandIndex("privmsg")] == NO) {
        return input;
    }

    NSString *message = [input.params safeObjectAtIndex:1];

    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\.  +" options:0 error:&error];
    NSString *newMsg = [regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, [message length]) withTemplate:@". "];
    
    if ([message compare:newMsg] != NSOrderedSame) {
        NSMutableArray *newParams = [input.params mutableCopy];
        [newParams removeObjectAtIndex:1];
        [newParams insertObject:newMsg atIndex:1];
        input.params = newParams;
    }

    return input;
}

@end
