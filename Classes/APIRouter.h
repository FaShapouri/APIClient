//
//  APIRouter.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIRouter <NSObject>
- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
@end