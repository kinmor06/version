require 'spec_helper'

describe Version, '0.10.0' do
  include ImplicitVersion
  
  subject { v0_10_0 }
  
  its(:major)       { should == '0'   }
  its(:minor)       { should == '10'  }
  its(:revision)    { should == '0'   }
  its(:prerelease?) { should be_false }
  its(:rc?)         { should be_false }
  
  it 'should bump to 0.10.1' do
    subject.bump!.should == v0_10_1
  end
  
  it 'should major-bump to 1.0.0' do
    subject.bump!(:major).should == v1_0_0
  end
  
  it 'should minor-bump to 0.11.0' do
    subject.bump!(:minor).should == v0_11_0
  end
  
  it 'should revision-bump to 0.10.1' do
    subject.bump!(:revision).should == v0_10_1
  end
  
  it 'should prerelease-bump to 0.10.1a' do
    subject.bump!(:pre).should == v0_10_1a
  end
  
  it 'should prerelease-bump major to 1.0.0a' do
    subject.bump!(:major, :pre).should == v1_0_0a
  end
  
  it 'should prerelease-bump minor to 0.11.0a' do
    subject.bump!(:minor, :pre).should == v0_11_0a
  end
  
  it 'should prerelease-bump revision to 0.10.1a' do
    subject.bump!(:revision, :pre).should == v0_10_1a
  end

  it "RC releases to 0.10.1rc1" do
    subject.bump!(:rc).should == '0.10.1rc1'
  end

  it "RC major bumps to 1.0rc1" do
    subject.bump!(:major, :rc).should == '1.0.0rc1'
  end

  it "RC minor bumps to 0.11.0rc1" do
    subject.bump!(:minor, :rc).should == '0.11.0rc1'
  end

  it "RC revision bumps to 0.10.1rc1" do
    subject.bump!(:revision, :rc).should == '0.10.1rc1'
  end
end
