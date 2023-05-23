//
//  CookieCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVFoundation
import Kingfisher

struct CookieCellView: View {
    
    let cell: any SearchedCell
    @State private var uiImage: UIImage?
    
    
    var url: URL {
        URL(string: cell.thumbnail)!
    }

    var body: some View {
        VStack {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(.gray_bcbcbc)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "arrowtriangle.right.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .frame(maxWidth: 200)
                    .overlay {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
            }
            
            HStack(spacing: 5) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primary)
                    .padding(.leading, 5)
                
                VStack(alignment: .leading) {
                    Text("\(cell.title)")
                        .lineLimit(1)
                        .font(CustomFontFactory.INTER_BOLD_16)
                    
                    Text("\(cell.userName)")
                        .lineLimit(1)
                        .font(CustomFontFactory.INTER_REGULAR_14)
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
        }
        .onAppear {
            getThumbnail()
        }
    }
    
    func getThumbnail() {
        DispatchQueue.global().async {
            let myAsset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: myAsset)
            print("uiImage called")
            
            guard let cgImage = try? imageGenerator.copyCGImage(at: .zero, actualTime: nil) else {
                return
            }
            
            self.uiImage = UIImage(cgImage: cgImage)
       }
    }
}

struct CookieCellView_Previews: PreviewProvider {
    static var previews: some View {
        CookieCellView(cell: CookieCell.mock())
    }
}
