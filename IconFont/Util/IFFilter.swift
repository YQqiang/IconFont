//
//  IFFilter.swift
//  IconFont
//
//  Created by sungrow on 2019/4/2.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

final class IFFilter {
    typealias Filter = (CIImage) -> CIImage
    private init() {}
}

extension IFFilter {
    
    /// 高斯模糊滤镜
    ///
    /// - Parameter radius: 模糊半径
    /// - Returns: 新图像
    static func blur(radius: Double) -> Filter {
        let filter: Filter = { image in
            let parameters = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
                ] as [String : Any]
            guard let filter = CIFilter(name: "CIGaussianBlur", parameters: parameters) else {fatalError()}
            guard let outputImage =  filter.outputImage else {fatalError()}
            return outputImage
        }
        return filter
    }
    
    /// 生成固定颜色的滤镜
    ///
    /// - Parameter color: 颜色
    /// - Returns: 新图像
    static func colorGenerator(color: UIColor) -> Filter {
        let filter: Filter = { _ in
            let c = CIColor(color: color)
            let parameters = [kCIInputColorKey: c]
            guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters) else {fatalError()}
            guard let outputImage = filter.outputImage else {fatalError()}
            return outputImage
        }
        return filter
    }
    
    /// 合成滤镜
    ///
    /// - Parameter overlay: 输出图像
    /// - Returns: 新图像
    static func compositeSourceOver(overlay: CIImage) -> Filter {
        let filter: Filter = { image in
            let parameters = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters) else {fatalError()}
            guard let outputImage = filter.outputImage else {fatalError()}
            let cropRect = image.extent
            return outputImage.cropped(to: cropRect)
        }
        return filter
    }
    
    /// 颜色叠层滤镜
    ///
    /// - Parameter color: 颜色
    /// - Returns: 新图像
    static func colorOverlay(color: UIColor) -> Filter {
        let filter: Filter = { image in
            let overlay = colorGenerator(color: color)(image)
            return compositeSourceOver(overlay: overlay)(image)
        }
        return filter
    }
    
    /// 复合滤镜
    ///
    /// - Parameters:
    ///   - filter1: 滤镜1
    ///   - filter2: 滤镜2
    /// - Returns: 新图像
    static func composeFilters(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
        let filter: Filter = { image in
            filter2(filter1(image))
        }
        return filter
    }
}
