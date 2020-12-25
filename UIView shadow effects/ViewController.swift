//
//  ViewController.swift
//  UIView shadow effects
//
//  Created by Salah Amassi on 24/12/2020.
//

// This project it's just playing around shadow based on https://www.hackingwithswift.com/articles/155/advanced-uiview-shadow-effects-using-shadowpath all code and comment's here blong to Paul Hudson, im just trygin to put it togther and playing around it to get full understand shadow and shadow path.

import UIKit

class ViewController: UIViewController {
    
    enum ShadowType: String{
        case regular, contact, depth, flat, curved
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = shadowType.rawValue.capitalized
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pexels-photo-3944311"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        return imageView
    }()
    
    lazy var shadowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("change shadow type", for: .normal)
        button.addTarget(self, action: #selector(performShadowButtonButtonAction), for: .primaryActionTriggered)
        return button
    }()
    
    lazy var shadowRadiusSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.value = 3
        slider.addTarget(self, action: #selector(shadowRadiusSliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowOpacitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.4
        slider.addTarget(self, action: #selector(shadowOpacityValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 40
        slider.value = 20
        slider.addTarget(self, action: #selector(shadowSizeValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowDistanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 40
        slider.value = 20
        slider.addTarget(self, action: #selector(shadowDistanceValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowWidthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.5
        slider.maximumValue = 2
        slider.value = 1
        slider.addTarget(self, action: #selector(shadowWidthValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowHeightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.5
        slider.maximumValue = 2
        slider.value = 1
        slider.addTarget(self, action: #selector(shadowHeightValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowOffsetXSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = -200
        slider.maximumValue = 200
        slider.value = 0
        slider.addTarget(self, action: #selector(shadowOffsetXValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowOffsetWidthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 40
        slider.value = 3
        slider.addTarget(self, action: #selector(shadowOffsetWidthValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var shadowOffsetHeightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 40
        slider.value = 3
        slider.addTarget(self, action: #selector(shadowOffsetHeightValueChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var curveAmountSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 40
        slider.value = 20
        slider.addTarget(self, action: #selector(curveAmountValueChanged), for: .valueChanged)
        return slider
    }()
    
    let contentScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.layoutMargins = .init(top: 32, left: 32, bottom: 32, right: 32)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var shadowType = ShadowType.regular
    
    /// controls how blurred the shadow is. This defaults to 3 points
    var shadowRadius: CGFloat = 3
    /// controls how transparent the shadow is. This defaults to 0, meaning “invisible”.
    var shadowOpacity: Float = 0.4
    /// controls how much shadow wider than the view
    var shadowSize: CGFloat = 20
    /// constant that moves the shadow further away from the view, making it look like the view is floating
    var shadowDistance: CGFloat = 20
    /// how wide the shadow should be, where 1.0 is identical to the view
    var shadowWidth: CGFloat = 1
    /// how high the shadow should be, where 1.0 is identical to the view
    var shadowHeight: CGFloat = 1
    /// how far the bottom of the shadow should be offset
    var shadowOffsetX: CGFloat = 0
    /// controls how far the shadow is moved away from its view in x axis. This defaults to 3 points up from the view.
    var shadowOffsetWidth: CGFloat = 3
    /// controls how far the shadow is moved away from its view in y axis. This defaults to 3 points up from the view.
    var shadowOffsetHeight: CGFloat = 3
    /// how strong to make the curling effect
    var curveAmount: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(contentScrollStackView)
        
        contentScrollStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentScrollStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        contentScrollStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentScrollStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        contentScrollStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        
        let shadowRadiusLabel = UILabel()
        shadowRadiusLabel.text = "Shadow Radius"
        shadowRadiusLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowRadiusStack = UIStackView(arrangedSubviews: [shadowRadiusLabel, shadowRadiusSlider])
        shadowRadiusStack.axis = .vertical
        
        let shadowOpacityLabel = UILabel()
        shadowOpacityLabel.text = "Shadow Opacity"
        shadowOpacityLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowOpacityStack = UIStackView(arrangedSubviews: [shadowOpacityLabel, shadowOpacitySlider])
        shadowOpacityStack.axis = .vertical
        
        let shadowSizeLabel = UILabel()
        shadowSizeLabel.text = "Shadow Size"
        shadowSizeLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowSizeStack = UIStackView(arrangedSubviews: [shadowSizeLabel, shadowSizeSlider])
        shadowSizeStack.axis = .vertical
        shadowSizeStack.isHidden = true
        
        let shadowDistanceLabel = UILabel()
        shadowDistanceLabel.text = "Shadow Distance"
        shadowDistanceLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowDistanceStack = UIStackView(arrangedSubviews: [shadowDistanceLabel, shadowDistanceSlider])
        shadowDistanceStack.axis = .vertical
        shadowDistanceStack.isHidden = true
        
        let shadowWidthLabel = UILabel()
        shadowWidthLabel.text = "Shadow Width"
        shadowWidthLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowWidthStack = UIStackView(arrangedSubviews: [shadowWidthLabel, shadowWidthSlider])
        shadowWidthStack.axis = .vertical
        shadowWidthStack.isHidden = true
        
        let shadowHeightLabel = UILabel()
        shadowHeightLabel.text = "Shadow Height"
        shadowHeightLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowHeightStack = UIStackView(arrangedSubviews: [shadowHeightLabel, shadowHeightSlider])
        shadowHeightStack.axis = .vertical
        shadowHeightStack.isHidden = true
        
        let shadowOffsetXLabel = UILabel()
        shadowOffsetXLabel.text = "Shadow Offset X"
        shadowOffsetXLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowOffsetXStack = UIStackView(arrangedSubviews: [shadowOffsetXLabel, shadowOffsetXSlider])
        shadowOffsetXStack.axis = .vertical
        shadowOffsetXStack.isHidden = true
        
        let shadowOffsetWidthLabel = UILabel()
        shadowOffsetWidthLabel.text = "Shadow Offset Width"
        shadowOffsetWidthLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowOffsetWidthStack = UIStackView(arrangedSubviews: [shadowOffsetWidthLabel, shadowOffsetWidthSlider])
        shadowOffsetWidthStack.axis = .vertical
        shadowOffsetWidthStack.isHidden = true
        
        let shadowOffsetHeightLabel = UILabel()
        shadowOffsetHeightLabel.text = "Shadow Offset Height"
        shadowOffsetHeightLabel.font = UIFont.systemFont(ofSize: 12)
        let shadowOffsetHeightStack = UIStackView(arrangedSubviews: [shadowOffsetHeightLabel, shadowOffsetHeightSlider])
        shadowOffsetHeightStack.axis = .vertical
        shadowOffsetHeightStack.isHidden = true
        
        let curveAmountLabel = UILabel()
        curveAmountLabel.text = "Curve Amount"
        curveAmountLabel.font = UIFont.systemFont(ofSize: 12)
        let curveAmountStack = UIStackView(arrangedSubviews: [curveAmountLabel, curveAmountSlider])
        curveAmountStack.axis = .vertical
        curveAmountStack.isHidden = true
        
        contentScrollStackView.addArrangedSubview(titleLabel)
        contentScrollStackView.addArrangedSubview(imageView)
        contentScrollStackView.addArrangedSubview(shadowRadiusStack)
        contentScrollStackView.addArrangedSubview(shadowOpacityStack)
        contentScrollStackView.addArrangedSubview(shadowSizeStack)
        contentScrollStackView.addArrangedSubview(shadowDistanceStack)
        contentScrollStackView.addArrangedSubview(shadowWidthStack)
        contentScrollStackView.addArrangedSubview(shadowHeightStack)
        contentScrollStackView.addArrangedSubview(shadowOffsetXStack)
        contentScrollStackView.addArrangedSubview(shadowOffsetWidthStack)
        contentScrollStackView.addArrangedSubview(shadowOffsetHeightStack)
        contentScrollStackView.addArrangedSubview(curveAmountStack)
        contentScrollStackView.addArrangedSubview(shadowButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        regluarShadow()
    }
    
    func regluarShadow(){
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
        imageView.layer.shadowRadius = shadowRadius
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = shadowOpacity
    }
    
    /// A contact shadow is one that makes it look like our view is near to or even touching a surface, so the shadow exists directly below the view rather than around it.
    func contactShadow(){
        let width = imageView.frame.width
        let height = imageView.frame.height
        let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4) + shadowDistance, width: width + shadowSize * 2, height: shadowSize)
        imageView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        imageView.layer.shadowRadius = shadowRadius
        imageView.layer.shadowOpacity = shadowOpacity
        contentScrollStackView.setCustomSpacing(shadowSize + shadowDistance + 15, after: imageView)
    }
    
    /// You can add a 3D effect to your view by casting a shadow in front of it. This is done by creating another custom UIBezierPath shadow path where we position the top of the shadow at the bottom of our view, and the bottom of the shadow some distance further down. We then bring the bottom edges of the shadow outwards so that it’s wider on the bottom than it is at the top, giving a perspective effect.
    func depthShadow(){
        let width = imageView.frame.width
        let height = imageView.frame.height
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width * shadowWidth + shadowOffsetX, y: height + (height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1) + shadowOffsetX, y: height + (height * shadowHeight)))
        imageView.layer.shadowPath = shadowPath.cgPath
        imageView.layer.shadowRadius = shadowRadius
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = shadowOpacity
        contentScrollStackView.setCustomSpacing((height * shadowHeight) + 15, after: imageView)
    }
    
    /// This shadow effect is particularly prevalent in modern design, where shadows are more of a design feature rather than providing any sort of function. Here, the shadow is sharp-edged and moves continuously off into the infinite distance at 45-degree angle.
    func flatShadow(){
        let width = imageView.frame.width
        let height = imageView.frame.height
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: 0))
        // make the bottom of the shadow finish a long way away, and pushed by our X offset
        shadowPath.addLine(to: CGPoint(x: width + shadowOffsetX, y: shadowOffsetX))
        shadowPath.addLine(to: CGPoint(x: shadowOffsetX, y: shadowOffsetX))
        imageView.layer.shadowPath = shadowPath.cgPath
        imageView.layer.shadowOffset = .zero
        contentScrollStackView.setCustomSpacing(height, after: imageView)
    }
    
    /// You can use any sort of UIBezierPath for your shadow path, which means if you add some curves it’s easy to make a page curl effect similar to the kind of thing you’ll find in Apple’s Keynote.
    func curvedShadow(){
        let width = imageView.frame.width
        let height = imageView.frame.height
        imageView.layer.shadowRadius = shadowRadius
        imageView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        imageView.layer.shadowOpacity = shadowOpacity
        
        let shadowPath = UIBezierPath()
        
        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))
        
        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))
        
        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        imageView.layer.shadowPath = shadowPath.cgPath
        
