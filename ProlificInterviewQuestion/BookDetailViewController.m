//
//  BookDetailViewController.m
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import "BookDetailViewController.h"
#import <Social/Social.h>

@interface BookDetailViewController ()<UIActionSheetDelegate>

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *strings = [[NSArray alloc]initWithObjects:_theSelectedBook.title, _theSelectedBook.author, _theSelectedBook.publisher, _theSelectedBook.category, _theSelectedBook.lastCheckedOut, _theSelectedBook.lastCheckedOutBy, nil];
    NSString *text = [strings componentsJoinedByString:@"\n"];
    self.textView.text = text;
}

- (IBAction)checkoutButtonPressed:(id)sender {
}

- (IBAction)shareButtonPressed:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"How would you like to share this book?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){ //facebook
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            NSString *textString = [NSString stringWithFormat:@"Check out this book I just read!"];
            [controller setInitialText:textString];
            [self presentViewController:controller animated:YES completion:Nil];
        }
    }
    else if(buttonIndex == 1){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            NSString *textString = [NSString stringWithFormat:@"Check out this book I just read!"];
            [controller setInitialText:textString];
            [self presentViewController:controller animated:YES completion:Nil];
        }
    }
}

@end
