//
//  HomeNavigationBar.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/23.
//

import SwiftUI

private let kLabelWidth: CGFloat = 60
private let kButtonHeight: CGFloat = 24

struct HomeNavigationBar: View {
    @Binding var leftPercent: CGFloat //0 for left, 1 for right
    //当state变化，view会更新
    //子View 绑定参数用Binding
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            Button(action: {
                print("click camera button")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal,15)
                    .padding(.top, 5)
                    .foregroundColor(.black)
            }
            
            
            
            Spacer()
            
            VStack(spacing: 3){
                HStack(spacing: 0){
                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(1 - leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 0
                            }
                            
                        }
                    
                    
                    Spacer()
                    
                    Text("热门")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1
                                
                            }
                        }
                }
                .font(.system(size: 20))
                
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.orange)
                    .frame(width: 30, height: 4)//高度圆角矩形半径2倍
                    .offset(x: UIScreen.main.bounds.width * 0.5 * (self.leftPercent - 0.5) + kLabelWidth * CGFloat(0.5 - self.leftPercent))
            }
            .frame(width: UIScreen.main.bounds.width * 0.5)
            
            
            Spacer()
            
            Button(action: {
                print("click add button")
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal,15)
                    .padding(.top, 5)
                    .foregroundColor(.orange)
            }
        }
        .frame(width:UIScreen.main.bounds.width)
    }
    
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(0)) //0时在左，0.5在中间，1在右
    }
}
