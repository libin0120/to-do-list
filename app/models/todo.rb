class Todo < ApplicationRecord
  # ----------------------------------------------------------------------------
  # --------------------  includes

  # --------------------  constants definition

  # --------------------  validates
  validates :task, presence: true # Must has a task title, and deadline
  validate :proper_deadline?, on: :create


  # --------------------  attributes

  # --------------------  default values

  # --------------------  relationships

  # --------------------  nested attributes

  # --------------------  scopes
  scope :completed, -> { where(completed: true)}
  scope :un_completed, -> { where(completed: false)}


  # --------------------  call backs

  # update parent
  after_save do
    if parent # only if we have parent
      parent_completed = true
      parent.children.each do |c|
        parent_completed &&= c.completed
      end
      parent.update_column(:completed, parent_completed)
    end
  end


  # update children
  after_save do
    if children
      children.each do |c|
        c.update_column(:completed, self.completed)
      end
    end
  end

  # --------------------  attachments

  # --------------------  functions (call back)

  # --------------------  functions (validation)

  # --------------------  functions (attributes)

  # --------------------  class methods

  # --------------------  extra

  acts_as_tree order: 'task'

  # --------------------  public
  public

  def overdue?
    !completed && (deadline && deadline < Date.today)
  end

  # --------------------  protected
  protected
  # --------------------  private
  private

  def proper_deadline?
    if deadline
      errors.add(:deadline, 'deadline must be greater than today') if deadline <  Date.today
    end
  end

  # ----------------------------------------------------------------------------
end
