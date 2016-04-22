# Integration testing

## With RSpec and Capybara

Important links

- [RSpec](https://github.com/rspec/rspec) 
- [Capybara](https://github.com/jnicklas/capybara) 
- [TODO repository](https://github.com/Codaisseur/todos-jquery-ajax-example)

Integration testing is all about testing our business rules and giant guineapigs.
For later reference, complete source can be found on github at https://github.com/hezus/todos-jquery-ajax-example

So let us start with the rules and leave the giant guineapigs for now.

We have previously created a simple todo app. Even simple apps need some rules/behaviours.
If we look at the app and work with it we can distingiush the following rules

> 1. We can add a new task by entering its description in the textfield and pressing the enter key
> 2. A new task is displayed in the list of tasks
> 3. A counter at the bottom keeps track of the amount of open tasks
> 4. We can complete a task by clicking its description
> 5. We can complete a task by clicking the checkbox in front of it
> 6. There is a counter of completed tasks in the bottom. This counter is updated when a task is completed
> 7. The counter for open tasks is also updated when a task is closed.
> 9. We can clean up our task list by clicking the clear button
> 10. The clear button removes all completed tasks from our list
> 11. The counter for completed tasks is updated accordingly
> 12. No finished tasks should be remaining in the list

Testing these business rules is called integration testing. Also known as feature testing or end to end testing

Just like with the ruby testing we did earlier, we can use RSpec to describe our tests.

Let us start by setting up our environment for this exercise.

We need 2 gems and the browser known as FireFox. Also we are using the repo for todo-jquery-ajax-example.

1. Go to https://github.com/Codaisseur/todos-jquery-ajax-example
2. Fork the repositor
3. Clone your version of the repository to local drive

Integration testing, also known as END TO END testing
We will do integration testing with Capybara and RSPEC.
Capybara is like a giant guineapig, also known as watervarken

![Capybara](http://3.bp.blogspot.com/-eE8DaUiiAOw/VUxl6fwmnbI/AAAAAAAADos/uYALyPU1-eQ/s1600/capybara_custamization_test_automation.jpg)

Capybaras are herbivores, grazing mainly on grasses and aquatic plants as well as fruit and tree bark.

They are also very good at testing software.

When a capybara tests your software you get a warm fuzzy feeling inside

Also you need a [firefox](https://www.mozilla.org/en-US/firefox/new/).

Install gems

```ruby
gem 'capybara'
gem 'rspec'
gem 'selenium-webdriver'
```

install the new bundle, create the database and tests if the project starts.

```bash
$ bundle
$ rake db:create && rake db:migrate && rake db:seed
$ rails g rspec:install
rails s
```

Navigate your browser to [localhost](http://localhost:3000/todos)

Now we have set up for rspec but not yet for capybara.
To support capybara we need to add it to our test helpers

Add the following two imports in spec/rails_helper.rb after the line that says: `# Add additional requires below this line. Rails is not loaded until this point!`

```
require 'capybara/rspec'
require 'capybara/rails'
```

Now let us create some tests for each of the behaviours in the list above.

Integration tests go into the `spec/feature` folder 

Lets start with a test to test the first two behaviours
1. We can add a new task by entering its description in the textfield and pressing the enter key
2. A new task is displayed in the list of tasks

Any integration test file looks like this:

```ruby
require 'rails_helper'

feature 'Description of the feature', :js => true do
end
```

## 1. So lets make a first test

```ruby
require 'rails_helper'

feature 'Manage tasks', :js => true do
  scenario 'We can add a new task' do
    #point your browser towards the todo path
    visit todos_path
    #enter description in the textfield
    fill_in 'new-todo', with: 'Be Batman'
    #press enter (submit the form)
    page.execute_script("$('form').submit()")
    #now test #2 A new task is displayed in the list of tasks
    expect(page).to have_content('Be Batman')
  end
end
```
A scenario is a block. a scenario can contain one or multiple expectations.

We run the test with `rspec -fd`

## 2. Lets add a scenario for checking the count change (behaviour 3)

```ruby
scenario 'todo count change' do
  visit todos_path
  fill_in 'new-todo', with: 'i can has cheeseburger'
  page.execute_script("$('form').submit()")
  expect( page.find(:css, 'span#todo-count').text ).to eq "1"
end
```
As you can see we use a method, the `page.find` method which can accept various types of arguments. 
In this case we use a simple css selector to get the value of the todo-count element.

Run the test again `rspec -fd`

## 3. Lets make some feature tests for completing a task.

A important aspect of testing, which i'm sure Miriam has told you, is that all tests should be able to run independent and the order is changed each time.

So we create a new task again, and then complete it by checking the checkbox. 

```ruby
require 'rails_helper'

feature 'Manage tasks', :js => true do
  scenario 'counts change on check box' do
    visit todos_path
    fill_in 'new-todo', with: 'go to candy mountain'
    page.execute_script("$('form').submit()")
    check('todo-1')
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end
end  
```

## 4. There seems to be some repetition here. Clean up the code by extracting the repeating part with a method
## 5. Make a scenario that creates 3 tasks, finishes 2 of them and then checks the count of `total-count`, `completed-count` and `todo-count`
## 6. Same as the previous, but also click the #clean-up link and check the counts


