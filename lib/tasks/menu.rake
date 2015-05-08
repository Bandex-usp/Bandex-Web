namespace :menu do

  desc "Fetch the semanal menu"
  task fetch: :environment do
  	require 'MenuHtmlParser'
  	require 'MenuInsertDB'

  	menu = getMenu(nil)
  	insertIntoDatabase(menu, 'central')

  	menu = getMenu('quimica')
  	insertIntoDatabase(menu, 'quimica')

  	menu = getMenu('fisica')
  	insertIntoDatabase(menu, 'fisica')
  end

end
