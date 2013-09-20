require 'version'

class Version::Component
  attr_accessor :digits
  attr_accessor :letter
  
  #
  # Creates a single Component of a version, consisting of digits and
  # possibly a letter. For example, +1+, +3a+, +12+, or +0+.
  #
  def initialize(component)
    parts = component.split /(?=\D)/
    self.digits = parts[0].to_i
    self.letter = parts[1..-1].join('')
  end
  
  def initialize_copy(other)
    self.digits = other.digits
    self.letter = other.letter.dup
  end
  
  def prerelease?
    !(self.letter.empty? || self.letter.include?('rc'))
  end

  def rc?
    self.letter.include?('rc')
  end

  def has_suffix?
    !self.letter.empty?
  end
  
  def unprerelease!
    self.next! if self.has_suffix?
  end
  
  def next(suffix = nil)
    self.dup.next!(suffix)
  end
  
  def next!(suffix = nil)
    case suffix.to_s
      when 'pre'
        self.digits = self.rc? ? self.digits.next : self.digits
        self.letter = self.prerelease? ? self.letter.next : 'a'
      when 'rc'
        self.digits = self.rc? ? self.digits : self.digits
        self.letter = self.rc? ? self.letter.next : 'rc1'
      else
        self.digits = self.digits.next unless self.has_suffix?
        self.letter = '' if self.has_suffix?
    end
    self
  end
  
  def <=>(other)
    self.to_sortable_a <=> other.to_sortable_a
  end
  
  def to_sortable_a
    [ self.digits, self.prerelease? ? 0 : 1, self.letter ]
  end
  
  def to_a
    [ self.digits, self.letter ]
  end
  
  def to_i
    self.digits
  end
  
  def to_s
    self.to_a.join
  end
  
  def inspect
    self.to_s.inspect
  end
end
