//
//  HScrollViewController.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/26.
//
import SwiftUI

struct HScrollViewController<Content: View>: UIViewControllerRepresentable{//泛型 Content 遵循 View协议
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content //SwiftUI的View
    @Binding var leftPercent: CGFloat
    
    init(pageWidth: CGFloat,
         contentSize: CGSize,
         leftPercent: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent //绑定参数初始化要在前面加下划线
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController { //UIViewController 是 UIkit 框架内的一个页面
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrollView = scrollView
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        let host = UIHostingController(rootView: content) //将SwiftUI的View添加到 UIKit 的一个页面上来，UIHostingController起到桥接的作用
        vc.addChild(host)//确定父子关系 host可以看作一个view
        scrollView.addSubview(host.view) //将host加入打scrollView中
        host.didMove(toParent: vc)//确定host 是 vc的子view
        context.coordinator.host = host
        
        return vc
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
        
    }
    
    class Coordinator: NSObject,UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation{
                print(scrollView.contentOffset.x)
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
                print(scrollView.contentOffset.x)

            }
        }
    }
    
}

