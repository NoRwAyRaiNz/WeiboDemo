//
//  PostVIPBadge.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/7.
//

import SwiftUI

struct PostVIPBadge: View {
    let vip: Bool
    
    var body: some View{
        Group {
            if vip {
                Text("V")
                    .bold()
                    .font(.system(size:11))
                    .foregroundColor(.yellow)
                    .frame(width: 15, height: 15)
                    .background(Color.red)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)//标志边框
                            .stroke(Color.white, lineWidth: 1)
                            
                )
            }
        }
    }
}
    

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip: true)
    }
}
