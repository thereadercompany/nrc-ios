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
        var decoration: Decoration? = Decoration(type: block.decoration, layerModel: decorationLayerModel)
        
        let node: ASDisplayNode
        switch block {
        case let sectionRef as SectionRefBlock:
            node = sectionRefNode(sectionRefBlock: sectionRef)
        case let articleRef as ArticleRefBlock:
            node = articleRefNode(articleRefBlock: articleRef)
        case let bylineBlock as BylineBlock:
            node = bylineNode(bylineBlock: bylineBlock)
        case let spacingBlock as SpacingBlock:
            node = spacingNode(spacingBlock: spacingBlock)
            decoration = nil
        case let textBlock as TextBlock:
            node = textNode(textBlock: textBlock)
        case let plainTextBlock as PlainTextBlock:
            node = textNode(textBlock: plainTextBlock)
        case let imageBlock as ImageBlock:
            node = imageNode(imageBlock: imageBlock)
        case let dividerBlock as DividerBlock:
            node = dividerNode(dividerBlock: dividerBlock)
        case let enhancedBannerBlock as EnhancedBannerBlock:
            node = enhancedBannerNode(enhancedBannerBlock: enhancedBannerBlock)
        case let tweetBlock as TweetBlock:
            node = tweetNode(tweetBlock: tweetBlock)
        case let youtubeBlock as YoutubeBlock:
            node = youtubeNode(youtubeBlock: youtubeBlock)
        case let vimeoBlock as VimeoBlock:
            node = vimeoNode(vimeoBlock: vimeoBlock)
        case let videoBlock as VideoBlock:
            node  = videoNode(videoBlock: videoBlock)
        case let streamerBlock as StreamerBlock:
            node = streamerNode(streamerBlock: streamerBlock)
        default:
            node = FallbackContentNode(renderable: block)
            decoration = nil
        }
        
        let cell = NRCCell(contentNode: node, decoration: decoration)
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
        let focalPoint = block.media.focalPoint ?? Media.defaultFocalPoint
        let image = Image(URL: imageURL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        
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
        let padding = UIEdgeInsets(top: 0, left: ArticleStyles.contentInset, bottom: 3, right: ArticleStyles.contentInset)
        let content = BylineNodeContent(icon: block.icon, text: text, padding: padding)
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
        func insetPadding(decoration decoration: DecorationType) -> UIEdgeInsets {
            let top: CGFloat
            switch decoration {
            case .None:
                return UIEdgeInsets()
            case .Top, .Full:
                top = 15
            default:
                top = 0
            }
            
            return UIEdgeInsets(top: top, left: 15, bottom: 15, right: 15)
        }
        
        let font: UIFont
        let lineSpacing: CGFloat
        
        var padding = UIEdgeInsets(top: 0, left: ArticleStyles.contentInset, bottom: 25, right: ArticleStyles.contentInset)
        var textColor = Colors.defaultFontColor
        var backgroundColor = Colors.cellBackgroundColor
        
        switch block.blockStyle {
        case .Normal:
            font = Fonts.textFont.fallbackWithSize(17)
            lineSpacing =  8
        case .BlockQuote:
            font = Fonts.mediumFont.fallbackWithSize(17)
            lineSpacing = 7
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Information:
            font = Fonts.mediumFont.fallbackWithSize(17)
            lineSpacing = 7
            backgroundColor = Colors.articleInformationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Recommendation:
            font = Fonts.lightFont.fallbackWithSize(17)
            lineSpacing = 7
            backgroundColor = Colors.articleRecommendationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Inset:
            font = Fonts.alternativeTextFont.fallbackWithSize(15)
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
            lineSpacing = 6
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: block.decoration)
        case .Intro:
            font = Fonts.lightFont.fallbackWithSize(22)
            lineSpacing = 6
            padding.bottom = 30
        case .Subheader:
            font = Fonts.textFont.fallbackWithSize(20)
            lineSpacing = 4
        default:
            font = Fonts.textFont.fallbackWithSize(16)
            lineSpacing = 0
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
            padding = UIEdgeInsets(top: 0, left: ArticleStyles.contentInset, bottom: 14, right: ArticleStyles.contentInset)
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
            padding = UIEdgeInsets(top: 0, left: ArticleStyles.contentInset, bottom: 25, right: ArticleStyles.contentInset)
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
        let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
        let image = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        
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
        var line = Line(color: Colors.dividerLineColor, size: CGSize(width: .max, height: 0.5))
        var padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        switch (block.blockContext, block.blockStyle) {
        case (.Article, .Inset):
            backgroundColor = Colors.insetBackgroundColor
            line = Line(color: Colors.insetLineColor, size: CGSize(width: .max, height: 1))
        case (.Article, .Recommendation):
            backgroundColor = Colors.articleRecommendationBackgroundColor
        case (.Article, .BlockQuote):
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .Information):
            backgroundColor = Colors.articleInformationBackgroundColor
        case (.Article, _):
            backgroundColor = Colors.articleBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        case (.Timeline, _):
            backgroundColor = Colors.timelineBackgroundColor
        default:
            backgroundColor = Colors.dividerBackgroundColor
        }
    
        var label: Label? = nil
        if let string = block.label {
            let attributes = StringAttributes(
                font: Fonts.labelFont.fallbackWithSize(10),
                foregroundColor: Colors.dividerTextColor,
                lineSpacing: 0
            )
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
            return Button(
                title: title,
                size: CGSize(width: 272, height: 48),
                border: border,
                cornerInfo: CornerInfo(radius: 2),
                backgroundColor: backgroundColor,
                action: .OpenURL(button.URL),
                tracker: tracker
            )
        }
        
        // Action - With only one button, tapping on the banner triggers te same action as the button
        let action = buttons?.count == 1 ? buttons?.first?.action : nil
        
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
            let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
            switch block.blockStyle {
            case .XL:
                let URL = imagePolicy.URL(media: media, size: ImageSize.Fullscreen)
                image = Image(URL: URL, aspectRatio: Screen.aspectRatio, focalPoint: focalPoint)
                
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
                image = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
            }
            
            imageContent = ImageNodeContent(image: image, gradient: gradient, backgroundColor: Colors.defaultBackgroundColor)
        }
        
        // Padding
        let padding: UIEdgeInsets
        switch (block.blockContext) {
        case .Timeline:
            padding = UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
        case .Article:
            padding = UIEdgeInsets(top: 20, left: 20, bottom: 25, right: 20)
        case .Paywall, .Onboarding:
            padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
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
            let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
            let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
            photo = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        }
        
        // icon
        let media = block.media
        let iconSize = TweetNode.iconSize
        let iconURL = imagePolicy.URL(media: media, size: iconSize)
        let aspectRatio = iconSize.width / iconSize.height
        let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
        let icon = Image(URL: iconURL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        
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
        let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let placeholder = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        
        let playButtonImage = UIImage(named: "play_btn")!
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
        let overlayContent = VideoOverlayNodeContent(
            placeholder: placeholder,
            playButtonImage: playButtonImage,
            title: title
        )
        
        let content = YoutubeNodeContent(
            identifier: block.movieID,
            playlist: block.playlistID,
            loop: block.loop,
            overlayContent: overlayContent,
            backgroundColor: Colors.cellBackgroundColor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        )
        
        return YoutubeNode(content: content)
    }
    
    //MARK: - Vimeo
    func vimeoNode(vimeoBlock block: VimeoBlock) -> VimeoNode {
        //placeholder
        let media = block.media
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
        let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
        let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
        let placeholder = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
        
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
        
        // overlay
        let playButtonImage = UIImage(named: "play_btn")!
        let overlayContent = VideoOverlayNodeContent(
            placeholder: placeholder,
            playButtonImage: playButtonImage,
            title: title
        )
        
        let content = StreamingVideoContent(
            identifier: block.movieID,
            overlayContent: overlayContent,
            backgroundColor: Colors.cellBackgroundColor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        )
        
        return VimeoNode(content: content)
    }
    
    //MARK: - Video
    func videoNode(videoBlock block: VideoBlock) -> VideoNode {
        let media = block.media
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
                
        // no overlay for animated gif
        var overlayContent: VideoOverlayNodeContent? = nil
        if block.shouldShowOvelay {
            let URL = imagePolicy.URL(media: media, size: .Medium, aspectRatio: aspectRatio)
            let focalPoint = media.focalPoint ?? Media.defaultFocalPoint
            let placeholder = Image(URL: URL, aspectRatio: aspectRatio, focalPoint: focalPoint)
            let playButtonImage = UIImage(named: "play_btn")!
            
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

            overlayContent = VideoOverlayNodeContent(
                placeholder: placeholder,
                playButtonImage: playButtonImage,
                title: title
            )
        }
        
        let content = VideoNodeContent(
            URL: block.URL,
            aspectRatio: aspectRatio,
            autoplay: block.autoplay,
            autorepeat: block.autorepeat,
            overlayContent: overlayContent,
            backgroundColor: Colors.imageBackgroundColor,
            padding: UIEdgeInsets()
        )
        
        return VideoNode(content: content)
    }
    
    //MARK: - Streamer
    func streamerNode(streamerBlock block: StreamerBlock) -> StreamerNode {
        let string: String
        let firstLineHeadIndent: CGFloat?
        let headIndent: CGFloat?
        switch block.blockStyle {
        case .Normal:
            string = block.text
            firstLineHeadIndent = 4
            headIndent = 4
        case .Quote:
            string = "<quotationmark>“</quotationmark>\(block.text)<quotationmark>„</quotationmark>"
            firstLineHeadIndent = nil
            headIndent = 17
        default:
            string = block.text
            firstLineHeadIndent = nil
            headIndent = nil
        }
        
        // text
        let attributes = StringAttributes(
            font: Fonts.italicFont.fallbackWithSize(32),
            foregroundColor: Colors.defaultFontColor,
            lineSpacing: 0,
            firstLineHeadIndent: firstLineHeadIndent,
            headIndent: headIndent,
            hyphenationFactor: 0.8,
            styleSheet: .shared
        )
        let text = NSAttributedString(string: string, attributes: attributes, style: block.blockStyle)
        
        // source
        var source: NSAttributedString? = nil
        if let string = block.source {
            let attributes = StringAttributes(
                font: Fonts.mediumFont.fallbackWithSize(19),
                foregroundColor: Colors.defaultFontColor,
                lineSpacing: 0,
                firstLineHeadIndent: headIndent, // align with headindent of text
                headIndent: headIndent,
                styleSheet: .shared
            )
            source = NSAttributedString(string: string, attributes: attributes, style: block.blockStyle)
        }
        
        // lines
        let line = Line(color: Colors.streamerLineColor, size: CGSize(width: 48, height: 1))
        let content = StreamerNodeContent(text: text,
                                          source: source,
                                          lines: (line, line),
                                          backgroundColor: Colors.cellBackgroundColor,
                                          padding: UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        )
        
        return StreamerNode(content: content)
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
        
        return Line(color: color, size: CGSize(width: .max, height: thickness))
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

extension VideoBlock {
    var shouldShowOvelay: Bool {
        return blockStyle != .AnimatedGIF && !autoplay
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
