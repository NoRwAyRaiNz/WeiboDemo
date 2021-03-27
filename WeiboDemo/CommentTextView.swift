//
//  CommentTextView.swift
//  WeiboDemo
//
//  Created by Jamie on 2021/3/27.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text: String
    
    let beginEditingOnAppear: Bool
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text //如果本身就有文本 则创建时要加入
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if beginEditingOnAppear,
           //多个判断用逗号隔开 刚出现即进入编辑状态
           !context.coordinator.didBecomeFirstResponder,
           //仅第一次进入时要成为第一响应者
           uiView.window != nil,
           //view生成成功window会存在
           !uiView.isFirstResponder {
        //当UITextView进入编辑状态时，uiView是第一响应者 否则让它成为第一响应者
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
            //仅执行一次
        }
           
        
           
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent: CommentTextView
        var didBecomeFirstResponder: Bool = false
        
        init(_ view: CommentTextView) {
            parent = view
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            //            文本框里当前的文本
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""), beginEditingOnAppear: true)
    }
}
