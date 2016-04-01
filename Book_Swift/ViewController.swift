//
//  ViewController.swift
//  Book_Swift
//
//  Created by 任金波 on 16/3/25.
//  Copyright © 2016年 任金波. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var items = ["first","second","three","foure","five"]
    
    
    
//    let bigImageView = UIImageView()
    let beautifulImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "请求前的页面"
        // Do any additional setup after loading the view, typically from a nib.
        self.initLabel()
        self.initBtn()
        self.initImage()
        self.initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initLabel() {
        let helloLabel: UILabel = UILabel()
        helloLabel.text = "Hello"
        helloLabel.backgroundColor = UIColor.lightGrayColor()
        helloLabel.frame = CGRectMake(0, 84, 60, 30);
        self.view .addSubview(helloLabel)
        
    }
    
    func initBtn ()  {
        let btn:UIButton = UIButton()
        btn.frame  = CGRectMake(80, 84, 60, 30)
        btn.setTitle("点击", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.lightGrayColor()
        btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func clickBtn(btn:UIButton) -> Void {
        print("btn Click")
    }
    
    
    func initImage ()  {
        
      beautifulImageView.frame = CGRectMake(180, 84, 100, 40)
        beautifulImageView.image = UIImage.init(named: "12")
//        self.view.addSubview(beautifulImageView)
        beautifulImageView.backgroundColor = UIColor.grayColor()
        beautifulImageView.userInteractionEnabled = true;//SB了，这个忘了开
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage(_:)))
        beautifulImageView.contentMode = UIViewContentMode.ScaleAspectFill
        beautifulImageView.addGestureRecognizer(gesture)
    }
    func clickImage(geture:UIGestureRecognizer) -> Void {
        
//        let bigImageView = UIImageView(frame: CGRectMake(0, 100, 300, 300))
//        bigImageView.image = UIImage.init(named: "12")
//        bigImageView.tag = 2
//        bigImageView.hidden = false;
//        self.view.addSubview(bigImageView)
        if beautifulImageView.frame.size.height < 50 {
                    beautifulImageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.height , UIScreen.mainScreen().bounds.size.width)
        }else {
            
             beautifulImageView.frame = CGRectMake(180, 84, 100, 40)
        }

        
    }
    
    func initTableView() -> Void {
        let jbTableView:UITableView = UITableView()
        jbTableView.delegate = self;
        jbTableView.dataSource = self;
        jbTableView.frame = CGRectMake(10, 130, 300, 500)
        //        jbTableView.style
        jbTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "identifierCell")
        
        self.view.addSubview(jbTableView)
        self.view.insertSubview(beautifulImageView, aboveSubview: jbTableView)
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
////        let bigView:UIImageView = self.view.viewWithTag(2) as! UIImageView
////        if bigView.frame.size.height > 200 {
////            bigView.hidden = true
////        }
//        
////        if bigImageView {
//            bigImageView.hidden = true
////        }
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifierCell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = "这是什么鬼"
        cell.imageView?.image = UIImage.init(named: "23")
        //        UITableViewCellStyleSubtitle
        
        //        cell.imageView?.addGestureRecognizer(gesture)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
        
    }
    

    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesBegan(touches, withEvent: event)
//        
//        let bigView = self.view.viewWithTag(2)  as!  UIImageView!
//        bigView.removeFromSuperview()
//        
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("click indexPath.row \(indexPath.row)")
        let bookLstVc  = BookListViewController()
        
        
        self.navigationController?.pushViewController(bookLstVc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //完成编辑
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //        if editingStyle == UITableViewCellEditingStyle.Delete {
        //            self.items.removeAtIndex(indexPath.row)
        //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        //        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let  deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "删除") { (rowAction, index) in
            self.items.removeAtIndex(index.row)
            //移除动画效果
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Bottom)
        }
        
        
        let showAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "哈你妹") { (rowAction, index) in
            let alert:UIAlertController = UIAlertController(title: "提示", message: "点击了就没有办法了", preferredStyle: UIAlertControllerStyle.Alert)
            
            let defauleAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (alertAction) in
                print("你是谁")
            })
            
            alert.addAction(defauleAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        showAction.backgroundColor = UIColor.brownColor()
        return[deleteAction,showAction]
        
        
    }
    
    
}

