//
//  UIImage+Ext.swift
//  RocketApp
//
//  Created by Кирилл on 10.01.2023.
//

import UIKit

extension UIImage {
    func downsample(reductionAmount: Float) -> UIImage? {
        let image = UIKit.CIImage(image: self)
        guard let lanczosFilter = CIFilter(name: "CILanczosScaleTransform") else { return nil }
        lanczosFilter.setValue(image, forKey: kCIInputImageKey)
        lanczosFilter.setValue(NSNumber(value: reductionAmount), forKey: kCIInputScaleKey)

        guard let outputImage = lanczosFilter.outputImage else { return nil }
        let context = CIContext(options: [CIContextOption.useSoftwareRenderer: false])

        guard let imageInCG = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }

        let scaledImage = UIImage(cgImage: imageInCG)

        return scaledImage
    }
}
