require 'spec_helper'

describe Version, '1.6.3a' do
  include ImplicitVersion
  
  subject { v1_6_3a }
  
  its(:major)       { should == '1'   }
  its(:minor)       { should == '6'   }
  its(:revision)    { should == '3a'  }
  its(:prerelease?) { should be_true  }
  its(:rc?)         { should be_false }
  
  it 'should bump to 1.6.3' do
    subject.bump!.should == v1_6_3
  end
  
  it 'should major-bump to 2.0.0' do
    subject.bump!(:major).should == v2_0_0
  end
  
  it 'should minor-bump to 1.7.0' do
    subject.bump!(:minor).should == v1_7_0
  end
  
  it 'should revision-bump to 1.6.3' do
    subject.bump!(:revision).should == v1_6_3
  end
  
  it 'should prerelease-bump to 1.6.3b' do
    subject.bump!(:pre).should == v1_6_3b
  end
  
  it 'should prerelease-bump major to 2.0.0a' do
    subject.bump!(:major, :pre).should == v2_0_0a
  end
  
  it 'should prerelease-bump minor to 1.7.0a' do
    subject.bump!(:minor, :pre).should == v1_7_0a
  end
  
  it 'should prerelease-bump revision to 1.6.4a' do
    subject.bump!(:revision, :pre).should == v1_6_4a
  end

  it "RC releases to 1.6.3rc1" do
    subject.bump!(:rc).should == '1.6.3rc1'
  end

  it "RC major bumps to 2.0.0rc1" do
    subject.bump!(:major, :rc).should == '2.0.0rc1'
  end

  it "RC minor bumps to 1.7.0rc1" do
    subject.bump!(:minor, :rc).should == '1.7.0rc1'
  end

  it "RC revision bumps to 1.6.4rc1" do
    subject.bump!(:revision, :rc).should == '1.6.4rc1'
  end
end

describe Version, '1.6a' do
  include ImplicitVersion
  
  subject { v1_6a }
  
  its(:major)       { should == '1'  }
  its(:minor)       { should == '6a'  }
  its(:revision)    { should == nil }
  its(:prerelease?) { should be_true }
  its(:rc?)         { should be_false }
  
  it 'should bump to 1.6' do
    subject.bump!.should == v1_6
  end
  
  it 'should major-bump to 2.0' do
    subject.bump!(:major).should == v2_0
  end
  
  it 'should minor-bump to 1.6' do
    subject.bump!(:minor).should == v1_6
  end
  
  it 'should revision-bump to 1.6.1' do
    subject.bump!(:revision).should == v1_6_1
  end
  
  it 'should bump to 1.6b' do
    subject.bump!(:pre).should == v1_6b
  end
  
  it 'should prerelease-bump major to 2.0a' do
    subject.bump!(:major, :pre).should == v2_0a
  end
  
  it 'should prerelease-bump minor to 1.7a' do
    subject.bump!(:minor, :pre).should == v1_7a
  end
  
  it 'should prerelease-bump revision to 1.6.1a' do
    subject.bump!(:revision, :pre).should == v1_6_1a
  end

  it "RC releases to 1.6rc1" do
    subject.bump!(:rc).should == '1.6rc1'
  end

  it "RC major bumps to 2.0rc1" do
    subject.bump!(:major, :rc).should == '2.0rc1'
  end

  it "RC minor bumps to 1.7rc1" do
    subject.bump!(:minor, :rc).should == '1.7rc1'
  end

  it "RC revision bumps to 1.6.1rc1" do
    subject.bump!(:revision, :rc).should == '1.6.1rc1'
  end
end