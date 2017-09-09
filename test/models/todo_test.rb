require 'test_helper'

class TodoTest < ActiveSupport::TestCase

  def test_fail_to_create_task_with_no_title

    todo = todos(:one)

    todo.task = nil

    r = todo.save

    assert_equal r, false
  end

  def test_fail_to_update_task_with_no_title

    todo = create(:todo)

    todo.task = nil

    r = todo.save

    assert_equal r, false
  end

  def test_fail_to_create_task_with_past_deadline

    todo = build(:todo)

    todo.deadline = Date.today - 3

    r = todo.save

    assert_equal r, false
  end

  def test_success_update_existing_task_with_past_deadline
    todo = create(:todo)

    todo.deadline = Date.today - 3

    r = todo.save

    assert_equal r, true
 end


  def test_success_create_regular_task
    todo = todos(:one)

    r = todo.save

    assert_equal r, true
  end

  def test_success_update_regular_task
    todo = create(:todo)

    todo.details = 'here is new details'

    r = todo.save

    assert_equal r, true
  end

  def test_success_delete_regular_task
    todo = create(:todo)
    count_before = Todo.count

    todo.destroy

    count_after = Todo.count

    assert_equal count_before - 1, count_after
  end


  def test_task_is_overdue
    todo = create(:todo)

    todo.deadline = Date.today - 3

    assert_equal todo.overdue?, true
  end

  def test_task_is_not_overdue_if_there_is_no_deadline
    todo = create(:todo)

    todo.deadline = nil

    refute_equal todo.overdue?, true
  end

  def test_task_is_not_overdue_if_completed
    todo = create(:todo)

    todo.deadline = Date.today - 3

    todo.completed = true

    refute_equal todo.overdue?, true
  end

  def test_count_of_completed_or_uncompleted_tasks

    todo1 = create(:todo)
    todo2 = create(:todo)
    todo3 = create(:todo)

    todo1.completed = true
    todo1.save

    todo2.completed = true
    todo2.save

    assert_equal Todo.completed.count, 2

    assert_equal Todo.un_completed.count, Todo.count - Todo.completed.count
  end


  def test_children_udpate_parent
    parent = create(:todo)
    c1 = create(:todo)
    c2 = create(:todo)
    c3 = create(:todo)

    parent.children << c1
    parent.children << c2
    parent.children << c3

    c1.update_attribute(:completed, true)
    c2.update_attribute(:completed, true)
    c3.update_attribute(:completed, true)

    parent.reload
    assert_equal parent.completed, true

    c3.update_attribute(:completed, false)

    parent.reload
    assert_equal parent.completed, false

    c3.update_attribute(:completed, true)

    parent.reload
    assert_equal parent.completed, true
  end

  def test_parent_udpate_children
    parent = create(:todo)
    c1 = create(:todo)
    c2 = create(:todo)
    c3 = create(:todo)

    parent.children << c1
    parent.children << c2
    parent.children << c3

    c1.update_attribute(:completed, false)
    c2.update_attribute(:completed, true)
    c3.update_attribute(:completed, false)

    parent.update_attribute(:completed, true)

    c1.reload
    c2.reload
    c3.reload

    assert_equal c1.completed,  true
    assert_equal c2.completed,  true
    assert_equal c3.completed,  true

    parent.update_attribute(:completed, false)

    c1.reload
    c2.reload
    c3.reload

    assert_equal c1.completed,  false
    assert_equal c2.completed,  false
    assert_equal c3.completed,  false
  end

end
