//
//  KeyboardViewController.m
//  shurufa
//
//  Created by yfc on 16/6/27.
//  Copyright © 2016年 yfc. All rights reserved.
//
//iPhone1,1   iPhone 2G (A1203)
//iPhone1,2   iPhone 3G (A1241/A1324)
//iPhone2,1   iPhone 3GS (A1303/A1325)
//iPhone3,1   iPhone 4 (A1332)
//iPhone3,2   iPhone 4 (A1332)
//iPhone3,3   iPhone 4 (A1349)
//iPhone4,1   iPhone 4S (A1387/A1431)
//iPhone5,1   iPhone 5 (A1428)
//iPhone5,2   iPhone 5 (A1429/A1442)
//iPhone5,3   iPhone 5c (A1456/A1532)
//iPhone5,4   iPhone 5c (A1507/A1516/A1526/A1529)
//iPhone6,1   iPhone 5s (A1453/A1533)
//iPhone6,2   iPhone 5s (A1457/A1518/A1528/A1530)
//iPhone7,1   iPhone 6 Plus (A1522/A1524)
//iPhone7,2   iPhone 6 (A1549/A1586)
//iPhone8,1   iPhone 6s
//iPhone8,2   iPhone 6s plus


#import "KeyboardViewController.h"

@interface KeyboardViewController (){
    UIButton *button;
}
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard yu", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
//   UIView * ButtonViewOne = [[UIView alloc]initWithFrame: CGRectMake(0, 0, 320, 20)];
    UIButton *GLOBUTTON = nil;
    
    {
    NSMutableArray *butttons =[[NSMutableArray alloc]initWithCapacity:0];
    
    NSArray *buttonRowOne = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"];
    for (int i =0; i<buttonRowOne.count ;i++) {
        
        UIButton *butt = [self createButWithTitle:buttonRowOne[i]];
        butt.frame = CGRectMake(1, 0, 40, 40);
        butt.titleLabel.font = [UIFont systemFontOfSize:40];
        [self.view addSubview:butt];
        
        [butttons addObject:butt];
        
        GLOBUTTON =butt;
    }
    
    
    // 布局
    for (int i =0; i<butttons.count -1 ;i++) {
        
        UIButton *butFront =[butttons objectAtIndex:i];
        
        UIButton *butbehind =[butttons objectAtIndex:i+1];

            [butbehind.leftAnchor constraintEqualToAnchor:butFront.rightAnchor].active = YES;
//            [but.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    }
    }
    {
        NSMutableArray *butttons =[[NSMutableArray alloc]initWithCapacity:0];
        
        NSArray *buttonRowOne = @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"];
        for (int i =0; i<buttonRowOne.count ;i++) {
            
            UIButton *butt = [self createButWithTitle:buttonRowOne[i]];
            butt.frame = CGRectMake(0, 40, 40, 40);
            butt.titleLabel.font = [UIFont systemFontOfSize:40];
            [self.view addSubview:butt];
            
            [butttons addObject:butt];
        }
        
        
        // 布局
        for (int i =0; i<butttons.count -1 ;i++) {
            
            UIButton *butFront =[butttons objectAtIndex:i];
            
            UIButton *butbehind =[butttons objectAtIndex:i+1];
            
            [butbehind.leftAnchor constraintEqualToAnchor:butFront.rightAnchor].active = YES;
            [butbehind.topAnchor constraintEqualToAnchor:GLOBUTTON.bottomAnchor].active = YES;
            [butFront.topAnchor constraintEqualToAnchor:GLOBUTTON.bottomAnchor].active = YES;

            if (i == butttons.count -2) {
                            GLOBUTTON =butbehind;

            }
        }
    }
    
    {
        NSMutableArray *butttons =[[NSMutableArray alloc]initWithCapacity:0];
        
        NSArray *buttonRowOne = @[@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"BP"];
        for (int i =0; i<buttonRowOne.count ;i++) {
            
            UIButton *butt = [self createButWithTitle:buttonRowOne[i]];
            butt.frame = CGRectMake(0, 40, 40, 40);
            butt.titleLabel.font = [UIFont systemFontOfSize:40];
            [self.view addSubview:butt];
            
            [butttons addObject:butt];
        }
        
        
        // 布局
        for (int i =0; i<butttons.count -1 ;i++) {
            
            UIButton *butFront =[butttons objectAtIndex:i];
            
            UIButton *butbehind =[butttons objectAtIndex:i+1];
            
            [butbehind.leftAnchor constraintEqualToAnchor:butFront.rightAnchor].active = YES;
            
            [butFront.topAnchor constraintEqualToAnchor:GLOBUTTON.bottomAnchor].active = YES;

            [butbehind.topAnchor constraintEqualToAnchor:GLOBUTTON.bottomAnchor].active = YES;
        }
    }
    
}
-(void)didTapButton:(UIButton *)but{
    NSString *title = but .titleLabel.text;
    NSLog(@"%@",title);
    
    if ([title isEqualToString:@"BP"]) {
        [self.textDocumentProxy deleteBackward];
        return;
    }
    
    
    [self.textDocumentProxy insertText:@"菲儿大妹子"];
    
}
-(UIButton *)createButWithTitle:(NSString *)title{
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.backgroundColor = [UIColor whiteColor];
    [but setTitle:title forState:UIControlStateNormal];
    but.translatesAutoresizingMaskIntoConstraints = NO;
    but.frame =CGRectMake(0, 0, 30, 30);
    
    [but addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:but];
    

    return but;
    
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
