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
    var bookHeight:CGFloat = 0.0
    
    
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
//            print(self.bookListData![0])
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

        //图片 和图书名字
        let imgaes =  self.bookListData![indexPath.row]["images"] as! [String:NSObject]
        let urlString = imgaes["small"] as? String
        let url:NSURL? = NSURL(string: urlString!)
        cell.introImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "23"))
        let name = self.bookListData?[indexPath.row]["title"] as! String
        cell.nameLabel.font = UIFont.boldSystemFontOfSize(17)
        cell.nameLabel.text = name
        
        let rating = self.bookListData?[indexPath.row]["rating"] as! [String:NSObject]
        let aver = rating["average"] as! String
        let averInt = Double(aver)
        
        
        for i in 0...4 {
           let starImage = UIImageView(frame: CGRectMake(CGFloat(20 + 34*i), 3, 30, 30))
            if Double((i+1)*2) <= averInt  {
               starImage.image = UIImage(named: "star_yes")
            } else {
                starImage.image = UIImage(named: "star_no")
            }

            
            cell.starView .addSubview(starImage)
        }
        //作者，出版社，出版日期
        let authors = self.bookListData?[indexPath.row]["author"] as? [String]
        let author = authors?.joinWithSeparator("\\")
        let publisher = self.bookListData?[indexPath.row]["publisher"] as! String
        let pubdate = self.bookListData?[indexPath.row]["pubdate"] as! String
        cell.infoLabel.text =  author! + "\\" + publisher + "\\" + pubdate
        cell.infoLabel.numberOfLines = 0;
        cell.infoLabel.font = UIFont.systemFontOfSize(15)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let label = UILabel()
        
        let authors = self.bookListData?[indexPath.row]["author"] as? [String]
        let author = authors?.joinWithSeparator("\\")
        let publisher = self.bookListData?[indexPath.row]["publisher"] as! String
        let pubdate = self.bookListData?[indexPath.row]["pubdate"] as! String
        label.text =  author! + "\\" + publisher + "\\" + pubdate
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(15)
        let newsize:CGSize = label.sizeThatFits(CGSizeMake(self.view.frame.size.width - 94, 9999))

        return newsize.height + 76
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC  = BookDetailViewController()
        detailVC.bookDetail = self.bookListData?[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
