require('UILabel,UIColor,UIFont,UIStackView,UISlider,UIButton,MZTimerLabel,MDMainViewModel');
defineClass('MainViewController', null, {
    viewDidLoad: function() {
        self.super().viewDidLoad();

        self.bind();
    },
    setupUI: function() {

        self.view().addSubview(self.distractionLabel());
        self.view().addSubview(self.stackView());
        self.stackView().addArrangedSubview(self.timerLabel());
        self.stackView().addArrangedSubview(self.slider());
        self.stackView().addArrangedSubview(self.actionButton());

    },
    setupConstraints: function() {
        self.timerLabel().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.width().equalTo()(150);
        }));

        self.distractionLabel().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.centerX().equalTo()(self.view());
            make.centerY().equalTo()(self.view()).offset()(-80);
        }));

        self.stackView().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.bottom().equalTo()(self.view()).offset()(-100);
            make.centerX().equalTo()(self.view());
        }));
    },
    timerLabel_finshedCountDownTimerWithTime: function(timerLabel, countTime) {
        self.viewModel().stopMeditationFinish(YES);
        playAudio();
    },
    distractionLabel: function() {
        if (!self.getProp('distractionLabel')) {
            self.setProp_forKey(UILabel.new(), 'distractionLabel');
            self.getProp('distractionLabel').setTextColor(UIColor.lightGrayColor());
            self.getProp('distractionLabel').setTextAlignment(NSTextAlignmentCenter);
            self.getProp('distractionLabel').setFont(UIFont.boldSystemFontOfSize(85));
            self.getProp('distractionLabel').setText("0");
        }
        return self.getProp('distractionLabel');
    },
    timerLabel: function() {
        if (!self.getProp('timerLabel')) {
            self.setProp_forKey(UILabel.new(), 'timerLabel');
            self.getProp('timerLabel').setTextColor(UIColor.blackColor());
            self.getProp('timerLabel').setTextAlignment(NSTextAlignmentCenter);
            self.getProp('timerLabel').setFont(UIFont.systemFontOfSize(20));
            self.getProp('timerLabel').setText("00:00:00");
        }
        return self.getProp('timerLabel');
    },
    stackView: function() {
        if (!self.getProp('stackView')) {
            self.setProp_forKey(UIStackView.new(), 'stackView');
            self.getProp('stackView').setAxis(UILayoutConstraintAxisVertical);
            self.getProp('stackView').setSpacing(15);
        }
        return self.getProp('stackView');
    },
    slider: function() {
        if (!self.getProp('slider')) {
            self.setProp_forKey(UISlider.new(), 'slider');
            self.getProp('slider').setMaximumValue(60);
            self.getProp('slider').setMinimumValue(1);
            self.getProp('slider').setValue(15);
        }
        return self.getProp('slider');
    },
    actionButton: function() {
        if (!self.getProp('actionButton')) {
            self.setProp_forKey(UIButton.new(), 'actionButton');
            self.getProp('actionButton').setTitle_forState("开始", UIControlStateNormal);
            self.getProp('actionButton').setTitle_forState("结束", UIControlStateSelected);
            self.getProp('actionButton').setTitleColor_forState(UIColor.blueColor(), UIControlStateNormal);
        }
        return self.getProp('actionButton');
    },
    countDownTimer: function() {
        if (!self.getProp('countDownTimer')) {
            self.setProp_forKey(MZTimerLabel.alloc().initWithLabel_andTimerType(self.timerLabel(), MZTimerLabelTypeTimer), 'countDownTimer');
            self.getProp('countDownTimer').setDelegate(self);
        }
        return self.getProp('countDownTimer');
    },
    viewModel: function() {
        if (!self.getProp('viewModel')) {
            self.setProp_forKey(MDMainViewModel.new(), 'viewModel');
        }
        return self.getProp('viewModel');
    },
}, null, {
    viewDidLoad: 'void',
    setupUI: 'void',
    setupConstraints: 'void',
    timerLabel_finshedCountDownTimerWithTime: 'void,MZTimerLabel*,NSTimeInterval',
    distractionLabel: 'UILabel*',
    timerLabel: 'UILabel*',
    stackView: 'UIStackView*',
    slider: 'UISlider*',
    actionButton: 'UIButton*',
    countDownTimer: 'MZTimerLabel*',
    viewModel: 'MDMainViewModel*'
});