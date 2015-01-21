//
//  BookDetailViewController.h
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Books.h"

@interface BookDetailViewController : UIViewController

@property (strong, nonatomic) Books *theSelectedBook;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
