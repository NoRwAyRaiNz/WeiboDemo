//
//  CommentInputView.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/27.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post
    
    @State private var text: String = ""
    @State private var showEmptyTextHUD: Bool = false
    
    
    @Environment(\.presentationMode) var presentationMode
    //          与模态推出相关的字段环境      字段环境的值
    
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        VStack(spacing: 0){
            CommentTextView(text: $text, beginEditingOnAppear: true)
            
            HStack(spacing: 0){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    //                    绑定的值
                }) {
                    Text("取消").padding()
                }
                
                
                Spacer()
                
                
                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            self.showEmptyTextHUD = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            self.showEmptyTextHUD = false
                        }
                            return
                            //如果评论为空则不执行以下操作
                    }
                    print(self.text)
                    var post = self.post
                    //创建同名变量post 进行修改 否则let类型无法改变
                    post.commentCount += 1
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("发送").padding()
                }
            }.font(.system(size: 18))
            .foregroundColor(.black)
        }
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)//缩放
                .animation(.spring(dampingFraction: 0.5))//回弹 动画对上面的属性起作用
                .foregroundColor(.black)
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)//对透明度起作用
        )
        
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().recommendPostList.list[0])
    }
}
