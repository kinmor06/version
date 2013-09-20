require 'spec_helper'

describe Version, '2.9' do
  include ImplicitVersion
  
  subject { v2_9 }
  
  its(:major)       { should == '2'   }
  its(:minor)       { should == '9'   }
  its(:revision)    { should be_nil   }
  its(:prerelease?) { should be_false }
  its(:rc?)         { should be_false }
  
  it 'should bump to 2.10' do
    subject.bump!.should == v2_10
  end
  
  it 'should major-bump to 3.0' do
    subject.bump!(:major).should == v3_0
  end
  
  it 'should minor-bump to 2.10' do
    subject.bump!(:minor).should == v2_10
  end
  
  it 'should revision-bump to 2.9.1' do
    subject.bump!(:revision).should == v2_9_1
  end

  it 'should prerelease-bump to 2.10a' do
    subject.bump!(:pre).should == v2_10a
  end
  
  it 'should prerelease-bump major to 3_0a' do
    subject.bump!(:major, :pre).should == v3_0a
  end
  
  it 'should prerelease-bump minor to 2.10a' do
    subject.bump!(:minor, :pre).should == v2_10a
  end
  
  it 'should prerelease-bump revision to 2.9.1a' do
    subject.bump!(:revision, :pre).should == v2_9_1a
  end

  it "RC releases to 2.10rc1" do
    subject.bump!(:rc).should == '2.10rc1'
  end

  it "RC major bumps to 3.0rc1" do
    subject.bump!(:major, :rc).should == '3.0rc1'
  end

  it "RC minor bumps to 2.10rc1" do
    subject.bump!(:minor, :rc).should == '2.10rc1'
  end

  it "RC revision bumps to 2.9.1rc1" do
    subject.bump!(:revision, :rc).should == '2.9.1rc1'
  end

end