//
//  ViewController.m
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import "AddBookViewController.h"
#import "AFNetworking.h"
#import "Books.h"

static NSString * const BaseURLString = @"http://prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56";

@interface AddBookViewController ()<UIAlertViewDelegate>

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)submitButtonPressed:(id)sender {
    if( 1){//![self.bookTitleField.text isEqualToString:@""] && ![self.bookAuthorField.text isEqualToString:@""] && ![self.bookPublisherField.text isEqualToString:@""] && ![self.bookCategoriesField.text isEqualToString:@""]){
        
//        NSDate *now = [NSDate date];
//        //date format is yyyy-MM-dd HH:mm:ss zzz

//
//        Books *book = [[Books alloc]initWithAuthor:self.bookAuthorField.text
//                                          category:self.bookCategoriesField.text
//                                    lastCheckedOut:nil
//                                  lastCheckedOutBy:nil
//                                         publisher:self.bookPublisherField.text
//                                             title:self.bookTitleField.text
//                                               url:nil];
//        
//        NSString *getBooksString = [BaseURLString stringByAppendingString:@"/books"];
//        NSURL *url = [[NSURL alloc]initWithString:getBooksString];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
        NSString *path = @"POST /books";
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.bookAuthorField.text forKey:@"title"];
        [parameters setObject:self.bookCategoriesField.text forKey:@"author"];
        [parameters setObject:self.bookPublisherField.text forKey:@"publisher"];
        [parameters setObject:self.bookTitleField.text forKey:@"categories"];

        NSDictionary *params = @{@"author": @"Diego Torres Milano",
                                 @"categories" : @"android,testing",
                                 @"title": @"Android Application Testing Guide",
                                 @"publisher": @"Packt Publishing",
                                 @"lastCheckedOutBy": @"Joe"};
        
        NSURL *url = [NSURL URLWithString:@"http:prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56/books/"];  // your id removed for security's sake ... put it back in
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *encodeError;
        NSData *body = [NSJSONSerialization dataWithJSONObject:params options:0 error:&encodeError];
        NSAssert(body, @"JSON encode failed: %@", encodeError);
        request.HTTPBody = body;
        
        [self.navigationController popViewControllerAnimated:YES];
        
//        
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:BaseURLString];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        
//        [manager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"JSON: %@", responseObject);
//            //here is place for code executed in success case
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error while sending POST"
//                                                                message:@"Sorry, try again."
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//            NSLog(@"Error: %@", [error localizedDescription]);
//        }];
        
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please fill out all fields"
                                                            message:@"Some fields were left blank"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
