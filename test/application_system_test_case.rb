require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def log_in_admin
    visit root_url
    fill_in("Korisničko ime", with: "zvjezdana")
    fill_in("Lozinka", with: "zvjezdana")
    click_button("Prijavi se")
  end
  
end
