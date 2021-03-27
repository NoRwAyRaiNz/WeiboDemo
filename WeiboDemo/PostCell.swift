//
//  PostCell.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/5.
//

import SwiftUI

let image = UIImage(named: "6ec3b446jw1e8qgp5bmzyj2050050aa8.jpg")!//不可能为空时可以加！


struct PostCell: View {
    let post: Post
    
    var bindingPost: Post {
        userData.post(forId: post.id)!
    }
    
    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var post = bindingPost //点赞、关注后要更新post 所以要var
        return VStack(alignment: .leading, spacing: 10){
            HStack(spacing: 5){
                post.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())//图片裁剪成圆形
                    .overlay(
                        PostVIPBadge(vip: post.vip)
                            .offset(x: 16, y: 16)
                    )
                
                VStack(alignment: .leading, spacing: 5){
                    Text(post.name)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor((.gray))
                }
                .padding(.leading, 10)//朝左间距
                if !post.isFollowed{
                    Spacer()
                    
                    Button(action:{
                        post.isFollowed = true
                        self.userData.update(post)
                        print("Click follow button")
                        
                    })  {
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width: 50, height: 26, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange,lineWidth: 1)
                            )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
            }
            
            Text(post.text)
                .font(.system(size: 17))
            
            if(!post.images.isEmpty){
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
            }
            
            Divider()
            
            HStack(spacing: 0){
                Spacer()
                
                PostCellToolbarButton(image: "message",
                                      text: post.commentCountText,
                                      color: .black)
                {
                    self.presentComment = true
                }
                .sheet(isPresented: $presentComment) { //模态推出
                    CommentInputView(post: post).environmentObject(self.userData)
                }
            
                Spacer()
                
                PostCellToolbarButton(image: post.isLiked ? "heart.fill" : "heart",
                                      text: post.likeCountText,
                                      color: post.isLiked ? .red : .black)
                {
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                    }else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    self.userData.update(post)
                    print("Click like button")
                }
                
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            
        }
        .padding(.horizontal, 15)
        .padding(.top)
        
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
            let userData = UserData()
            
            return PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)//取下标
            
    
    }
}
