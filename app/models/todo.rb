class Todo < ApplicationRecord
  # ----------------------------------------------------------------------------
  # --------------------  includes

  # --------------------  constants definition

  # --------------------  validates
  validates :task, presence: true # Must has a task title, and deadline


  # --------------------  attributes

  # --------------------  default values

  # --------------------  relationships

  # --------------------  nested attributes

  # --------------------  scopes
  scope :completed, -> { where(completed: true)}


  # --------------------  call backs

  # --------------------  attachments

  # --------------------  functions (call back)

  # --------------------  functions (validation)

  # --------------------  functions (attributes)

  # --------------------  class methods

  # --------------------  extra


  # --------------------  public
  public

  def overdue?
    !completed && (deadline && deadline < Date.today)
  end

  # --------------------  protected
  protected
  # --------------------  private
  private

  # ----------------------------------------------------------------------------
end
