require 'rails_helper'

feature 'Make a new task', :js => true do
  scenario 'We can add a new task by entering its description in the textfield and pressing the enter key' do
    #point your browser towards the todo path
    visit todos_path
    #enter description in the textfield
    fill_in 'new-todo', with: 'NEW TASK'
    #press enter (submit the form)
    page.execute_script("$('form').submit()")

    #now test #2 A new task is displayed in the list of tasks
    expect(page).to have_content('NEW TASK')
  end
  scenario 'counts change' do
    make_new_task 'i can has cheeseburger'
    expect(page).to have_content('i can has cheeseburger')
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    #click the content
    #it should get the state done
  end

  def make_new_task description
    visit todos_path
    fill_in 'new-todo', with: description
    page.execute_script("$('form').submit()")
  end
end