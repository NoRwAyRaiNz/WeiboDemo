//
//  PostImageCell.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/19.
//

import SwiftUI

private let kImageSpace: CGFloat = 6 //图片间隙常量

struct PostImageCell: View {
    let images: [String]
    let width: CGFloat
    
    
    var body: some View {
        Group {
            if images.count == 1 {
                loadImage(name: images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width * 0.75)
                    .clipped()//裁切超出部分
            } else if images.count == 2 {
                PostImageCellRow(images: images, width: width)
            } else if images.count == 3 {
                PostImageCellRow(images: images, width: width)
            } else if images.count == 4 {
                VStack(spacing: kImageSpace){
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...3]), width: width)
                }
            } else if images.count == 5 {
                VStack(spacing: kImageSpace){
                    PostImageCellRow(images: Array(images[0...1]), width: width)
                    PostImageCellRow(images: Array(images[2...4]), width: width)
                }
            } else if images.count == 6 {
                VStack(spacing: kImageSpace){
                    PostImageCellRow(images: Array(images[0...2]), width: width)
                    PostImageCellRow(images: Array(images[3...5]), width: width)
                }
            }
        }
    }
}

struct PostImageCellRow: View {
    let images: [String]
    let width: CGFloat //整行宽度
    
    var body: some View{
        HStack(spacing: kImageSpace){
            ForEach(images, id: \.self) { image in
                loadImage(name: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (self.width - 6 * CGFloat(self.images.count - 1)) /
                    CGFloat(self.images.count), height:(self.width - 6 * CGFloat(self.images.count - 1)) /
                        CGFloat(self.images.count))
                    .clipped()
            }
        }
    }
    
}



struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        
        let images = userData.recommendPostList.list[0].images
        let width = UIScreen.main.bounds.width
        return Group {
            PostImageCell(images: Array(images[0...0]),//取区间里的数值
                       width: width)
            PostImageCell(images: Array(images[0...1]),//取区间里的数值
                       width: width)
            PostImageCell(images: Array(images[0...2]),//取区间里的数值
                       width: width)
            PostImageCell(images: Array(images[0...3]),//取区间里的数值
                       width: width)
            PostImageCell(images: Array(images[0...4]),//取区间里的数值
                       width: width)
            PostImageCell(images: Array(images[0...5]),//取区间里的数值
                       width: width)

        }
        .previewLayout(.fixed(width: width, height: 300))
    }
}
