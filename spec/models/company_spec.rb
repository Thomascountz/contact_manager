require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { Company.create(name: 'Rune') }
  
  it 'is valid' do
    expect(company).to be_valid
  end
  
  it 'is invalid witout a name' do
    company.name = nil
    expect(company).to_not be_valid
  end
  
  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end
  
  it 'responds to its created phone numbers' do
    phone_number = company.phone_numbers.create(number: '1112223334')
    expect(phone_number.number).to eq('1112223334')
  end
  
  it 'responds to its created email address' do
    email_address = company.email_addresses.create(address: 'Rune@gmail.com')
    expect(email_address.address).to eq('Rune@gmail.com')
  end
end
