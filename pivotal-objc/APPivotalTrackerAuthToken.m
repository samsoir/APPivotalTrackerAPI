//
//  APPivotalTrackerAuthToken.m
//  pivotal-objc
//
//  Created by Sam de Freyssinet on 12/09/2011.
//  Copyright 2011 Adapter Pattern. All rights reserved.
//

#import "APPivotalTrackerAuthToken.h"

@implementation APPivotalTrackerAuthToken
@synthesize token = _token;
@synthesize tokenType = _tokenType;
@synthesize username = _username;
@synthesize password = _password;

- (id)initWithUsername:(NSString *) username password:(NSString *) password
{
	self = [self init];

	if (self)
	{
		self.username = username;
		self.password = password;
	}

	return self;
}

/*
 Creates a Pivotal Auth Token valid URL
 */
- (NSString *)createPivotalAuthTokenURL:username:(NSString *) user 
										password:(NSString *) pass
{

	NSString *auth = [NSString stringWithFormat:@"%@:%@", user, pass];

	NSData *authUTF8Data = [auth dataUsingEncoding: NSUTF8StringEncoding
								  allowLossyConversion: YES];

	NSString *authStringEncoded = [[NSString alloc] 
									initWithData:authUTF8Data 
										encoding:NSUTF8StringEncoding];
	
	NSString *url = [[NSString alloc] initWithFormat:@"%@://@%@@%@",
					  APPIVOTALPROTOCOL, authStringEncoded, _pivotalTokenURL];
	[authStringEncoded release];

	[url autorelease];
	return url;
}

/*
 Initializes the library
 */
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		_pivotalTokenURL = 
			@"www.pivotaltracker.com/services/v3/tokens/active";
    }
    
    return self;
}

/*
 Tidy up
 */
- (void) dealloc
{
	[_pivotalTokenURL release];
	[_token release];
	[_username release];
	[_password release];
	
	[super dealloc];
}

@end
