//
//  YSQImagePickerViewController.m
//  Demo
//
//  Created by ysq on 14/7/1.
//  Copyright (c) 2014年 ysq. All rights reserved.
//
#import "YSQImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PickerSubViewController.h"
#import "AssetHelper.h"

@interface YSQImagePickerViewController ()

@end

@implementation YSQImagePickerViewController{
    NSMutableArray *_groupArray;    //保存图片组
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"Photos";
    
    _groupArray = [[NSMutableArray alloc]init];
    if (!self.selectedImageArray) {
        self.selectedImageArray = [[NSMutableArray alloc]init];
    }
    
    [self configureNavigation];
    
    [self loadGroup];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:self.tableView];
    
    if (self.maxSelectImageCount==0) {
        self.maxSelectImageCount = DEFAULTMAXSELECTIMAGECOUNT;
    }
    
}

-(void)setSelectedImageArray:(NSMutableArray *)selectedImageArray{
    _selectedImageArray = [selectedImageArray mutableCopy];
}
/**
 *  配置头部导航
 */
-(void)configureNavigation{
    UIBarButtonItem *close = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"]
                             style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = close;
}
/**
 *  关闭选择图片视图
 */
-(void)close{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  加载读取分组
 */
-(void)loadGroup{
    
    [ASSETHELPER getGroup:^(NSArray *arr) {
        _groupArray = [arr mutableCopy];
        [self.tableView reloadData];
    }];
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_groupArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSDictionary *info = [ASSETHELPER getGroupInfo:_groupArray[indexPath.row]];
    cell.imageView.image = [info objectForKey:@"thumbnail"];
    cell.textLabel.text = [info objectForKey:@"name"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


//推送到选择子视图
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PickerSubViewController *sub = [[PickerSubViewController alloc]initWithNibName:@"PickerSubViewController" bundle:nil];
    sub.group = _groupArray[indexPath.row];
    sub.selectedArray = self.selectedImageArray;
    sub.subFinishSelectBlock = ^(NSMutableArray *array){
        self.selectedImageArray = array;
    };
    sub.finishBlock = self.finishBlock;
    sub.maxSelectImageCount = self.maxSelectImageCount;
    [self.navigationController pushViewController:sub animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setMaxSelectImageCount:(int)maxSelectImageCount{
    _maxSelectImageCount = maxSelectImageCount;
}

@end