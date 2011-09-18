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

#define APPT_ERROR_CONNECTION_AUTH_CHALLENGE 10000

#import <Foundation/Foundation.h>
#import "NSString+URLEncoded.h"

@protocol APPivotalTrackerAuthTokenDelegate;

@interface APPivotalTrackerAuthToken : NSObject <NSXMLParserDelegate> {
	NSMutableData *_tokenXML;
	NSURLConnection *_connection;
	NSXMLParser *_xmlParser;
	NSString *_token;
	NSString *_username;
	NSString *_password;
	NSInteger _tokenType;
	NSMutableString *_xmlStringBuffer;
	NSError *_error;
	id _delegate;
}

#pragma mark -- Properties

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSInteger tokenType;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, readonly) NSError *error;

#pragma mark -- Methods

- (id <APPivotalTrackerAuthTokenDelegate>)delegate;
- (void)setDelegate:(id <APPivotalTrackerAuthTokenDelegate>)delegate;

/*!
 @method initWithUsername:password:
 @abstract Initialize the token object with a users credentials
 @discussion Initializes the Pivotal Tracker Auth Token with the user
 credentials required to authenticate against the service.
 @param username the Pivotal Tracker username or email address
 @param password the Pivotal Tracker password for supplied username
 */
- (id)initWithUsername:(NSString *) username password:(NSString *) password;
/*!
 @method getPivotalUURLUsingEncodedAuth:
 @abstract Returns the Pivotal Tracker Auth URL
 @discussion Returns the Pivotal Tracker Auth URL including the user
 credentials supplied in initWithUsername:password:
 */
- (NSURL *)getPivotalURLUsingEncodedAuth;

/*!
 @method getPivotalToken:
 @abstract Retrieves an authenticated Pivotal Tracker token
 @discussion Loads a Pivotal Tracker authenticated token based on the user
 credenitals supplied.
 @param url the URL to load the token from
 */
- (void)getPivotalToken:(NSURL *)url;

#pragma mark -- NSURLConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

#pragma mark -- NSXMLParserDelegate Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError;

@end

@protocol APPivotalTrackerAuthTokenDelegate <NSObject>

/*!
 @method token:didReceiveToken:withType:
 @abstract called when APPivotalTrackerAuthToken has successfully received an
 authentated token
 @discussion Notifies the delegate that Pivotal Tracker has authenticated the
 user successfully.
 @param token the APPivotalTrackerAuthToken context
 @param guid the token ID
 @param type the token type code
 */
- (void)token:(APPivotalTrackerAuthToken *)token didReceiveToken:(NSString *)guid withType:(NSInteger)type;

/*!
 @method token:failedWithError:
 @abstract called when APPivotalTrackerAuthToken has encoutered an error
 @discussion Notifes the delegate that there has been an issue authenticating
 the user credentials.
 @param token the APPivotalTrackerAuthToken context
 @param error the error encoutered
 */
- (void)token:(APPivotalTrackerAuthToken *)token failedWithError:(NSError *)error;

@end

