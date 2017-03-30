//
//  ProfileController.m
//  AnnotationKitDemo
//
//  Created by luoqihsneg on 2016/11/23.
//  Copyright © 2016年 com.luoqihsneg. All rights reserved.
//

#import "ProfileController.h"
#import <AnnotationKit/AKRouter.h>
#import <AnnotationKit/AKRouteAnnotation.h>
@interface ProfileController ()
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)UIButton *jumpIndex;
@end

@RequestMapping(ProfileController, "demo://profile/:userId/")
@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"Profile:%@",[self.params objectForKey:@"userId"]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.jumpIndex];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.jumpIndex
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.jumpIndex
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.jumpIndex
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1 constant:100]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.jumpIndex
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1 constant:30]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UIButton *)jumpIndex
{
    if (!_jumpIndex) {
        _jumpIndex = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpIndex.translatesAutoresizingMaskIntoConstraints = NO;
        [_jumpIndex setTitle:@"To Biz1" forState:UIControlStateNormal];
        [_jumpIndex setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _jumpIndex.layer.borderColor = [UIColor blueColor].CGColor;
        _jumpIndex.layer.borderWidth = 1;
        [_jumpIndex addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpIndex;
}

#pragma mark - action
- (void)onClick:(id)sender
{
    [[AKRouter shared] routeTo:@"demo://demo/biz1/"];
}
@end
