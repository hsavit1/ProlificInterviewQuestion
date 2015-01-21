//
//  ViewController.h
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBookViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *bookTitleField;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorField;
@property (weak, nonatomic) IBOutlet UITextField *bookPublisherField;
@property (weak, nonatomic) IBOutlet UITextField *bookCategoriesField;

@end

