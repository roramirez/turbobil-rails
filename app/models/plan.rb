class Plan < ActiveRecord::Base
  belongs_to :admin

  def to_s
    name + ' | lines:' + extens.to_s + '| days:'  + days.to_s + ' |mount:' + mount.to_s
  end

end
