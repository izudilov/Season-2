//
//  UserViewCell.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 01.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    let insets: CGFloat = 3
    let iconSideLinght: CGFloat = 70
    let space: CGFloat = 15
    
    @IBOutlet weak var userName: UILabel!{
        didSet {
            userName.translatesAutoresizingMaskIntoConstraints = false
        }
    }
         
    @IBOutlet weak var userFoto: AsyncImageView!{
        didSet {
            userFoto.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
            // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
            let maxWidth = bounds.width - insets - iconSideLinght - space
            // получаем размеры блока под надпись
            // используем максимальную ширину и максимально возможную высоту
            let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
            // получаем прямоугольник под текст в этом блоке и уточняем шрифт
            let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            // получаем ширину блока, переводим ее в Double
            let width = Double(rect.size.width)
            // получаем высоту блока, переводим ее в Double
            let height = Double(rect.size.height)
            // получаем размер, при этом округляем значения до большего целого числа
            let size = CGSize(width: ceil(width), height: ceil(height))
            return size
    }
    
    func nameLabelFrame() {
            // получаем размер текста, передавая сам текст и шрифт
            let nameLabelSize = getLabelSize(text: userName.text!, font: userName.font)
            // рассчитываем координату по оси Х
            let nameLabelX = bounds.width - insets - nameLabelSize.width
            // рассчитываем координату по оси Y
            let nameLabelY = insets
            // получаем точку верхнего левого угла надписи
            let nameLabelOrigin =  CGPoint(x: nameLabelX, y: nameLabelY)
            // получаем фрейм и устанавливаем UILabel
            userName.frame = CGRect(origin: nameLabelOrigin, size: nameLabelSize)
    }
    
    func photoFrame() {
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: insets, y: bounds.height - insets * 2)
        userFoto.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photoFrame()
        nameLabelFrame()
    }
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
