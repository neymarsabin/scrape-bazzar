require 'rails_helper'

RSpec.describe Product, :type => :model do

  subject {
    described_class.new(
      url: 'https://hamrobazaar.com/i2148426-sony-wf1000xm3.html',
      title: 'Sony Wf-1000xm3',
      description: 'Packed with advanced audio technology, the WF-1000XM3 noise-canceling earbuds not only deliver noise-free listening but also offer breathtaking sound quality.',
      mobile_number: '9810390548',
      price: '26000'
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_uniqueness_of(:url) }
    it { should allow_value(subject.url).for(:url) }
    it { should_not allow_value("https://hamrobazaar.com/some-url.html").for(:url) }
    it { should_not allow_value("https://hamrobazaar.com/i33453-.html").for(:url) }
  end

end
