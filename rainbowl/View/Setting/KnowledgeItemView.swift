//
//  KnowledgeItemView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/5/11.
//

import SwiftUI

struct KnowledgeItemView: View {
    
    let knowledgeData: Knowledge
    
    var body: some View {
        VStack {
            Text("\(knowledgeData.name)色蔬果")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: knowledgeData.color[0]/255, green: knowledgeData.color[1]/255, blue: knowledgeData.color[2]/255))
            Text("營養素：\(knowledgeData.nutrition)")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: knowledgeData.wordColor[0]/255, green: knowledgeData.wordColor[1]/255, blue: knowledgeData.wordColor[2]/255))
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(knowledgeData.description)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color(red: 57/255, green: 57/255, blue: 57/255))
                .padding(.bottom, 24)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                ForEach(knowledgeData.images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48)
                        .padding(.trailing, 20)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
           
            
        }
        .frame(width: 354)
        .background(Color(red: knowledgeData.bgColor[0]/255, green: knowledgeData.bgColor[1]/255, blue: knowledgeData.bgColor[2]/255))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: knowledgeData.color[0]/255, green: knowledgeData.color[1]/255, blue: knowledgeData.color[2]/255), lineWidth: 1.5)
        )
    }
}

//#Preview {
//    KnowledgeItemView()
//}
