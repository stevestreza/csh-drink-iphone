//
//  CSHDrinkClient.m
//  Drink Touch
//
//  Created by Steve Streza on 10/28/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CSHDrinkClient.h"


@implementation CSHDrinkClient

@synthesize host=mHost, username=mUsername, password=mPassword;

-(id)initWithHost:(NSString *)host 
		 username:(NSString *)username 
		 password:(NSString *)password{

	if(self = [super init]){
		
		self.host=host;
		self.username=username;
		self.password=password;
		
		mSocket = [[AsyncSocket alloc] initWithDelegate:self];

		NSError *err = nil;
		if(![mSocket connectToHost:self.host 
						   onPort:4242
							error:&err] || err){
			NSLog(@"Error: %@",err);
			
			[self release];
			return nil;
		}
	}
	return self;
}

-(void)authenticate{
	NSLog(@"Authenticating %@ - %@ on %@",self.username, self.password, self.host);
	[self _writeUsername];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
	NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
	switch (tag) {
		case CSHDrinkClientAuthenticatingUsernameMode:
			[self handleAuthUser:dataString];
			break;
		case CSHDrinkClientAuthenticatingPasswordMode:
			[self handleAuthPass:dataString];
			break;
	}
}

-(void)_writeUsername{
	NSString *writeLine = [NSString stringWithFormat:@"USER %@",self.username];
	
	[mSocket writeData:[writeLine dataUsingEncoding:NSASCIIStringEncoding] 
		   withTimeout:CSHDrinkClientTimeout
				   tag:CSHDrinkClientAuthenticatingUsernameMode];
}

-(void)_writePassword{
	NSString *writeLine = [NSString stringWithFormat:@"PASS %@",self.password];
	
	[mSocket writeData:[writeLine dataUsingEncoding:NSASCIIStringEncoding] 
		   withTimeout:CSHDrinkClientTimeout
				   tag:CSHDrinkClientAuthenticatingPasswordMode];	
}

-(void)handleAuthUser:(NSString *)response{
	NSLog(@"Auth'd name: %@",response);
	[self _writePassword];
}

-(void)handleAuthPass:(NSString *)response{
	NSLog(@"Auth'd pass: %@",response);
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
	[self authenticate];
}

@end
