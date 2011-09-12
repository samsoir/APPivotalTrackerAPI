//
//  APPivotalTrackerAuthToken.h
//  pivotal-objc
//
//  Created by Sam de Freyssinet on 12/09/2011.
//  Copyright 2011 Adapter Pattern. All rights reserved.
//  Licensed under the ISC License
//

#import <Foundation/Foundation.h>
#import "NSString+URLEncoded.h"

#ifndef APPIVOTALPROTOCOL
	#define APPIVOTALPROTOCOL "https"
#endif

@interface APPivotalTrackerAuthToken : NSObject {
	NSString *_pivotalTokenURL;
	NSString *_token;
	NSString *_username;
	NSString *_password;
	NSInteger _tokenType;
}

#pragma mark -- Properties

@property (nonatomic, retain, readonly) NSString *token;
@property (nonatomic, readonly) NSInteger tokenType;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

#pragma mark -- Methods
- (id)initWithUsername:(NSString *) username password:(NSString *) password;
- (NSString *)createPivotalAuthTokenURL:username:(NSString *) user 
										password:(NSString *) pass;

@end
