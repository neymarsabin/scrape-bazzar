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

    it "is invalid without url" do
      subject.url = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without description" do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without price" do
      subject.price = nil
      expect(subject).to_not be_valid
    end
  end
end
