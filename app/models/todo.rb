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
