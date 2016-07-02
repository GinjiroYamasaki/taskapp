//
//  InputViewController.swift
//  taaskapp
//
//  Created by yamasaki ginjiro on 2016/06/14.
//  Copyright © 2016年 ginjiro.yamasaki. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var category: [String] = ["就活", "授業", "友達", "デート", "テニス","その他"]
    let realm = try! Realm()
    var task:Task!
    var categoryString = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(InputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        categoryString = task.category
        pickerView.selectRow(0, inComponent: 0, animated: true) // pickerViewの初期値
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.task.category = self.categoryString
            self.realm.add(self.task, update: true)
            
        }
        
        
        setNotification(task)
        
        super.viewWillDisappear(animated)
    }
    
    func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    
    }
    
    // タスクのローカル通知を設定する
    func setNotification(task: Task) {
        
        // すでに同じタスクが登録されていたらキャンセルする
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
            if notification.userInfo!["id"] as! Int == task.id {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break   // breakに来るとforループから抜け出せる
            }
        }
        
        let notification = UILocalNotification()
        
        notification.fireDate = task.date
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertBody = "\(task.title)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["id":task.id]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return category.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return "\(category[row])"
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("列: \(row)")
        print("値: \(category[row])")
        categoryString = category[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
