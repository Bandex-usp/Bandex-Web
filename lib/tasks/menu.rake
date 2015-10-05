namespace :menu do
  
  desc "Fetch the menu"
  task fetch: :environment do
    require 'menu_fetcher'

    MenuFetcher::get_menu
  end
end
