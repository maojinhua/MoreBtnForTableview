//
//  ViewController.swift
//  MoreBtnForTableview
//
//  Created by Mao hua on 16/6/6.
//  Copyright © 2016年 Mao hua. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var tableview:UITableView = UITableView();//建立tableview
    var dataArr:NSMutableArray = [1,2,3,4,5,6,7,8];//设置数据源
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.bounds = UIScreen.mainScreen().bounds;//设置tablview的大小
        tableview.center = CGPointMake(UIScreen.mainScreen().bounds.maxX/2, UIScreen.mainScreen().bounds.maxY/2)//设置tableview的中心
        tableview.backgroundColor = UIColor.whiteColor();
        tableview.delegate=self;
        tableview.dataSource=self;
        self.view.addSubview(tableview);
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Idnetfier = "cell"
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: Idnetfier)
        cell.textLabel?.text = "\(dataArr[indexPath.row])I am a cell";
        return cell;
    }
    //设置动作按钮的函数
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //添加删除按钮
        let deleteRowAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "删除", handler: {
            (action:UITableViewRowAction,index:NSIndexPath) in
            //先从数据源那里删除数据
            self.dataArr.removeObjectAtIndex(indexPath.row);
            //然后在把tableview上的指定行删除
            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic);
            
        })
        let insertRowAction:UITableViewRowAction = UITableViewRowAction(style:.Default, title: "置顶", handler: {
            (action:UITableViewRowAction,index:NSIndexPath) in
            //把数据源地一行的数据和当前点击行的数据交换
            self.dataArr.exchangeObjectAtIndex(0, withObjectAtIndex: indexPath.row);
            //获取tableview中第一行的indexpath
            let firstIndex:NSIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
            //通过第一行的index和当前点击行的index来进行行的交换
            self.tableview.moveRowAtIndexPath(indexPath, toIndexPath: firstIndex);
        })
        let moreRowAction:UITableViewRowAction = UITableViewRowAction(style:.Default, title: "重置", handler: {
            (action:UITableViewRowAction,index:NSIndexPath) in
            //重新加载tablview
            self.tableview.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
        })
        let actions = [deleteRowAction,insertRowAction,moreRowAction];
        return actions;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

