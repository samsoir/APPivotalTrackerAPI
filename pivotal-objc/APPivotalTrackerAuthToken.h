//
//  APPivotalTrackerAuthToken.h
//  APPivotalTrackerAPI
//
//  Created by Sam de Freyssinet on 12/09/2011.
//
//  ISC License (ISC)
//
//  Copyright 2011 Adapter Pattern. All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any 
//  purpose with or without fee is hereby granted, provided that the above 
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF 
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR 
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR 
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


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
