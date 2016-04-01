//
//  BookListViewController.swift
//  Book_Swift
//
//  Created by 任金波 on 16/3/26.
//  Copyright © 2016年 任金波. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let URLString = "https://api.douban.com/v2/book/search"
    var bookListData:[[String:NSObject]]? = []
    let indetifier  = "BoollistCell"
    let bookListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BoolList"
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.sendResquent()
        self.initTabelView()
        
    }
    
    func sendResquent() {
        let   parma = ["tag":"Swift","start":0,"count":10]
        
        NetManager.GETMEthod(URLString, parame: parma, success: { (success) -> Void in
            //            print(success)
            let dic = success as? [String:NSObject]
            self.bookListData = dic!["books"] as? [[String:NSObject]]
            print(self.bookListData![0])
            self.bookListTableView.reloadData()
            }) { (error) -> Void? in
                print(error)
            }
        }
    func initTabelView() {
        
        bookListTableView.frame = CGRectMake(0, 40, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 40)
        bookListTableView.backgroundColor = UIColor.lightGrayColor()
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.registerNib(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: self.indetifier)
        self.view.addSubview(bookListTableView)
        
    }
    
    //MARK: - tableView
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.bookListData?.count)!
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BookListTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.indetifier, forIndexPath: indexPath) as! BookListTableViewCell


        let imgaes =  self.bookListData![indexPath.row]["images"] as! [String:NSObject]
        let urlString = imgaes["small"] as? String
        let url:NSURL? = NSURL(string: urlString!)
        
        cell.introImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "23"))
        let name = self.bookListData?[indexPath.row]["title"] as! String
        cell.nameLabel.text = name
        
        let authors = self.bookListData?[indexPath.row]["author"] as? [String]
        let author = authors?.joinWithSeparator("\\")
        let publisher = self.bookListData?[indexPath.row]["publisher"] as! String
        let pubdate = self.bookListData?[indexPath.row]["pubdate"] as! String
        
        
        cell.infoLabel.text =  author! + "\\" + publisher + "\\" + pubdate
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
}
