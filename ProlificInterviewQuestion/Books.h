//
//  Books.h
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Books : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *lastCheckedOut;
@property (strong, nonatomic) NSString *lastCheckedOutBy;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;

- (id)initWithAuthor:(NSString *)anAuthor
            category:(NSString *)aCategory
      lastCheckedOut:(NSString *)aDate
    lastCheckedOutBy:(NSString *)aPerson
           publisher:(NSString *)aPublisher
               title:(NSString *)aTitle
                 url:(NSString *)aUrl;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
