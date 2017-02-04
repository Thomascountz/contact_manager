require 'rails_helper'

describe 'the person view', type: :feature do
  
  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }
  
  before(:each) do
    person.phone_numbers.create(number: '5555555555')
    person.phone_numbers.create(number: '5551234567')
    visit person_path(person)
  end
  
  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end
  
  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end
  
  it 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '5554443333')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('5554443333')
  end
  
  it 'has a link to edit phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end
  
  it 'edits a phone number' do
    phone = person.phone_numbers.first
    old_number = phone.number
    
    first(:link, 'edit').click
    page.fill_in('Number', with: '1111111111')
    page.click_button('Update Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('1111111111')
    expect(page).not_to have_content(old_number)
  end
  
  it 'has a link to delete phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end
end