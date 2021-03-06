import UIKit
import RxSwift
import RxCocoa

class CalculatorView: BaseView {
    
    let tapBackground = UITapGestureRecognizer()
    
    let topContainerView = UIView().then {
        $0.backgroundColor = .sub_black_b1
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowOpacity = 0.3
    }
    
    let slimeImage = UIImageView().then {
        $0.image = .imgBlueSlime
    }
    
    let historyButton = UIButton().then {
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
        $0.setTitle("calculate_history".localized, for: .normal)
        $0.alpha = 0.4
    }
    
    let plRateButton = UIButton().then {
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
        $0.setTitle("calculate_pl_rate".localized, for: .normal)
    }
    
    let indicatorView = UIView().then {
        $0.backgroundColor = .sub_white_w2
    }
    
    let ridingWaterButton = UIButton().then {
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
        $0.setTitle("calculate_riding_water".localized, for: .normal)
        $0.alpha = 0.4
    }
    
    let emptyView = CalculateEmptyView()
    
    let yountchanView = CalculateYoungchanView().then {
        $0.isHidden = true
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let containerView = UIView()
    
    let currentAssetLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w2
        $0.text = "calculate_current_asset".localized
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    let avgField = CalculateField().then {
        $0.setAttributedPlaceholder(placeholder: "calculate_avg".localized)
    }
    
    let amountField = CalculateField().then {
        $0.setAttributedPlaceholder(placeholder: "calculate_amount".localized)
    }
    
    let purchasedLabel = PaddingLabel(
        topInset: 11,
        bottomInset: 11,
        leftInset: 13,
        rightInset: 13
    ).then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .sub_black_b2
        $0.font = .caption1_12R
        $0.textColor = .sub_gray_40
    }
    
    let goalLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w2
        $0.text = "calculate_gole".localized
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    let warningLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .secondary_red_default
        $0.text = "+1000%?????? ?????? ????????????"
    }
    
    let goalPLRateField = CalculateField().then {
        $0.setAttributedPlaceholder(placeholder: "calculate_goal_pl_rate".localized)
    }
    
    let shareButton = LargeButton(theme: .purple).then {
        $0.setTitle("calculate_share".localized, for: .normal)
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addGestureRecognizer(self.tapBackground)
        self.containerView.addSubviews(
            self.currentAssetLabel,
            self.avgField,
            self.amountField,
            self.purchasedLabel,
            self.goalLabel,
            self.warningLabel,
            self.goalPLRateField,
            self.shareButton
        )
        self.scrollView.addSubviews(self.containerView)
        self.addSubviews(
            self.scrollView,
            self.topContainerView,
            self.slimeImage,
            self.historyButton,
            self.plRateButton,
            self.indicatorView,
            self.ridingWaterButton,
            self.emptyView,
            self.yountchanView
        )
    }
    
    override func bindConstraints() {
        self.topContainerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.emptyView).offset(20)
        }
        
        self.slimeImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-89)
            make.right.equalToSuperview().offset(81)
        }
        
        self.historyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
        }
        
        self.plRateButton.snp.makeConstraints { make in
            make.left.equalTo(self.historyButton.snp.right).offset(24)
            make.centerY.equalTo(self.historyButton)
        }
        
        self.indicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(self.plRateButton)
            make.bottom.equalTo(self.plRateButton).offset(5)
            make.width.equalTo(44)
            make.height.equalTo(2)
        }
        
        self.ridingWaterButton.snp.makeConstraints { make in
            make.left.equalTo(self.plRateButton.snp.right).offset(24)
            make.centerY.equalTo(self.historyButton)
        }
        
        self.emptyView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(75)
        }
        
        self.yountchanView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(67)
            make.left.right.equalToSuperview()
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.topContainerView.snp.bottom)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.equalTo(self.currentAssetLabel).inset(34).priority(.high)
            make.bottom.equalTo(self.shareButton)
        }
        
        self.currentAssetLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.left.equalToSuperview().offset(20)
        }
        
        self.avgField.snp.makeConstraints { make in
            make.top.equalTo(self.currentAssetLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(self.snp.centerX).offset(-8)
        }
        
        self.amountField.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(self.avgField)
        }
        
        self.purchasedLabel.snp.makeConstraints { make in
            make.left.equalTo(self.avgField)
            make.right.equalTo(self.amountField)
            make.top.equalTo(self.avgField.snp.bottom).offset(16)
            make.height.equalTo(40)
        }
        
        self.goalLabel.snp.makeConstraints { make in
            make.left.equalTo(self.currentAssetLabel)
            make.top.equalTo(self.purchasedLabel.snp.bottom).offset(32)
        }
        
        self.warningLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.goalLabel)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.goalPLRateField.snp.makeConstraints { make in
            make.left.right.equalTo(self.purchasedLabel)
            make.top.equalTo(self.goalLabel.snp.bottom).offset(20)
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(self.goalPLRateField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func startSlimeAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 120
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.slimeImage.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopSlimeAnimation() {
        self.slimeImage.layer.removeAllAnimations()
    }
}

extension Reactive where Base: CalculatorView {
    
    var pl: Binder<(Int, Int)> {
        return Binder(self.base) { view, pl in
            view.emptyView.isHidden = pl.0 != 0
            view.yountchanView.isHidden = pl.0 == 0
            view.yountchanView.rx.pl.onNext(pl)
        }
    }
}
