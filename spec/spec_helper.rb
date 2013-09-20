$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'version'

module ImplicitVersion
  def method_missing(name, *args, &block)
    super unless args.empty?
    super unless block.nil?
    super unless name.to_s =~ /^v[\d\w_]+$/
    
    name.to_s.gsub(/^v/, '').gsub(/_/, '.').to_version
  end
end

RSpec.configure do |config|
end
