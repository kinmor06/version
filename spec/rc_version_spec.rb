require 'spec_helper'

describe Version, '3.2.5rc1' do
  include ImplicitVersion
  
  subject { '3.2.5rc1'.to_version }
  
  its(:major)       { should == '3'   }
  its(:minor)       { should == '2'   }
  its(:revision)    { should == '5rc1'  }
  its(:prerelease?) { should be_false }
  its(:rc?)         { should be_true }
  
  it 'should bump to 3.2.5' do
    subject.bump!.should == '3.2.5'
  end
  
  it 'should major-bump to 4.0.0' do
    subject.bump!(:major).should == v4_0_0
  end
  
  it 'should minor-bump to 3.3.0' do
    subject.bump!(:minor).should == '3.3.0'
  end
  
  it 'should revision-bump to 3.2.5' do
    subject.bump!(:revision).should == '3.2.5'
  end
  
  it 'should prerelease-bump to 3.2.6a' do
    subject.bump!(:pre).should == '3.2.6a'
  end
  
  it 'should prerelease-bump major to 4.0.0a' do
    subject.bump!(:major, :pre).should == '4.0.0a'
  end
  
  it 'should prerelease-bump minor to 3.3.0a' do
    subject.bump!(:minor, :pre).should == '3.3.0a'
  end
  
  it 'should prerelease-bump revision to 3.2.6a' do
    subject.bump!(:revision, :pre).should == '3.2.6a'
  end

  it "RC releases to 3.2.5rc2" do
    subject.bump!(:rc).should == '3.2.5rc2'
  end

  it "RC major bumps to 4.0.0rc1" do
    subject.bump!(:major, :rc).should == '4.0.0rc1'
  end

  it "RC minor bumps to 3.3.0rc1" do
    subject.bump!(:minor, :rc).should == '3.3.0rc1'
  end

  it "RC revision bumps to 3.2.6rc1" do
    subject.bump!(:revision, :rc).should == '3.2.6rc1'
  end
end