require 'rails_helper'

describe 'the person view', type: :feature do
  
  describe 'phone numbers' do
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
    
    it 'deletes a phone number' do
      number = '5551112223'
      
      page.click_link('Add phone number')
      page.fill_in('Number', with: number)
      page.click_button('Create Phone number')
      
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content(number)
      
      delete_links = page.all('a', :text => 'delete')
      delete_links.last.click
      
      expect(page).not_to have_content(number)
    end
  end
  
  describe 'email addresses' do
    
    let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }
    
    before(:each) do
      person.email_addresses.create(address: 'johndoe@gmail.com')
      person.email_addresses.create(address: 'john.doe@gmail.com')
      visit person_path(person)
    end
    
    it 'has a list of email addresses' do
      expect(page).to have_selector('li', text: 'johndoe@gmail.com')
    end
    
    it 'has a link to add new email address' do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
    end
    
    xit 'adds an email address' do
      new_email = 'michael@gmail.com'
      
      page.click_link('Add email address')
      page.fill_in("Address", with: new_email)
      page.click_button("Create Email address")
      
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content(new_email)
    end
  end
end