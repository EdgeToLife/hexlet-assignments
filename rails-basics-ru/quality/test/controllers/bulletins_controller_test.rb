require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  # Rails автоматически используют транзакционные тесты
  # self.use_transactional_tests = false
  test 'opens all bulletins page' do
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'opens one bulletin page' do
    bulletin = Bulletin.create(title: "Bulletin 1", body: "Body of the bulletin 1")
    get bulletin_url(bulletin.id)
    assert_response :success
    assert_select 'h1', 'Bulletin 1'
    assert_select 'p', 'Body of the bulletin 1'
  end

  test 'opens one bulletin page with fixture' do
    bulletin = bulletins(:one)
    get bulletin_url(bulletin.id)
    assert_response :success
    assert_select 'h1', 'Bulletin 1'
    assert_select 'p', 'Body of the bulletin 1'
  end
end
