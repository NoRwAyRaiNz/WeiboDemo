//
//  Post.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/7.
//

import SwiftUI

struct PostList: Codable {
    var  list: [Post]
    
}


//Data Model
struct Post: Codable , Identifiable{//可编码协议
    // Property 属性
    let id: Int
    let avatar: String //头像,图片名称
    let vip: Bool //true , false
    let name: String
    let date: String
    
    
    
    var isFollowed: Bool
    
    let text: String
    let images: [String]//数组
    
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
    
   
    
}
//与view相关 放入扩展
extension Post {
    var avatarImage: Image {
        return loadImage(name: avatar)
    }
    
    //Cauculated property
    var commentCountText: String {//只读属性
        if commentCount <= 0  { return "评论" }
        if commentCount < 1000 { return "\(commentCount)"}
        return String(format: "%.1fk", Double(commentCount) / 1000) //评论数大于1000 显示成 xk %f 小数 .1保留一位小数
    }
    
    var likeCountText: String {
        if likeCount <= 0 { return "点赞"}
        if likeCount < 1000 { return "\(likeCount)" }
        return String(format: "%.1fk", Double(likeCount) / 1000)
    }
}

func loadPostListData(_ fileName:String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {//保证取到url才执行后面的操作
        fatalError("Can not find \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else {//从url中获取数据
        fatalError("Can not load \(url)")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else{//从数据中解析到list
        fatalError("Can not parse post list json data")
    }
    return list
}


func loadImage(name: String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
    
}
