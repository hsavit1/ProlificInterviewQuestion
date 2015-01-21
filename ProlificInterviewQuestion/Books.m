//
//  Books.m
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import "Books.h"

@implementation Books

//The designed initializer
- (id)initWithAuthor:(NSAttributedString *)anAuthor
            category:(NSAttributedString *)aCategory
      lastCheckedOut:(NSAttributedString *)aDate
    lastCheckedOutBy:(NSAttributedString *)aPerson
           publisher:(NSAttributedString *)aPublisher
               title:(NSAttributedString *)aTitle
                 url:(NSAttributedString *)aUrl{
    self = [super init];
    
    if (self)
    {
        self.author = anAuthor;
        self.category = aCategory;
        self.lastCheckedOut = aDate;
        self.lastCheckedOutBy = aPerson;
        self.publisher = aPublisher;
        self.title = aTitle;
        self.url = aUrl;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [self initWithAuthor:dic[@"author"]
                       category:dic[@"category"]
                 lastCheckedOut:dic[@"lastCheckedOut"]
               lastCheckedOutBy:dic[@"lastCheckedOutBy"]
                      publisher:dic[@"publisher"]
                          title:dic[@"title"]
                            url:dic[@"url"]];
    return self;
}

- (id)init {
    NSAttributedString *undefinedString = [[NSAttributedString alloc] initWithString:@"Undifined"];
    
    self = [self initWithAuthor:undefinedString
                       category:undefinedString
                 lastCheckedOut:undefinedString
               lastCheckedOutBy:undefinedString
                      publisher:undefinedString
                          title:undefinedString
                            url:undefinedString];
    return self;
}

@end
