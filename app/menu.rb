class MainMenu
  extend EverydayMenu::MenuBuilder

  def self.def_items
    menuItem :status_update, 'Check for Updates'
    menuItem :status_version, 'Current Version: 0.0'
    # menuItem :status_review, 'Write a review'
    menuItem :status_quit, 'Quit', preset: :quit

    menuItem :status_preferences, 'Preferences'

    menuItem :status_license, 'Pro Registration', submenu: :license
    menuItem :license_display, 'Pro Not Registered'
    menuItem :license_change, 'Buy / Register Pro'
    menuItem :license_deactivate, 'Deactivate Pro License'

    menuItem :status_support, 'Support', submenu: :support
    menuItem :support_feedback, 'Provide Feedback'
    menuItem :support_twitter, 'Twitter'
  end

  def self.def_menus
    statusbarMenu(:statusbar, '', status_item_icon: NSImage.imageNamed('Status'), status_item_length: NSVariableStatusItemLength) {
      status_preferences
      ___
      status_license
      ___
      status_support
      ___
      status_update
      status_version
      ___
      # status_review
      # ___
      status_quit
    }

    menu(:license, 'Registration') {
      license_display
      license_change
      license_deactivate
    }

    menu(:support, 'Support') {
      support_feedback
      support_twitter
    }
  end

  def_menus
  def_items

  class << self
    def status_item
      MainMenu[:statusbar].statusItem
    end

    def set_license_display
      Thread.start {
        activated                                          = MotionPaddle.activated?
        MainMenu[:license].items[:license_display][:title] = activated ? MotionPaddle.activated_email : 'Pro Not Registered'
        MainMenu[:license].items[:license_change][:title]  = activated ? 'View Pro Registration' : 'Buy / Register Pro'
        Util.log_license
      }
    end
  end
end