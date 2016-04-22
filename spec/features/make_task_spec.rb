require 'rails_helper'

feature 'Make a new task', :js => true do
  before(:each) do
    visit todos_path
  end
  scenario 'We can add a new task' do
    make_new_task 'All your base are belong to us'
    expect(page).to have_content('All your base are belong to us')
  end
  scenario 'counts change' do
    make_new_task 'i can has cheeseburger?'
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    make_new_task 'candy mountain'
    expect( page.find(:css, 'span#todo-count').text ).to eq "2"
  end
  scenario 'counts change on check box' do
    make_new_task 'candy mountain'
    check('todo-1')
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end
  scenario 'counts change on click label' do
    make_new_task 'i can has cheeseburger?'
    make_new_task 'candy mountain'
    find("label[for=todo-1]").click
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end
  scenario 'counts change on finish' do
    make_new_task 'i can has cheeseburger?'
    make_new_task 'candy mountain'
    make_new_task 'over 9000'
    expect(page).to have_selector('li.todo', count: 3)
    expect( page.find(:css, 'span#todo-count').text ).to eq "3"
    find("label[for=todo-1]").click
    find("label[for=todo-2]").click
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end
  scenario 'we can clear up tasks' do
    make_new_task 'i can has cheeseburger?'
    make_new_task 'candy mountain'
    make_new_task 'over 9000'
    expect(page).to have_selector('li.todo', count: 3)
    find("label[for=todo-1]").click
    find("label[for=todo-2]").click
    find("#clean-up").click
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end
  def make_new_task description
    fill_in 'new-todo', with: description
    page.execute_script("$('form').submit()")
  end
end