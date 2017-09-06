require 'test_helper'

class TodoTest < ActiveSupport::TestCase

  def test_no_title_todo_failure

    todo = todos(:one)

    todo.task = nil

    r = todo.save

    assert_equal r, false
  end


  def test_no_create_overdue_task_failure

    todo = build(:todo)

    todo.deadline = Date.today - 3

    byebug

    r = todo.save

    assert_equal r, false
  end


  def test_create_regular_task_success

    todo = todos(:one)

    r = todo.save

    assert_equal r, true
  end



end
