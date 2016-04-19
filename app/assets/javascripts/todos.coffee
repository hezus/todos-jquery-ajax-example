# app/assets/javascripts/todos.coffee

$ ->
  $("input[type=checkbox]").bind 'change', toggleDone
  $("form").bind 'submit', submitTodo
  $("#clean-up").bind 'click', cleanUpDoneTodos

  updateCounters()

toggleDone = () ->
  $(this).parent().toggleClass "completed"
  updateCounters()

updateCounters = () ->
  $("#total-count").html $(".todo").length
  $("#completed-count").html $(".completed").length
  todo_count = $(".todo").length - $(".completed").length
  $("#todo-count").html todo_count

nextTodoId = () ->
  $(".todo").length + 1

createTodo = (title) ->
  checkboxId = "todo-#{nextTodoId()}"

  $("#todolist").append($("<li></li>")
    .addClass("todo")
    .append($('<input>')
      .attr 'type', 'checkbox'
      .attr 'id', checkboxId
      .val 1
      .bind 'change', toggleDone
      ).append(
        document.createTextNode " "
        ).append($('<label></label>')
          .attr 'for', checkboxId
          .html title))

  updateCounters();

submitTodo = (event) ->
  event.preventDefault()
  createTodo $("#new-todo").val()
  $("#new-todo").val null
  updateCounters()

cleanUpDoneTodos = (event) ->
  event.preventDefault()
  $.when($(".completed").remove())
    .then(updateCounters)
