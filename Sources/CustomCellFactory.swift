//
//  CustomCellFactory.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 08/05/15.
//

import Foundation
import AsyncDisplayKit
import Core
import DTCoreText

/**
 Provides a Cell for a Block
 */
class CellFactory: Core.CellFactory {
    private let trackerFactory: TrackerFactory
    private let imagePolicy: ImagePolicy
    private let dataController: BlockContextDataController
    
    private let tweetDateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm - d MMM YYYY"
        return formatter
    }()

    init(trackerFactory: TrackerFactory, dataController: BlockContextDataController, imagePolicy: ImagePolicy) {
        self.trackerFactory = trackerFactory
        self.dataController = dataController
        self.imagePolicy = imagePolicy
    }

    func cell(block block: Block) -> ASCellNode {
        let decorationLayerModel = DecorationLayerModel.model(block: block)
        let decoration = Decoration(type: block.decoration, layerModel: decorationLayerModel)
        
        let cell: Cell
        switch block {
        case let sectionRef as SectionRefBlock:
            let node = sectionRefNode(sectionRefBlock: sectionRef)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let articleRef as ArticleRefBlock:
            let node = articleRefNode(articleRefBlock: articleRef)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let bylineBlock as BylineBlock:
            let node = bylineNode(bylineBlock: bylineBlock)
            cell = NRCCell(contentNode: node, decoration: nil)
        case let spacingBlock as SpacingBlock:
            let node = spacingNode(spacingBlock: spacingBlock)
            cell = NRCCell(contentNode: node, decoration: nil)
        case let textBlock as TextBlock:
            let node = textNode(textBlock: textBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let plainTextBlock as PlainTextBlock:
            let node = textNode(textBlock: plainTextBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let imageBlock as ImageBlock:
            let node = imageNode(imageBlock: imageBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let dividerBlock as DividerBlock:
            let node = dividerNode(dividerBlock: dividerBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let enhancedBannerBlock as EnhancedBannerBlock:
            let node = enhancedBannerNode(enhancedBannerBlock: enhancedBannerBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let tweetBlock as TweetBlock:
            let node = tweetNode(tweetBlock: tweetBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let youtubeBlock as YoutubeBlock:
            let node = youtubeNode(youtubeBlock: youtubeBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let vimeoBlock as VimeoBlock:
            let node = vimeoNode(vimeoBlock: vimeoBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        case let videoBlock as VideoBlock:
            let node  = videoNode(videoBlock: videoBlock)
            cell = NRCCell(contentNode: node, decoration: decoration)
        default:
            let node = FallbackContentNode(renderable: block)
            return Cell(contentNode: node)
        }
        
        // add tracker
        cell.tracker = trackerFactory.createTracker(block.trackingData)
        
        return cell
    }
    
    //MARK: - SectionRef
    private func sectionRefNode(sectionRefBlock block: SectionRefBlock) -> SectionRefNode {
        let attributes = StringAttributes(font: Fonts.mediumFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor())
        let title = NSAttributedString(string: block.title, attributes: attributes)
        let content = SectionRefNodeContent(title: title)
        return SectionRefNode(content: content)
    }
    
    //MARK: - ArticleRef
    private func articleRefNode(articleRefBlock block: ArticleRefBlock) -> ArticleRefNode {
        let nodeType: ArticleRefNode.Type
        let titleFontSize: CGFloat
        let imageSize: ImageSize
        let padding: UIEdgeInsets
        var abstract: NSAttributedString? = nil
        
        // setup content by style and theme
        switch (block.blockStyle, block.theme) {
        case (.Large, .Urgent),(.Large, .Live):
            nodeType = ExtraLargeArticleRefNode.self
            titleFontSize = 26
            imageSize = .Large
            padding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
            
            // abstract
            if let string = block.abstract {
                let abstractAttributes = StringAttributes(
                    font: Fonts.lightFont.fallbackWithSize(20),
                    foregroundColor: block.theme.fontColor,
                    lineSpacing: 3,
                    hyphenationFactor: 0.8
                )
                abstract = NSAttributedString(string: string, attributes: abstractAttributes, style: block.blockStyle)
            }
        case (.Large, .Highlight),(.Large, .Default):
            nodeType = LargeArticleRefNode.self
            titleFontSize = 22
            imageSize = .Medium
            padding = UIEdgeInsets(top: TimelineStyles.contentInset, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
        default:
            nodeType = NormalArticleRefNode.self
            titleFontSize = 19
            imageSize = .Small
            padding = UIEdgeInsets(top: TimelineStyles.contentInset, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
        }
        
        let titleAttributes = StringAttributes(
            font: Fonts.mediumFont.fallbackWithSize(titleFontSize),
            foregroundColor: block.theme.fontColor,
            lineSpacing: 2,
            hyphenationFactor: 0.8
        )
        let title = NSAttributedString(string: block.headline, attributes: titleAttributes, style: block.blockStyle)
        let imageURL = imagePolicy.URL(media: block.media, size: imageSize)
        let aspectRatio = block.media.aspectRatio ?? Media.defaultAspectRatio
        let image = Image(URL: imageURL, aspectRatio: aspectRatio)
        
        let content = ArticleRefNodeContent(
            articleIdentifier: block.articleIdentifier,
            url: block.url,
            title: title,
            abstract: abstract,
            label: block.labelModel,
            line: block.lineModel,
            image: image,
            backgroundColor: block.theme.backgroundColor,
            padding: padding
        )
        
        return nodeType.init(content: content)
    }
    
    //MARK: - Byline
    private func bylineNode(bylineBlock block: BylineBlock) -> BylineNode {
        let attributes = StringAttributes(
            font: Fonts.alternativeMediumFont.fallbackWithSize(15),
            foregroundColor: Colors.defaultFontColor,
            lineSpacing: 3
        )
        let text = NSAttributedString(string: block.plainText, attributes: attributes)
        let content = BylineNodeContent(icon: block.icon, text: text)
        return BylineNode(content: content)
    }
    
    //MARK: - Spacing
    private func spacingNode(spacingBlock block: SpacingBlock) -> SpacingNode {
        let backgroundColor: UIColor
        switch block.blockContext {
        case .Timeline:
            backgroundColor = Colors.timelineBackgroundColor
        case .Article:
            backgroundColor = Colors.articleBackgroundColor
        default:
            backgroundColor = Colors.defaultBackgroundColor
        }
        
        let content = SpacingContent(units: block.size, multiplier: 1, backgroundColor: backgroundColor)
        return SpacingNode(content: content)
    }
    
    //MARK: - Text
    private func textNode(textBlock block: TextBlock) -> TextNode {
        let font: UIFont
        let textColor: UIColor
        let lineSpacing: CGFloat
        let backgroundColor: UIColor
        let padding: UIEdgeInsets
        
        func insetPadding(decoration decoration: DecorationType) -> UIEdgeInsets {
            switch decoration {
            case .Top:
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            case .Middle:
                return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
            case .Bottom:
                return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
            case .Full:
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            case .None:
                return UIEdgeInsets()
            }
        }
        
        switch block.blockStyle {
        case .Normal:
            font = Fonts.textFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing =  8
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        case .BlockQuote:
            font = Fonts.mediumFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Information:
            font = Fonts.mediumFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleInformationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Recommendation:
            font = Fonts.lightFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleRecommendationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Inset:
            font = Fonts.alternativeTextFont.fallbackWithSize(15)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: block.decoration)
        case .InsetHeader:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.accentColor
            lineSpacing = 4
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: block.decoration)
        case .InsetSubheader:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: block.decoration)
        case .Intro:
            font = Fonts.lightFont.fallbackWithSize(22)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        case .Subheader:
            font = Fonts.textFont.fallbackWithSize(20)
            textColor = Colors.defaultFontColor
            lineSpacing = 4
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        default:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.defaultFontColor
            lineSpacing = 0
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        }
        
        let attributes = StringAttributes(
            font: font,
            foregroundColor: textColor,
            lineSpacing: lineSpacing,
            hyphenationFactor: 0.8,
            styleSheet: .shared
        )
        let text = NSAttributedString(string: block.richText, attributes: attributes, style: block.blockStyle)
        let content = TextNodeContent(text: text, backgroundColor: backgroundColor, padding: padding)
        return TextNode(content: content)
    }
    
    //MARK: - PlainText
    func textNode(textBlock block: PlainTextBlock) -> TextNode {
        let font: UIFont
        let fontColor: UIColor
        let padding: UIEdgeInsets
        
        switch block.blockStyle {
        case .Subheader:
            font = Fonts.mediumFont.fallbackWithSize(20)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 14, right: 20)
        case .InsetHeader:
            font = Fonts.alternativeMediumFont.fallbackWithSize(14)
            fontColor = Colors.accentColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 11, right: 15)
        case .InsetSubheader:
            font = Fonts.alternativeTextFont.fallbackWithSize(15)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 11, right: 15)
        default:
            font = Fonts.textFont.fallbackWithSize(14)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 25, right: ArticleStyles.textInset)
        }
        
        let attributes = StringAttributes(
            font: font,
            foregroundColor: fontColor,
            lineSpacing: 6,
            hyphenationFactor: 0.8,
            styleSheet: .shared
        )
        
        let text = NSAttributedString(string: block.plainText, attributes: attributes)
        let content = TextNodeContent(text: text, backgroundColor: Colors.cellBackgroundColor, padding: padding)
        return TextNode(content: content)
    }
    
    //MARK: - Image
    func imageNode(imageBlock block: ImageBlock) -> ImageNode {
        let media = block.media
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let image = Image(URL: URL, aspectRatio: aspectRatio)
        
        let backgroundColor: UIColor
        let padding: UIEdgeInsets
        let shouldRenderText: Bool
        switch block.blockStyle {
        case .Recommendation:
            backgroundColor = Colors.articleRecommendationBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        case .BlockQuote:
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        case .Information:
            backgroundColor = Colors.articleInformationBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        default:
            backgroundColor = Colors.imageBackgroundColor
            padding = UIEdgeInsets()
            shouldRenderText = true
        }

        // caption
        var caption: NSAttributedString? = nil
        if let string = block.caption where shouldRenderText {
            let attributes = StringAttributes(
                font: Fonts.alternativeTextFont.fallbackWithSize(16),
                foregroundColor: Colors.defaultFontColor,
                lineSpacing: 3,
                hyphenationFactor: 0.8,
                styleSheet: .shared
            )
            caption = NSAttributedString(string: string, attributes: attributes, style: block.blockStyle)
        }
        
        // credit
        var credit: NSAttributedString? = nil
        if let string = block.credit where shouldRenderText {
            let attributes = StringAttributes(
                font: Fonts.alternativeMediumFont.fallbackWithSize(15),
                foregroundColor: Colors.defaultFontColor,
                lineSpacing: 3,
                styleSheet: nil
            )
            credit = NSAttributedString(string: string, attributes: attributes, style: block.blockStyle)
        }
        
        let content = ImageNodeContent(
            image: image,
            caption: caption,
            credit: credit,
            backgroundColor: backgroundColor,
            padding: padding
        )
        return ImageNode(content: content)
    }
    
    //MARK: - Divider
    func dividerNode(dividerBlock block: DividerBlock) -> DividerNode {
        let backgroundColor: UIColor
        let line: Line
        let padding: UIEdgeInsets
        
        switch (block.blockContext, block.blockStyle) {
        case (.Article, .Inset):
            backgroundColor = Colors.insetBackgroundColor
            line = Line(color: Colors.insetLineColor, thickness: 1)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .Recommendation):
            backgroundColor = Colors.articleRecommendationBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .BlockQuote):
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .Information):
            backgroundColor = Colors.articleInformationBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, _):
            backgroundColor = Colors.articleBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        case (.Timeline, _):
            backgroundColor = Colors.timelineBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        default:
            backgroundColor = Colors.dividerBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
    
        var label: Label? = nil
        if let string = block.label {
            let attributes = StringAttributes(font: Fonts.labelFont.fallbackWithSize(10), foregroundColor: Colors.dividerTextColor, lineSpacing: 0)
            let text = NSAttributedString(string: string, attributes: attributes)
            label = Label(text: text, insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
        
        let content = DividerNodeContent(line: line, label: label, backgroundColor: backgroundColor, padding: padding)
        return DividerNode(content: content)
    }
    
    //MARK: - EnhancedBanner
    func enhancedBannerNode(enhancedBannerBlock block: EnhancedBannerBlock) -> EnhancedBannerNode {
        // Buttons
        let buttons: [Button]? = block.buttons?.map { button in
            let titleColor: UIColor
            let backgroundColor: UIColor
            let border: Border?
            
            switch button.style {
            case .Primary:
                titleColor = Colors.overlayFontColor
                backgroundColor = Colors.callToActionColor
                border = nil
            case .Normal:
                titleColor = Colors.defaultFontColor
                backgroundColor = Colors.normalButtonColor
                border = Border(color: Colors.buttonBorderColor, width: 1)
            }
            
            let attributes = StringAttributes(
                font: Fonts.alternativeMediumFont.fallbackWithSize(15),
                foregroundColor: titleColor,
                lineSpacing: 3,
                alignment: .Center
            )
            
            let title = NSAttributedString(string: button.title, attributes: attributes)
            let tracker = trackerFactory.createTracker(button.trackingData)
            return Button(title: title,
                size: CGSize(width: 272, height: 48),
                border: border,
                cornerInfo: CornerInfo(radius: 2),
                backgroundColor: backgroundColor,
                action: .OpenURL(button.URL),
                tracker: tracker
            )
        }
        
        // Action - With only one button, tapping on the banner triggers te same action as the button
        var action: Action? = nil
        if let buttons = buttons where buttons.count == 1 {
            action = buttons[0].action
        }
        
        // Title
        var title: NSAttributedString? = nil
        if let string = block.title {
            let lineSpacing: CGFloat = block.blockStyle == .XL ? 1 : 6
            let attributes = StringAttributes(font: Fonts.largeFont.fallbackWithSize(30), foregroundColor: Colors.defaultFontColor, lineSpacing: lineSpacing, alignment: .Center)
            title = NSAttributedString(string: string, attributes: attributes)
        }
        
        // Subtitle
        var subtitle: NSAttributedString? = nil
        if let string = block.subtitle {
            let attributes = StringAttributes(font: Fonts.lightFont.fallbackWithSize(22), foregroundColor: Colors.defaultFontColor, lineSpacing: 3, alignment: .Center)
            subtitle = NSAttributedString(string: string, attributes: attributes)
        }
        
        // Image
        var imageContent: ImageNodeContent? = nil
        var gradient: LinearGradient? = nil
        if let media = block.media {
            let image: Image
            switch block.blockStyle {
            case .XL:
                let URL = imagePolicy.URL(media: media, size: ImageSize.Fullscreen)
                image = Image(URL: URL, aspectRatio: Screen.aspectRatio)
                
                // add gradient in case of both image and buttons
                if buttons != nil {
                    gradient = LinearGradient(
                        colors: [.clearColor(), .blackColor()],
                        start: CGPoint(x: 0.5, y: 0.3),
                        end: CGPoint(x: 0.5, y: 1.5)
                    )
                }
            default:
                let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
                let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
                image = Image(URL: URL, aspectRatio: aspectRatio)
            }
            
            imageContent = ImageNodeContent(image: image, gradient: gradient, backgroundColor: Colors.defaultBackgroundColor)
        }
        
        // Padding
        let padding: UIEdgeInsets
        switch (block.blockContext) {
        case .Timeline:
            padding = UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
        case .Article:
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        case .Paywall, .Onboarding:
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        default:
            padding = UIEdgeInsets()
        }
        
        let height: CGFloat? = block.blockStyle == .XL ? Screen.height : nil
        let content = EnhancedBannerNodeContent(
            title: title,
            subtitle: subtitle,
            image: imageContent,
            buttons: buttons,
            action: action,
            spacing: 30,
            height: height,
            backgroundColor: Colors.defaultBackgroundColor,
            padding: padding
        )
        
        return EnhancedBannerNode(content: content)
    }
    
    //MARK: - Tweet
    func tweetNode(tweetBlock block: TweetBlock) -> TweetNode {
        // title
        var title: NSAttributedString? = nil
        if let string = block.headline {
            let attributes = StringAttributes(
                font: Fonts.tweetTitleFont.fallbackWithSize(16),
                foregroundColor: Colors.tweetTextColor,
                lineSpacing: 7,
                hyphenationFactor: 0.5
            )
            
            title = NSAttributedString(string: string, attributes: attributes)
        }
        
        // text
        var text: NSAttributedString? = nil
        if let string = block.richText {
            let attributes = StringAttributes(
                font: Fonts.tweetFont.fallbackWithSize(16),
                foregroundColor: Colors.tweetTextColor,
                lineSpacing: 2,
                hyphenationFactor: 0.8,
                styleSheet: .shared
            )
            text = NSAttributedString(string: string, attributes: attributes, style: block.blockStyle)
        }
        
        // author
        let authorAttributes = StringAttributes(
            font: Fonts.tweetFont.fallbackWithSize(14),
            foregroundColor: Colors.tweetAuthorColor,
            lineSpacing: 0,
            hyphenationFactor: 0.8
        )
        let author = NSAttributedString(string: block.author, attributes: authorAttributes)
        
        // timestamp
        var timestamp: NSAttributedString? = nil
        if let date = block.date {
            let string = tweetDateFormatter.stringFromDate(date)
            let attributes = StringAttributes(
                font: Fonts.tweetFont.fallbackWithSize(14),
                foregroundColor: Colors.tweetTimestampColor,
                lineSpacing: 3,
                hyphenationFactor: 0
            )
            timestamp = NSAttributedString(string: string, attributes: attributes)
        }
        
        // photo
        var photo: Image? = nil
        if let media = block.photos?.first {
            let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
            let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
            photo = Image(URL: URL, aspectRatio: aspectRatio)
        }
        
        // icon
        let iconMedia = block.media
        let iconSize = TweetNode.iconSize
        let iconURL = imagePolicy.URL(media: iconMedia, size: iconSize)
        let aspectRatio = iconSize.width / iconSize.height
        let icon = Image(URL: iconURL, aspectRatio: aspectRatio)
        
        let content = TweetNodeContent(
            title: title,
            text: text,
            author: author,
            timestamp: timestamp,
            URL: block.URL,
            icon: icon,
            photo: photo,
            backgroundColor: Colors.cellBackgroundColor,
            padding: UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
        )
        
        return TweetNode(content: content)
    }
    
    //MARK: - Youtube
    func youtubeNode(youtubeBlock block: YoutubeBlock) -> YoutubeNode {
        //placeholder
        let media = block.media
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let placeholder = Image(URL: URL, aspectRatio: aspectRatio)
        
        var title: NSAttributedString? = nil
        if let string = block.title {
            let attributes = StringAttributes(
                font: Fonts.mediumFont.fallbackWithSize(18),
                foregroundColor: Colors.overlayFontColor,
                lineSpacing: 3,
                hyphenationFactor: 0.8
            )
            
            title = NSAttributedString(string: string, attributes: attributes)
        }
        
        let content = YoutubeNodeContent(
            identifier: block.movieID,
            placeholder: placeholder,
            playlist: block.playlistID,
            loop: block.loop,
            title: title,
            backgroundColor: Colors.cellBackgroundColor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        )
        
        return YoutubeNode(content: content)
    }
    
    //MARK: - Vimeo
    func vimeoNode(vimeoBlock block: VimeoBlock) -> VimeoNode {
        //placeholder
        let media = block.media
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let placeholder = Image(URL: URL, aspectRatio: aspectRatio)
        
        var title: NSAttributedString? = nil
        if let string = block.title {
            let attributes = StringAttributes(
                font: Fonts.mediumFont.fallbackWithSize(18),
                foregroundColor: Colors.overlayFontColor,
                lineSpacing: 3,
                hyphenationFactor: 0.8
            )
            
            title = NSAttributedString(string: string, attributes: attributes)
        }
        
        let content = StreamingVideoContent(identifier: block.movieID,
                                            placeholder: placeholder,
                                            title: title,
                                            backgroundColor: Colors.cellBackgroundColor,
                                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        )
        
        return VimeoNode(content: content)
    }
    
    //MARK: - Video
    func videoNode(videoBlock block: VideoBlock) -> VideoNode {
        let media: Media = .null// block.media
        let aspectRatio = block.aspectRatio //media.aspectRatio ?? Media.defaultAspectRatio
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let placeholder = Image(URL: URL, aspectRatio: aspectRatio)
        
        let content = VideoNodeContent(
            URL: block.URL,
            placeholder: placeholder,
            autorepeat: block.autorepeat,
            autoplay: block.autoplay,
            controls:  block.controls,
            title: nil,
            backgroundColor: Colors.imageBackgroundColor,
            padding: UIEdgeInsets()
        )
        
        return VideoNode(content: content)
    }
}

//MARK: - Styling
private extension Theme {
    var backgroundColor: UIColor {
        switch self {
        case .Highlight:
            return Colors.nrcRedLight
        case .Live:
            return Colors.nrcRed
        case .Urgent:
            return Colors.nrcAnthracite
        default:
            return Colors.cellBackgroundColor
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .Live, .Urgent:
            return Colors.overlayFontColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var bullet: Bullet? {
        guard self == .Live else { return nil }
        return Bullet(color: .whiteColor(), radius: 4, pulsate: true)
    }
}

private extension ArticleRefBlock {
    var lineModel: Line? {
        let thickness: CGFloat = 0.5
        let color: UIColor
        
        // setup line by decoration and theme
        switch (decoration, theme) {
        case (.Bottom, _), (.None, _):
            // bottom and none decorations do not have a line
            return nil
        case (_, .Urgent):
            color = UIColor(hex: 0x555555)
        case (_, .Live), (_, .Highlight):
            color = UIColor(hex: 0xD9BBBB)
        default:
            color = Colors.defaultLineColor
        }
        
        return Line(color: color, thickness: thickness)
    }
    
    var labelModel: Label? {
        guard let string = label else { return nil }

        let textColor: UIColor
        let insets: UIEdgeInsets
        let backgroundColor: UIColor?
        let border: Border?
        let corners: CornerInfo?
        
        switch (blockStyle, theme) {
        case (.Large, .Urgent),(.Large, .Live),(.Large, .Highlight):
            textColor = .whiteColor()
            insets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            backgroundColor = UIColor(hex: 0xD30910)
            border = nil
            corners = CornerInfo(radius: 10)
        case (.Large, .Default):
            textColor = Colors.labelTextColor
            insets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            backgroundColor = Colors.labelBackgroundColor
            border = Border(color: Colors.labelBorderColor, width: 0.5)
            corners = CornerInfo(radius: 10)
        default:
            textColor = Colors.labelTextColor
            insets = UIEdgeInsets()
            backgroundColor = nil
            border = nil
            corners = nil
        }
        
        let attributes = StringAttributes(
            font: Fonts.labelFont.fallbackWithSize(10),
            foregroundColor: textColor,
            lineSpacing: 0
        )
        let text = NSAttributedString(string: string, attributes: attributes)

        return Label(
            text: text,
            insets: insets,
            backgroundColor: backgroundColor,
            corners: corners,
            border: border,
            bullet: theme.bullet
        )
    }
}

// MARK - Decoration
extension DecorationLayerModel {
    static func model(block block: Block) -> DecorationLayerModel {
        switch (block.blockContext, block.blockStyle, block) {
        case (.Article, .Inset, _):
            return .inset
        case (.Article, _, is TweetBlock):
            return tweet
        case (.Article, _, _):
            return .article
        case (.Timeline, _, _):
            return .timeline
        default:
            return .null
        }
    }
    
    static var timeline: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.timelineBackgroundColor,
            cornerInfo: CornerInfo(radius: 8),
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        )
    }
    
    static var article: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.articleBackgroundColor,
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        )
    }
    
    static var inset: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.articleBackgroundColor,
            border: Border(color: Colors.insetLineColor),
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top:0, left: 20, bottom: 20, right: 20)
        )
    }
    
    static var tweet: DecorationLayerModel {
        return  DecorationLayerModel(
            color: Colors.tweetBackgroundColor,
            border: Border(color: Colors.tweetBorderColor, width: 0.5),
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        )
    }
    
    // null value has no color, no padding, no border and no corner radius
    static var null: DecorationLayerModel {
        return DecorationLayerModel(
            color: UIColor.clearColor()
        )
    }
}