        contentScrollStackView.setCustomSpacing(curveAmount + 15, after: imageView)
    }
    
    private func reset(for type: ShadowType){
        shadowType = type
        titleLabel.text = type.rawValue.capitalized
        contentScrollStackView.setCustomSpacing(15, after: imageView)
        switch type {
        case .regular:
            shadowRadius = 3
            shadowOpacity = 1
            shadowRadiusSlider.superview?.isHidden = false
            shadowOpacitySlider.superview?.isHidden = false
            shadowSizeSlider.superview?.isHidden = true
            shadowDistanceSlider.superview?.isHidden = true
            shadowWidthSlider.superview?.isHidden = true
            shadowHeightSlider.superview?.isHidden = true
            shadowOffsetXSlider.superview?.isHidden = true
            shadowOffsetWidthSlider.superview?.isHidden = true
            shadowOffsetHeightSlider.superview?.isHidden = true
            curveAmountSlider.superview?.isHidden = true
            regluarShadow()
        case .contact:
            shadowRadius = 5
            shadowOpacity = 0.4
            shadowSize = 20
            shadowDistance = 20
            shadowRadiusSlider.superview?.isHidden = false
            shadowOpacitySlider.superview?.isHidden = false
            shadowSizeSlider.superview?.isHidden = false
            shadowDistanceSlider.superview?.isHidden = false
            shadowWidthSlider.superview?.isHidden = true
            shadowHeightSlider.superview?.isHidden = true
            shadowOffsetXSlider.superview?.isHidden = true
            shadowOffsetWidthSlider.superview?.isHidden = true
            shadowOffsetHeightSlider.superview?.isHidden = true
            curveAmountSlider.superview?.isHidden = true
            contactShadow()
        case .depth:
            shadowRadius = 5
            shadowOpacity = 0.2
            shadowWidth = 1.25
            shadowHeight = 0.5
            shadowOffsetX = 0
            shadowRadiusSlider.superview?.isHidden = false
            shadowOpacitySlider.superview?.isHidden = false
            shadowSizeSlider.superview?.isHidden = true
            shadowDistanceSlider.superview?.isHidden = true
            shadowWidthSlider.superview?.isHidden = false
            shadowHeightSlider.superview?.isHidden = false
            shadowOffsetXSlider.superview?.isHidden = false
            shadowOffsetWidthSlider.superview?.isHidden = true
            shadowOffsetHeightSlider.superview?.isHidden = true
            curveAmountSlider.superview?.isHidden = true
            depthShadow()
        case .flat:
            shadowRadius = 0
            shadowOpacity = 0.2
            shadowOffsetX = 2000
            shadowOffsetXSlider.minimumValue = -2000
            shadowOffsetXSlider.maximumValue = 2000
            shadowOffsetXSlider.value = 0
            shadowRadiusSlider.superview?.isHidden = true
            shadowOpacitySlider.superview?.isHidden = true
            shadowSizeSlider.superview?.isHidden = true
            shadowDistanceSlider.superview?.isHidden = true
            shadowWidthSlider.superview?.isHidden = true
            shadowHeightSlider.superview?.isHidden = true
            shadowOffsetXSlider.superview?.isHidden = false
            shadowOffsetWidthSlider.superview?.isHidden = true
            shadowOffsetHeightSlider.superview?.isHidden = true
            curveAmountSlider.superview?.isHidden = true
            flatShadow()
        case .curved:
            shadowRadius = 5
            shadowOpacity = 0.5
            shadowOffsetWidth = 0
            shadowOffsetHeight = 10
            curveAmount = 20
            shadowRadiusSlider.superview?.isHidden = false
            shadowOpacitySlider.superview?.isHidden = false
            shadowSizeSlider.superview?.isHidden = true
            shadowDistanceSlider.superview?.isHidden = true
            shadowWidthSlider.superview?.isHidden = true
            shadowHeightSlider.superview?.isHidden = true
            shadowOffsetXSlider.superview?.isHidden = true
            shadowOffsetWidthSlider.superview?.isHidden = false
            shadowOffsetHeightSlider.superview?.isHidden = false
            curveAmountSlider.superview?.isHidden = false
            curvedShadow()
        }
        shadowRadiusSlider.setValue(Float(shadowRadius), animated: true)
        shadowOpacitySlider.setValue(shadowOpacity, animated: true)
        shadowSizeSlider.setValue(Float(shadowSize), animated: true)
        shadowDistanceSlider.setValue(Float(shadowDistance), animated: true)
        shadowHeightSlider.setValue(Float(shadowHeight), animated: true)
        shadowWidthSlider.setValue(Float(shadowWidth), animated: true)
        shadowOffsetXSlider.setValue(Float(shadowOffsetX), animated: true)
        shadowOffsetWidthSlider.setValue(Float(shadowOffsetWidth), animated: true)
        shadowOffsetHeightSlider.setValue(Float(shadowOffsetHeight), animated: true)
        curveAmountSlider.setValue(Float(curveAmount), animated: true)
    }
    
    @objc
    private func shadowRadiusSliderValueChanged(){
        shadowRadius = CGFloat(shadowRadiusSlider.value)
        imageView.layer.shadowRadius = shadowRadius
    }
    
    @objc
    private func shadowOpacityValueChanged(){
        shadowOpacity = shadowOpacitySlider.value
        imageView.layer.shadowOpacity = shadowOpacity
    }
    
    @objc
    private func shadowSizeValueChanged(){
        shadowSize = CGFloat(shadowSizeSlider.value)
        contactShadow()
    }
    
    @objc
    private func shadowDistanceValueChanged(){
        shadowDistance = CGFloat(shadowDistanceSlider.value)
        contactShadow()
    }
    
    @objc
    private func shadowWidthValueChanged(){
        shadowWidth = CGFloat(shadowWidthSlider.value)
        if shadowType == .depth{
            depthShadow()
        }else{
            flatShadow()
        }
    }
    
    @objc
    private func shadowHeightValueChanged(){
        shadowHeight = CGFloat(shadowHeightSlider.value)
        depthShadow()
    }
    
    @objc
    private func shadowOffsetXValueChanged(){
        shadowOffsetX = CGFloat(shadowOffsetXSlider.value)
        if shadowType == .depth{
            depthShadow()
        }else{
            flatShadow()
        }
    }
    
    @objc
    private func shadowOffsetWidthValueChanged(){
        shadowOffsetWidth = CGFloat(shadowOffsetWidthSlider.value)
        curvedShadow()
    }
    
    @objc
    private func shadowOffsetHeightValueChanged(){
        shadowOffsetHeight = CGFloat(shadowOffsetHeightSlider.value)
        curvedShadow()
    }
    
    @objc
    private func curveAmountValueChanged(){
        curveAmount = CGFloat(curveAmountSlider.value)
        curvedShadow()
    }
    
    @objc
    private func performShadowButtonButtonAction(){
        let alert = UIAlertController(title: "Change style", message: nil, preferredStyle: .actionSheet)
        alert.addAction(.init(title: "Regular Shadow", style: .default, handler: { (action) in
            self.reset(for: .regular)
        }))
        alert.addAction(.init(title: "Contact Shadow", style: .default, handler: { (action) in
            self.reset(for: .contact)
        }))
        
        alert.addAction(.init(title: "Depth Shadow", style: .default, handler: { (action) in
            self.reset(for: .depth)
        }))
        
        alert.addAction(.init(title: "Flat Shadow", style: .default, handler: { (action) in
            self.reset(for: .flat)
        }))
        
        alert.addAction(.init(title: "Curved Shadow", style: .default, handler: { (action) in
            self.reset(for: .curved)
        }))
        
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

