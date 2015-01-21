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
- (id)initWithAuthor:(NSString *)anAuthor
            category:(NSString *)aCategory
      lastCheckedOut:(NSString *)aDate
    lastCheckedOutBy:(NSString *)aPerson
           publisher:(NSString *)aPublisher
               title:(NSString *)aTitle
                 url:(NSString *)aUrl{
    self = [super init];
    
    if (self) {
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

- (id)initWithDictionary:(NSDictionary *)dic {
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
    self = [self initWithAuthor:@"Undifined"
                       category:@"Undifined"
                 lastCheckedOut:@"Undifined"
               lastCheckedOutBy:@"Undifined"
                      publisher:@"Undifined"
                          title:@"Undifined"
                            url:@"Undifined"];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ : %@", self.title, self.author];
}

@end
