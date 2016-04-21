#Integration testing

## With RSpec and Capybara

Important links
RSPEC, Capybara, Wouters repository

Integration testing is all about testing our business rules and giant guineapigs.

So let us start with the rules and leave the giant guineapigs for now.

We have previously created a simple todo app. Even simple apps need some rules/behaviours.
If we look at the app and work with it we can distingiush the following rules

1. We can add a new task by entering its description in the textfield and pressing the enter key
2. A new task is displayed in the list of tasks
3. A counter at the bottom keeps track of the amount of open tasks
4. We can complete a task by clicking its description
5. We can complete a task by clicking the checkbox infront of it
6. A completed task has both a crossed trough description and a checked checkbox, regardless of the way it as been completed
7. There is a counter of completed tasks in the bottom. This counter is updated when a task is completed
8. The counter for open tasks is also updated when a task is closed.
9. We can clean up our task list by clicking the clear button
10. The clear button removes all tasks from our list
11. The counter for completed tasks is updated accordingly
12. No finished tasks should be remaining in the list

Testing these business rules is called integration testing. Also known as feature testing or end to end testing

Just like with the ruby testing we did earlier, we can use RSpec to describe our tests.

Let us start by setting up our environment for this exercise.

We need 2 gems and the browser known as FireFox. Also we are using the repo for todo-jquery-ajax-example.

1. Go to https://github.com/Codaisseur/todos-jquery-ajax-example
2. Fork the repositor
3. Clone your version of the repository to local drive

Integration testing, also known as END TO END testing
We will do integration testing with Capybara and RSPEC.
Capybara is like a giant guineapig, also known as watervarken in surinam
A capybara looks like this <insert picture of a capybara with a beard>.
Capybaras are herbivores, grazing mainly on grasses and aquatic plants as well as fruit and tree bark.

They are also very good at testing software.

When a capybara tests your software you get a warm fuzzy feeling inside

Also you need a [firefox](Link to the firefox website).

Install gems

```ruby
gem 'capybara'
gem 'rspec'
gem 'selenium-webdriver'
```

```bash
$ bundle
$ rake db:create && rake db:migrate && rake db:seed
$ rails g rspec:install
rails s
```

Navigate your browser to: http://localhost:3000/todos

Now we have set up for regular rspec but not yet for capybara.
To support capybara we need to add the gem to our rspec test helpers and the rails helper

```
require 'capybara/rails' => rails helper
```

Now let us create some tests for each of the 12 behaviours listed above.

Our tests will go into the feature folder

Lets start with a test to test 1 & 2
1. We can add a new task by entering its description in the textfield and pressing the enter key
2. A new task is displayed in the list of tasks

```ruby
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
```
A scenario is a `TODO`

We can extend these test by adding scenario's

Lets add a scenario for
