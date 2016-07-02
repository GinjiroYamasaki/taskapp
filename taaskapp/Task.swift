//
//  Task.swift
//  taaskapp
//
//  Created by yamasaki ginjiro on 2016/06/14.
//  Copyright © 2016年 ginjiro.yamasaki. All rights reserved.
//

import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    dynamic var id = 0
    
    // タイトル
    dynamic var title = ""
    
    // 内容
    dynamic var contents = ""
    
    /// 日時
    dynamic var date = NSDate()
    
    dynamic var category = String()
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }

}
