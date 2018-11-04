require('UILabel,UIColor,UIFont');
defineClass('ViewController', null, {
    setupView: function() {
        self.timerLabel().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.width().equalTo()(150);
        }));

        self.view().addSubview(self.distractionLabel());
        self.distractionLabel().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.centerX().equalTo()(self.view());
            make.centerY().equalTo()(self.view()).offset()(-80);
        }));

        self.view().addSubview(self.stackView());
        self.stackView().addArrangedSubview(self.timerLabel());
        self.stackView().addArrangedSubview(self.slider());
        self.stackView().addArrangedSubview(self.actionButton());

        self.stackView().mas__makeConstraints(block('void, MASConstraintMaker*', function(make) {
            make.bottom().equalTo()(self.view()).offset()(-200);
            make.centerX().equalTo()(self.view());
        }));
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
}, null, {
    setupView: 'void',
    distractionLabel: 'UILabel*'
});