module MenuActions
  module_function

  def setup
    setup_statusbar
    setup_license
    setup_support
  end

  def setup_statusbar
    # MainMenu[:statusbar].subscribe(:status_preferences) { |_, _| Prefs.shared_instance.show_window }
    MainMenu[:statusbar].subscribe(:status_quit) { |_, _| NSApp.terminate }
    MainMenu[:statusbar].subscribe(:status_update) { |_, sender| SUUpdater.sharedUpdater.checkForUpdates(sender) }
    # MainMenu[:statusbar].subscribe(:status_review) { |_, _| Util.open_link('http://www.macupdate.com/app/mac/51681/memorytamer') }
  end

  def setup_license
    MainMenu.set_license_display
    MainMenu[:license].subscribe(:license_change) { |_, _| MotionPaddle.show_licensing }
    MainMenu[:license].subscribe(:license_deactivate) { |_, _| MotionPaddle.deactivate_license }.canExecuteBlock { |_| MotionPaddle.activated? }
  end

  def setup_support
    MainMenu[:support].subscribe(:support_feedback) { |_, _| BITHockeyManager.sharedHockeyManager.feedbackManager.showFeedbackWindow }
    # MainMenu[:support].subscribe(:support_twitter) { |_, _| Util.open_link('https://twitter.com/MemoryTamer') }
  end
end