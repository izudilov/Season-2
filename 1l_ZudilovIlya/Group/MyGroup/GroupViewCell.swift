//
//  GroupViewCell.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 02.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class GroupViewCell: ASCellNode {

    private let groupNode = ASTextNode()
    private let source: [GroupVK]
    private let image = ASNetworkImageNode()
    private let hight: CGFloat = 60.0
    
    init(source: [GroupVK]) {
        self.source = source
       
        super.init()
        backgroundColor = UIColor.white
       
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        groupNode.attributedText = NSAttributedString(string: source[0].name, attributes: [.font : UIFont.systemFont(ofSize: 20)])
        groupNode.backgroundColor = .clear
        addSubnode(groupNode)
       
        image.url = URL(string: source[0].photo_100)
        image.cornerRadius = hight/2
        image.clipsToBounds = true
        image.shouldRenderProgressImages = true
        image.contentMode = .scaleAspectFill
        addSubnode(image)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
          // Задаем размер изображения, так как при загрузке из сети он изначально неизвестен
          image.style.preferredSize = CGSize(width: hight, height: hight)
          let insets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 6)
          // Для добавления красивых отступов от границ ячейки вкладываем ячейку в ASInsetLayoutSpec
          let avatarWithInset = ASInsetLayoutSpec(insets: insets, child: image)
         
          // Центрировать текст поможет ASCenterLayoutSpec
          let textCenterSpec = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: groupNode)
         
          // Корневой лейаут будет определять горизонтальный стек
          let horizontalStackSpec = ASStackLayoutSpec()
          horizontalStackSpec.direction = .horizontal
          // Его дочерними элементами будут спецификации, содержащие текст и аватарку
          horizontalStackSpec.children = [avatarWithInset, textCenterSpec]
          return horizontalStackSpec
      }
    
 }
    
    /*let insets: CGFloat = 3
    let iconSideLinght: CGFloat = 70
    let space: CGFloat = 15*/
    
    
    
    
    /*@IBOutlet weak var groupName: UILabel! /*{
        didSet {
            groupName.translatesAutoresizingMaskIntoConstraints = false
        }
    }*/
        
    @IBOutlet weak var groupLogo: UIImageView! /*/{
        didSet {
            groupLogo.translatesAutoresizingMaskIntoConstraints = false
        }
    }*/
        

    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

            layer.borderWidth = 1
            layer.cornerRadius = 4
            layer.borderColor = UIColor.clear.cgColor

            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }

    //MARK:- Private functions
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
    
    override func layoutSubviews() {
        groupLogo.layer.cornerRadius = groupLogo.bounds.height / 2
        groupLogo.clipsToBounds = true
        super.layoutSubviews()
        photoFrame()
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
            let nameLabelSize = getLabelSize(text: groupName.text!, font: groupName.font)
            // рассчитываем координату по оси Х
            let nameLabelX = bounds.width - insets - nameLabelSize.width
            // рассчитываем координату по оси Y
            let nameLabelY = insets
            // получаем точку верхнего левого угла надписи
            let nameLabelOrigin =  CGPoint(x: nameLabelX, y: nameLabelY)
            // получаем фрейм и устанавливаем UILabel
            groupName.frame = CGRect(origin: nameLabelOrigin, size: nameLabelSize)
    }
    
    func photoFrame() {
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: insets, y: bounds.height - insets * 2)
        groupLogo.frame = CGRect(origin: iconOrigin, size: iconSize)
    }*/
    


