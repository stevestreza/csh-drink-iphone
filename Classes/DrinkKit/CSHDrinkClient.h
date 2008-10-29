//
//  CSHDrinkClient.h
//  Drink Touch
//
//  Created by Steve Streza on 10/28/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncSocket.h"

#define CSHDrinkClientTimeout 30

typedef enum CSHDrinkClientMode {
	CSHDrinkClientAuthenticatingUsernameMode,
	CSHDrinkClientAuthenticatingPasswordMode
} CSHDrinkClientMode;

@interface CSHDrinkClient : NSObject {
	NSString *mHost;
	
	NSString *mUsername;
	NSString *mPassword;
	
	AsyncSocket *mSocket;
}

@property (copy) NSString *host;
@property (copy) NSString *username;
@property (copy) NSString *password;

-(id)initWithHost:(NSString *)host 
		 username:(NSString *)username 
		 password:(NSString *)password;

-(void)authenticate;
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;

-(void)_writeUsername;
-(void)_writePassword;
-(void)handleAuthUser:(NSString *)response;
-(void)handleAuthPass:(NSString *)response;
@end
