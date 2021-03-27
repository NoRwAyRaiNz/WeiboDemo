//
//  HomeView.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/23.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0 //自己用或传给子View
    
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView{//父View的环境对象 子View都能访问
            GeometryReader { geometry in
                HScrollViewController(pageWidth: geometry.size.width,
                                      contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),
                                      leftPercent: self.$leftPercent) //在GeometryReader中访问属性要加入self
                {
                    HStack(spacing: 0){
                        PostListView(category: .recommend)
                            .listStyle(PlainListStyle())//iOS 13代码正常 14上正常
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(category: .hot)
                            .listStyle(PlainListStyle())//iOS 13代码正常 14上正常
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))//首页leftPercent传入navigationBar绑定
            .navigationBarTitle("首页",displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //iPad 适配
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
