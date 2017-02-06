require 'rails_helper'

RSpec.describe Person, type: :model do
    
  let(:person) do
    Person.create(first_name: 'Jane', last_name: 'Smith')
  end
  
  it 'is valid' do
    expect(person).to be_valid
  end
  
  it 'is invalid without a first name' do
   person.first_name = nil
   expect(person).not_to be_valid
  end
  
  it 'is invalid without a last name' do
    person.last_name = nil
    expect(person).not_to be_valid
  end
  
  # it 'has an array of phone numbers' do
  #   expect(person.phone_numbers).to eq([])
  # end
  
  it 'responds with its created phone numbers' do
    phone_number = person.phone_numbers.create(number: '7654321123')
    expect(phone_number.number).to eq('7654321123')
    # expect(person.phone_numbers.map(&:number)).to eq(['7654321123'])
  end
  
  # it 'has an array of email addresses' do
  #   expect(person.email_addresses).to eq([])
  # end
  
  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'Tony@gmail.com')
    expect(person.email_addresses.map(&:address)).to eq(['Tony@gmail.com'])
  end
  
end
