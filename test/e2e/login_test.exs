defmodule HoundPlayground.LoginTest do
  use HoundPlayground.ConnCase
  use Hound.Helpers

  hound_session

  defp login_index do
    login_url(HoundPlayground.Endpoint, :index)
  end

  defp secure_index do
    secure_url(HoundPlayground.Endpoint, :index)
  end


  test "invalid username" do
    login_index() |> navigate_to()

    form = find_element(:id, "login")
    username = find_within_element(form, :id, "username")
    submit = find_within_element(form, :class, "btn-lg")

    username |> fill_field("john")
    submit |> click()

    alert = find_element(:xpath, ~s|//p[contains(@class, 'alert-danger')]|)
    alert_text = visible_text(alert)

    assert alert_text == "Your username is invalid!"
    assert current_url() == login_index()
  end

  test "correct username, invalid password" do
    navigate_to(login_index())

    form = find_element(:id, "login")
    username = find_within_element(form, :id, "username")
    password = find_within_element(form, :id, "password")
    submit = find_within_element(form, :class, "btn-lg")

    username |> fill_field("tomsmith")
    password |> fill_field("wrong")
    submit |> click()

    alert = find_element(:xpath, ~s|//p[contains(@class, 'alert-danger')]|)
    alert_text = visible_text(alert)

    assert alert_text == "Your password is invalid!"
    assert current_url() == login_index()
  end

  test "cannot access secure without logging in" do
    navigate_to(secure_index())
    assert current_url() == login_index()
  end

  test "correct username and password" do
    navigate_to(login_index())

    form = find_element(:id, "login")
    username = find_within_element(form, :id, "username")
    password = find_within_element(form, :id, "password")
    submit = find_within_element(form, :class, "btn-lg")

    username |> fill_field("tomsmith")
    password |> fill_field("SuperSecretPassword!")
    submit |> click()

    alert = find_element(:xpath, ~s|//p[contains(@class, 'alert-info')]|)
    alert_text = visible_text(alert)

    assert alert_text == "You logged into a secure area!"
    assert current_url() == secure_index()
  end

  test "clearing cookies causes logout" do
    navigate_to(login_index())

    form = find_element(:id, "login")
    username = find_within_element(form, :id, "username")
    password = find_within_element(form, :id, "password")
    submit = find_within_element(form, :class, "btn-lg")

    username |> fill_field("tomsmith")
    password |> fill_field("SuperSecretPassword!")
    submit |> click()

    delete_cookies()
    refresh_page()

    assert current_url() == login_index()
  end

end
