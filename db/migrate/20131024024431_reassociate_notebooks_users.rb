class ReassociateNotebooksUsers < ActiveRecord::Migration
  def up
    notebooks = Notebook.all
    notebooks.each do |n|
      execute("INSERT INTO notebooks_users (notebook_id, user_id) VALUES (#{n.id}, #{n.owner_id})")
    end
  end

  def down
    execute('DELETE * FROM notebooks_users')
  end
end
