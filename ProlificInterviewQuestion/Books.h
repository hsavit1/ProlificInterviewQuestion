//
//  Books.h
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Books : NSObject

@property (strong, nonatomic) NSAttributedString *author;
@property (strong, nonatomic) NSAttributedString *category;
@property (strong, nonatomic) NSAttributedString *lastCheckedOut;
@property (strong, nonatomic) NSAttributedString *lastCheckedOutBy;
@property (strong, nonatomic) NSAttributedString *publisher;
@property (strong, nonatomic) NSAttributedString *title;
@property (strong, nonatomic) NSAttributedString *url;

- (id)initWithAuthor:(NSAttributedString *)anAuthor
            category:(NSAttributedString *)aCategory
      lastCheckedOut:(NSAttributedString *)aDate
    lastCheckedOutBy:(NSAttributedString *)aPerson
           publisher:(NSAttributedString *)aPublisher
               title:(NSAttributedString *)aTitle
                 url:(NSAttributedString *)aUrl;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
