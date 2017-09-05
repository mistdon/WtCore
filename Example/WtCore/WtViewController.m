//
//  WtViewController.m
//  WtCore
//
//  Created by JaonFanwt on 08/16/2017.
//  Copyright (c) 2017 JaonFanwt. All rights reserved.
//

#import "WtViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import <WtCore/WtCore.h>
#import <WtCore/WtDebugTools.h>

#import "WtDemoCellModel.h"

@interface WtViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation WtViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"WtCore Library";
    [self createDatas];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createDatas {
    _datas = @[].mutableCopy;
    
    @weakify(self);
    {// Core
        WtDemoCellModel *cellModel = [[WtDemoCellModel alloc] init];
        [_datas addObject:cellModel];
        cellModel.title = @"WtCore";
        [cellModel.tableViewDelegate selector:@selector(tableView:didSelectRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
            @strongify(self);
            Class cls = NSClassFromString(@"WtDemoCoreViewController");
            if (!cls) return;
            UIViewController *toViewCtrl = [[cls alloc] initWithNibName:@"WtDemoCoreViewController" bundle:nil];
            [self.navigationController pushViewController:toViewCtrl animated:YES];
        }];
    }
    
    {// DelegateProxy
        WtDemoCellModel *cellModel = [[WtDemoCellModel alloc] init];
        [_datas addObject:cellModel];
        cellModel.title = @"WtDelegateProxy";
        [cellModel.tableViewDelegate selector:@selector(tableView:didSelectRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
            @strongify(self);
            Class cls = NSClassFromString(@"WtDemoDelegateProxyViewController");
            if (!cls) return;
            UIViewController *toViewCtrl = [[cls alloc] initWithNibName:@"WtDemoDelegateProxyViewController" bundle:nil];
            [self.navigationController pushViewController:toViewCtrl animated:YES];
        }];
    }
    
    {// DebugTools
        WtDemoCellModel *cellModel = [[WtDemoCellModel alloc] init];
        [_datas addObject:cellModel];
        cellModel.title = @"DebugTools";
        [cellModel.tableViewDelegate selector:@selector(tableView:didSelectRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
            @strongify(self);
            Class cls = NSClassFromString(@"WtDebugToolsViewController");
            if (!cls) return;
            UIViewController *toViewCtrl = [[cls alloc] init];
            [self.navigationController pushViewController:toViewCtrl animated:YES];
        }];
        
        // 设置切换接口数据
        [WtDebugSwitchNetworkManager sharedManager].initialNetworkGroupsIfNecessary = ^NSArray<WtDebugSwitchNetworkGroup *> *{
            NSMutableArray *result = @[].mutableCopy;
            
            { // 数据接口
                WtDebugSwitchNetworkGroup *group = [[WtDebugSwitchNetworkGroup alloc] init];
                group.key = @"DataInterface";
                group.name = @"数据接口";
                [result addObject:group];
                
                WtDebugSwitchNetworkItem *model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.data.com";
                model.urlDescription = @"正式地址";
                
                [group addModel:model];
                [group selectModel:model];
                
                model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.dataTest.com";
                model.urlDescription = @"测试地址";
                
                [group addModel:model];
            }
            { // 登录接口
                WtDebugSwitchNetworkGroup *group = [[WtDebugSwitchNetworkGroup alloc] init];
                group.key = @"LoginInterface";
                group.name = @"登录接口";
                [result addObject:group];
                
                WtDebugSwitchNetworkItem *model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.login.com";
                model.urlDescription = @"正式地址";
                
                [group addModel:model];
                
                model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.loginTest.com";
                model.urlDescription = @"测试地址";
                
                [group addModel:model];
                [group selectModel:model];
            }
            { // Web接口
                WtDebugSwitchNetworkGroup *group = [[WtDebugSwitchNetworkGroup alloc] init];
                group.key = @"WebInterface";
                group.name = @"Web接口";
                [result addObject:group];
                
                WtDebugSwitchNetworkItem *model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.web.com";
                model.urlDescription = @"正式地址";
                
                [group addModel:model];
                [group selectModel:model];
                
                model = [[WtDebugSwitchNetworkItem alloc] init];
                model.urlString = @"https://www.webTest.com";
                model.urlDescription = @"测试地址";
                
                [group addModel:model];
            }
            
            return result;
        };
    }
    
    {// Observer
        WtDemoCellModel *cellModel = [[WtDemoCellModel alloc] init];
        [_datas addObject:cellModel];
        cellModel.title = @"WtObserver";
        [cellModel.tableViewDelegate selector:@selector(tableView:didSelectRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
            @strongify(self);
            Class cls = NSClassFromString(@"WtDemoObserverViewController");
            if (!cls) return;
            UIViewController *toViewCtrl = [[cls alloc] initWithNibName:@"WtDemoObserverViewController" bundle:nil];
            [self.navigationController pushViewController:toViewCtrl animated:YES];
        }];
    }
    
    {// ThunderWeb
        WtDemoCellModel *cellModel = [[WtDemoCellModel alloc] init];
        [_datas addObject:cellModel];
        cellModel.title = @"WtThunderWeb";
        [cellModel.tableViewDelegate selector:@selector(tableView:didSelectRowAtIndexPath:) block:^(UITableView *tableView, NSIndexPath *indexPath){
            @strongify(self);
            Class cls = NSClassFromString(@"WtDemoThunderWebViewController");
            if (!cls) return;
            UIViewController *toViewCtrl = [[cls alloc] initWithNibName:@"WtDemoThunderWebViewController" bundle:nil];
            [self.navigationController pushViewController:toViewCtrl animated:YES];
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WtTableViewCellModel *cellModel = _datas[indexPath.row];
    return [cellModel.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WtTableViewCellModel *cellModel = _datas[indexPath.row];
    return [cellModel.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WtTableViewCellModel *cellModel = _datas[indexPath.row];
    [cellModel.tableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end