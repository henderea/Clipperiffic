module Info
  module_function

  class Version
    def initialize(version)
      @version = version || '0.0'
    end

    def <=>(other)
      other = Version.new(other && other.to_s)
      p     = parts
      op    = other.parts
      p <=> op
    end

    def <(other)
      (self <=> other) < 0
    end

    def <=(other)
      (self <=> other) <= 0
    end

    def ==(other)
      (self <=> other) == 0
    end

    def >(other)
      (self <=> other) > 0
    end

    def >=(other)
      (self <=> other) >= 0
    end

    def parts
      @version.gsub(/^(\d+)([^.]*)$/, '\1.0.0\3').gsub(/^(\d+)\.(\d+)([^.]*)$/, '\1.\2.0\3').gsub(/\.(\d+)b(\d+)$/, '.-1.\1.\2').split(/\./).map(&:to_i)
    end

    def to_s
      @version
    end
  end

  def version
    @version ||= Version.new(NSBundle.mainBundle.infoDictionary['CFBundleShortVersionString'])
  end

  def last_version
    @last_version ||= Version.new(self.version.to_s)
  end

  def last_version=(last_version)
    @last_version = Version.new(last_version || self.version.to_s)
  end

  def os_version
    @os_version ||= Version.new(MemInfo.getOSVersion)
  end

  class Supports
    attr_reader :nc, :mavericks

    def initialize
      @nc        = (NSClassFromString('NSUserNotificationCenter')!=nil)
      @mavericks = Info.os_version >= '13'
    end
  end

  def supports
    @supports ||= Supports.new
  end

  def has_nc?
    supports.nc
  end

  def mavericks?
    supports.mavericks
  end

  def license_log_status
    @license_log_status ||= :not_logged
  end

  def license_log_status=(status)
    @license_log_status = status
  end
end