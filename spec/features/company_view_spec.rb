require 'rails_helper'

describe 'the company view', type: :feature do
  
  describe 'phone numbers' do
    
    let(:company) { Company.create(name: 'MyCompany') }
    
    before(:each) do
      company.phone_numbers.create(number: '5555555555')
      company.phone_numbers.create(number: '5551234567')
      visit company_path(company)
    end
    
    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end
    
    it 'has a link to add a new phone number' do
      expect(page).to have_link(
        'Add phone number', 
        href: new_phone_number_path(
          contact_id: company.id, contact_type: 'Company'
          )
        )
    end
    
    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '5554443333')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('5554443333')
    end
    
    it 'has a link to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end
    
    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number
      
      first(:link, 'edit').click
      page.fill_in('Number', with: '1111111111')
      page.click_button('Update Phone number')
      
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('1111111111')
      expect(page).not_to have_content(old_number)
    end
    
    it 'has a link to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
    
    it 'deletes a phone number' do
      number = '5551112223'
      
      page.click_link('Add phone number')
      page.fill_in('Number', with: number)
      page.click_button('Create Phone number')
      
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(number)
      
      delete_links = page.all('a', :text => 'delete')
      delete_links.last.click
      
      expect(page).not_to have_content(number)
      expect(current_path).to eq(company_path(company))
    end
  end
  
  describe 'email addresses' do
    
    let(:company) { Company.create(name: 'MyCompany') }
    
    before(:each) do
      company.email_addresses.create(address: 'johndoe@gmail.com', contact_id: company.id, contact_type: 'Company')
      company.email_addresses.create(address: 'john.doe@gmail.com', contact_id: company.id, contact_type: 'Company')
      visit company_path(company)
    end
    
    it 'has a list of email addresses' do
      expect(page).to have_selector('li', text: 'johndoe@gmail.com')
    end
    
    it 'has a link to add new email address' do
      expect(current_path).to eq(company_path(company))
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end
    
    it 'adds an email address' do
      new_email = 'michael@gmail.com'
      
      page.click_link('Add email address')
      page.fill_in("Address", with: new_email)
      page.click_button("Create Email address")
      
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(new_email)
    end
    
    it 'has a link to update email address' do
      company.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address))
      end
    end
      
    it 'updates an email address' do
      new_email = "britney@gmail.com"
      
      first(:link, 'edit').click
      page.fill_in("Address", with: new_email)
      page.click_button("Update Email address")
      
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(new_email)
      
    end
    
    it 'has a link to delete email address' do
      company.email_addresses.each do |address|
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end
    
    it 'deletes an email address' do
      email = 'NewEmailAddress'
      
      page.click_link('Add email address')
      page.fill_in('Address', with: email)
      page.click_button('Create Email address')
      
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(email)
      
      delete_links = page.all('a', :text => 'delete')
      delete_links.last.click
      
      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(email)
    end
    
  end
  
end