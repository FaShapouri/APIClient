//
//  APIClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIClientConfiguration.h"

#import "APIRouter.h"
#import "APIAFNetworkingHTTPClient.h"
#import "APIResponse.h"
#import "APIJSONSerializer.h"

@interface APIClient : NSObject

@property (nonatomic, readonly, strong) APIClientConfiguration *configuration;
@property (nonatomic, readonly, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readonly, strong) id<APIRouter> router;
@property (nonatomic, readonly, strong) id<APIJSONSerializer> serializer;

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
- (id)initWithBaseURL:(NSURL *)baseURL;
- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router serializer:(id<APIJSONSerializer>)serializer;

- (APIResponse *)findAll:(Class)resource;

@end
