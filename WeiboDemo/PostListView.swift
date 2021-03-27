//
//  PostListView.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/10.
//

import SwiftUI

struct PostListView: View {
//去除重复分界线
//    init() {
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().selectionStyle = .none
//    }
    let category: PostListCategory
    
    
    @EnvironmentObject var userData:UserData
    
    var body: some View {
        List {
            ForEach(userData.postlist(for: category).list){ post in//用数组元素组成list，闭包指令
                ZStack {
                    PostCell(post: post)//用post 生成PostCell
                    NavigationLink(destination: PostDetailView(post: post)) {
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets()) //上下左右间距
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(category: .recommend)//触发init()
                .navigationBarTitle("Title")
        }
        .environmentObject(UserData())
    }
}
